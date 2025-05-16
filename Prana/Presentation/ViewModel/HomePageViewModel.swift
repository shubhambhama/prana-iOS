//
//  HomePageViewModel.swift
//  Prana
//
//  Created by Shubham Bhama on 16/05/25.
//

import Foundation

protocol HomePageViewModelProtocol: ObservableObject {
    func getHomePageData()
}

final class HomePageViewModel: HomePageViewModelProtocol {
    @Published var homePageData: [HomePageCardModel] = .init()
    
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
}
