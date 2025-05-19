//
//  HomePageCards.swift
//  Prana
//
//  Created by Shubham Bhama on 15/05/25.
//

import SwiftUI

struct HomePageCards: View {
    var listOfCards: [HomePageCardModel] = .init()
    var onCardTap: (CGFloat, CGFloat, CGFloat, CGFloat) -> Void
    
    var body: some View {
        let columns = [GridItem(.flexible()), GridItem(.flexible())]
        
        LazyVGrid(columns: columns, spacing: 12) {
            ForEach(listOfCards, id: \.id) { item in
                CardView(
                    item: item,
                    onCardTap: onCardTap
                )
            }
        }
        .padding(EdgeInsets.init(top: 0, leading: 16, bottom: 0, trailing: 16))
    }
}

struct CardView: View {
    let item: HomePageCardModel
    var onCardTap: (CGFloat, CGFloat, CGFloat, CGFloat) -> Void
    
    @State private var isExpanded = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(LocalizedStringKey(item.title))
                .font(.title)
                .foregroundStyle(.white)
                .bold()
                .lineLimit(3)
                .minimumScaleFactor(0.8)
            
            Text(LocalizedStringKey(item.subtitle))
                .font(.subheadline)
                .foregroundStyle(.white)
            
            Spacer()
            
            if let duration = item.footerAction {
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
        .background(Color(hex: item.backgroundColor))
        .cornerRadius(16)
        .onTapGesture {
            onCardTap(item.homeCardType.parameters.inhale, item.homeCardType.parameters.inhaleHold, item.homeCardType.parameters.exhale, item.homeCardType.parameters.exhaleHold)
        }
        .sheet(isPresented: $isExpanded) {
            ChangeDurationView(cardType: item.homeCardType).presentationDetents([.fraction(0.54)])
        }
    }
}
