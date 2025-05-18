//
//  RootView.swift
//  Prana
//
//  Created by Shubham Bhama on 17/05/25.
//

import SwiftUI

struct RootView: View {
    @StateObject private var viewModel = HomePageViewModel()
    @State private var selectedTarget: NavigationTarget?
    
    var body: some View {
        NavigationStack {
            MainView(viewModel: viewModel, selectedTarget: $selectedTarget)
                .navigationDestination(item: $selectedTarget) { target in
                    switch target {
                    case .breath:
                        BreathView()
                    }
                }
        }
        .environment(\.locale, Locale(identifier: "en"))
    }
}
