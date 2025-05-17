//
//  HomePageViewModel.swift
//  Prana
//
//  Created by Shubham Bhama on 16/05/25.
//

import Foundation

protocol HomePageViewModelProtocol: ObservableObject {
    func getHomePageData()
    func fetchHomePageQuotesFromOpenAI() async
}

final class HomePageViewModel: HomePageViewModelProtocol {
    @Published var homePageData: [HomePageCardModel] = .init()
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    @Published var outputLabel = ""
    
    let apiKey = "sk-proj-<OPEN_AI_API_KEY>"
    let systemPrompt = "You are an assistant who is deep knowledge about meditation and breathing techinique."
    let userInput = "Give me one quote for today related to breathing and meditation. Make sure this is maxmum 21 words long."
}

extension HomePageViewModel {
    
    func getHomePageData() {
        var listData: [HomePageCardModel] = .init()
        listData.append(
            HomePageCardModel(
                title: NSLocalizedString("Equal Breathing", comment: ""),
                subtitle: NSLocalizedString("Equal Breathing helps you to relax and focus.", comment: ""),
                backgroundColor: "#2e5d6c",
                footerAction:  NSLocalizedString("Change Duration", comment: "")
            )
        )
        listData.append(
            HomePageCardModel(
                title: NSLocalizedString("Box Breathing", comment: ""),
                subtitle: NSLocalizedString("Box Breathing is a powerful stress reliever.", comment: ""),
                backgroundColor: "#1a3950",
                footerAction:  NSLocalizedString("Change Duration", comment: "")
            )
        )
        listData.append(
            HomePageCardModel(
                title: NSLocalizedString("4-7-8 Breathing", comment: ""),
                subtitle: NSLocalizedString("4-7-8 Breathing promotes better sleep", comment: ""),
                backgroundColor: "#653f5f",
                footerAction:  NSLocalizedString("Change Duration", comment: "")
            )
        )
        listData.append(
            HomePageCardModel(
                title: NSLocalizedString("Breath Holding", comment: ""),
                subtitle: NSLocalizedString("Test your breath-holding capacity", comment: ""),
                backgroundColor: "#5e3861"
            )
        )
        homePageData = listData
        
    }
    
    func fetchHomePageQuotesFromOpenAI() {
        let url = URL(string: "https://api.openai.com/v1/chat/completions")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let requestBody = ChatRequest(
            model: "gpt-4o-mini",
            messages: [
                ChatMessage(role: "system", content: systemPrompt),
                ChatMessage(role: "user", content: userInput)
            ],
            temperature: 1,
        )
        
        request.httpBody = try? JSONEncoder().encode(requestBody)
        
        let session = URLSession(configuration: .ephemeral)

        let task = session.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error ?? "Unknown error")
                return
            }

            if let response = response as? HTTPURLResponse, response.statusCode == 200 {
                if let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
                   let choices = json["choices"] as? [[String: Any]],
                   let choice = choices.first,
                   let message = choice["message"] as? [String: Any],
                   var content = message["content"] as? String {
                    DispatchQueue.main.async {
                        content = content.replacingOccurrences(of: "\"", with: "").replacingOccurrences(of: "\n", with: "")
                        self.outputLabel = content
                    }
                }
            }
        }
        
        task.resume()
    }
}
