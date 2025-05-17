//
//  ContentView.swift
//  Prana
//
//  Created by Shubham Bhama on 14/05/25.
//

import SwiftUI

struct MainView: View {
    @StateObject private var viewModel: HomePageViewModel = HomePageViewModel()

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                HomePageBackgroundView()
                VStack(alignment: .leading) {
                    TypeWriterView(fullText: "Hello", typingSpeed: 0.1)
                    Text(viewModel.outputLabel)
                        .foregroundColor(.white)
                        .padding(.horizontal, 16)
                    Spacer()
                    HomePageCards(viewModel: viewModel)
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

#Preview("English") {
    MainView()
        .environment(\.locale, Locale(identifier: "en"))
}

#Preview("Hindi") {
    MainView()
        .environment(\.locale, Locale(identifier: "hi"))
}

