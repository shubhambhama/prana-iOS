//
//  HomePageCards.swift
//  Prana
//
//  Created by Shubham Bhama on 15/05/25.
//

import SwiftUI

struct HomePageCards: View {
    @ObservedObject var viewModel: HomePageViewModel
    
    init(viewModel: HomePageViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        let columns = [GridItem(.flexible()), GridItem(.flexible())]
        
        LazyVGrid(columns: columns, spacing: 12) {
            ForEach(viewModel.homePageData, id: \.id) { item in
                CardView(
                    title: item.title,
                    subtitle: item.subtitle,
                    backgroundColor: item.backgroundColor,
                    footerAction: item.footerAction
                )
                
            }
        }
        .padding(EdgeInsets.init(top: 0, leading: 16, bottom: 0, trailing: 16))
        .onAppear {
            viewModel.getHomePageData()
            viewModel.fetchHomePageQuotesFromOpenAI()
        }
    }
}

struct CardView: View {
    let title: String
    let subtitle: String
    let backgroundColor: String
    let footerAction: String?
    
    @State private var isExpanded = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(LocalizedStringKey(title))
                .font(.title)
                .foregroundStyle(.white)
                .bold()
                .lineLimit(3)
                .minimumScaleFactor(0.8)
            
            Text(LocalizedStringKey(subtitle))
                .font(.subheadline)
                .foregroundStyle(.white)
            
            Spacer()
            
            if let duration = footerAction {
                Button(action: {
                    isExpanded.toggle()
                }) {
                    Text(LocalizedStringKey(duration))
                        .foregroundStyle(.white)
                        .font(.footnote)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 8)
                        .cornerRadius(15)
                        .overlay(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(.white.opacity(0.3))
                        )
                }
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: 220)
        .padding(16)
        .background(Color(hex: backgroundColor))
        .cornerRadius(16)
        .sheet(isPresented: $isExpanded) {
            ChangeDurationView().presentationDetents([.fraction(0.54)])
        }
    }
}

#Preview("English") {
    HomePageCards(viewModel: HomePageViewModel())
        .environment(\.locale, Locale(identifier: "en"))
}

#Preview("Hindi") {
    HomePageCards(viewModel: HomePageViewModel())
        .environment(\.locale, Locale(identifier: "hi"))
}
