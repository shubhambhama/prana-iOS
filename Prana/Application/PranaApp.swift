//
//  PranaApp.swift
//  Prana
//
//  Created by Shubham Bhama on 14/05/25.
//

import SwiftUI

@main
struct PranaApp: App {
    
    init() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.backButtonAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().tintColor = .white
    }

    
    var body: some Scene {
        WindowGroup {
            RootView()
        }
    }
}
