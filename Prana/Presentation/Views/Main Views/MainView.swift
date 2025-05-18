//
//  ContentView.swift
//  Prana
//
//  Created by Shubham Bhama on 14/05/25.
//

import SwiftUI

struct MainView: View {
    @ObservedObject var viewModel: HomePageViewModel
    @Binding var selectedTarget: NavigationTarget?
    
    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                ZStack {
                    HomePageBackgroundView()
                    VStack(alignment: .leading) {
                        TypeWriterView(fullText: "Hello", typingSpeed: 0.1)
                        Text(viewModel.outputLabel)
                            .foregroundColor(.white)
                            .padding(.horizontal, 16)
                        Spacer()
                        HomePageCards(listOfCards: viewModel.homePageData, onCardTap: {
                            selectedTarget = .breath
                        })
                        Spacer()
                    }
                    .frame(
                        width: geometry.size.width,
                        height: geometry.size.height,
                        alignment: .top
                    )
                }
            }
        }
    }
}

#Preview("English") {
//    MainView()
//        .environment(\.locale, Locale(identifier: "en"))
}

#Preview("Hindi") {
//    MainView()
//        .environment(\.locale, Locale(identifier: "hi"))
}

