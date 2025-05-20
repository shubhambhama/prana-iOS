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
                        HStack {
                            TypeWriterView(fullText: "Hello", typingSpeed: 0.1)
                            Spacer()
                            Button {
                                selectedTarget = .support
                            } label: {
                                Image(systemName: "suit.heart")
                                    .font(.title2)
                                    .foregroundColor(.white)
                                    .frame(width: 42, height: 42)
                                    .background {
                                        RoundedRectangle(cornerRadius: 10 ,style: .continuous)
                                            .fill(.ultraThinMaterial)
                                    }
                            }
                        }
                        .padding(.horizontal, 20)
                        .padding(.top , 24)

                        Text(viewModel.homePageLabel)
                            .foregroundColor(.white)
                            .padding(.horizontal, 20)
                            .padding(.top, 8)
                            .padding(.bottom, 16)
                                                
                        HomePageCards(listOfCards: viewModel.homePageData, onCardTap: { inhale, inhaleHold, exhale, exhaleHold in
                            selectedTarget = .breath(inhale, inhaleHold, exhale, exhaleHold)
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

#Preview {
    RootView()
}
