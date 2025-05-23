//
//  HomePageViewModel.swift
//  Prana
//
//  Created by Shubham Bhama on 16/05/25.
//

import Foundation

protocol HomePageViewModelProtocol: ObservableObject {
    func getHomePageData()
    func fetchDataFromOpenAI(userPrompt: String, updateLabel: @escaping (String) -> Void) async
}

final class HomePageViewModel: HomePageViewModelProtocol {
    @Published var homePageData: [HomePageCardModel] = .init()
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var homePageLabel = ""
    @Published var homePageInfo = ""
    @Published var isInfoSheetExpanded: Bool = false
    
    // MARK: This key is for testing purpose
    let apiKey = "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"
    
//    let apiKey = ""
    
    let systemPrompt = "You are an assistant who has deep knowledge about meditation and breathing techiniques. "
    let homepageQuotePrompt = "I have breathing application which has different types of techiniques like equal breathing, box breathing, 4-7-8 breathing and Breath holding. Give me one quote for today to do use these breathing techiniques to reduce stress and anxiety. Make sure this is maximum 21 words long. Also, make sure to add try this breathing technique to reduce stress and anxiety."
    
    // MARK: This query has multiple parameters for different breathing techniques. Retrieve them from UserDefaults once the logic is implemented.
    let homepageInfoPrompt = "I have a breathing application which has different types of techiniques like equal breathing, box breathing, 4-7-8 breathing and Breath holding. In that, I have completed seven equal breathing, eight box breathing, two 4-7-8 breathing and 24 breath holding. Give me insight like how this is improving my health with total breathing practise I did and motivate me to do more. Make sure this is maximum 100 words long and do not use markdown just sentence description"
    
    init() {
        getHomePageData()
        fetchDataFromOpenAI(userPrompt: homepageQuotePrompt) { info in
            self.homePageLabel = info
        }
        fetchDataFromOpenAI(userPrompt: homepageInfoPrompt) { info in
            self.homePageInfo = info
            self.isInfoSheetExpanded.toggle()
        }
    }
}

extension HomePageViewModel {
    
    func getHomePageData() {
        var listData: [HomePageCardModel] = .init()
        listData.append(
            HomePageCardModel(
                title: NSLocalizedString("Equal Breathing", comment: ""),
                subtitle: NSLocalizedString("Equal Breathing helps you to relax and focus.", comment: ""),
                backgroundColor: "#2e5d6c",
                footerAction:  NSLocalizedString("Change Duration", comment: ""),
                homeCardType: HomeCardType.equalBreathing
            )
        )
        listData.append(
            HomePageCardModel(
                title: NSLocalizedString("Box Breathing", comment: ""),
                subtitle: NSLocalizedString("Box Breathing is a powerful stress reliever.", comment: ""),
                backgroundColor: "#1a3950",
                footerAction:  NSLocalizedString("Change Duration", comment: ""),
                homeCardType: HomeCardType.boxBreathing
            )
        )
        listData.append(
            HomePageCardModel(
                title: NSLocalizedString("4-7-8 Breathing", comment: ""),
                subtitle: NSLocalizedString("4-7-8 Breathing promotes better sleep", comment: ""),
                backgroundColor: "#653f5f",
                footerAction:  NSLocalizedString("Change Duration", comment: ""),
                homeCardType: HomeCardType.fourSevenEightBreathing
            )
        )
        listData.append(
            HomePageCardModel(
                title: NSLocalizedString("Breath Holding", comment: ""),
                subtitle: NSLocalizedString("Test your breath-holding capacity", comment: ""),
                backgroundColor: "#5e3861",
                homeCardType: HomeCardType.breathHolding
            )
        )
        homePageData = listData
        
    }
    
    // MARK: Once MVVM will integrate, will move this to repository or data manager
    func fetchDataFromOpenAI(userPrompt: String, updateLabel: @escaping (String) -> Void) {
        let url = URL(string: "https://api.openai.com/v1/chat/completions")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let requestBody = ChatRequest(
            model: "gpt-4o-mini",
            messages: [
                ChatMessage(role: "system", content: systemPrompt),
                ChatMessage(role: "user", content: userPrompt)
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
                        updateLabel(content)
                    }
                }
            }
        }
        
        task.resume()
    }
}
