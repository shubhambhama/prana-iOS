//
//  PranaApp.swift
//  Prana
//
//  Created by Shubham Bhama on 14/05/25.
//

import SwiftUI

@main
struct PranaApp: App {
    var body: some Scene {
        WindowGroup {
            MainView()
                .environment(\.locale, Locale(identifier: "hi"))
        }
    }
}
