//
//  ContentView.swift
//  Prana
//
//  Created by Shubham Bhama on 14/05/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            BreathAnimatedBackgroundView()
        }
    }
}

struct BreathAnimatedBackgroundView: View {
    @State private var animate = false
    
    var body: some View {
        LinearGradient(
            gradient: Gradient(
                colors: animate ? [.blue,.purple,.mint]:[.mint,.purple,.blue]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        .animation(.easeOut(duration: 5).repeatForever(autoreverses: true), value: animate)
        .onAppear { animate = true }
        .ignoresSafeArea()
        
        let columns = [GridItem(.flexible()), GridItem(.flexible())]
        
        LazyVGrid(columns: columns, spacing: 12) {
            CardView(title: "Equal Breathing", subtitle: "Equal Breathing helps you to relax and focus.", backgroundColor: Color(hex: "#2e5d6c"))
            CardView(title: "Box Breathing", subtitle: "Box Breathing is a powerful stress reliever.",backgroundColor: Color(hex: "#1a3950"))
            CardView(title: "4-7-8 Breathing", subtitle: "4-7-8 Breathing promotes better sleep",backgroundColor: Color(hex: "#653f5f"))
            CardView(title: "Breath Holding", subtitle: "Test your breath-holding capacity",backgroundColor: Color(hex: "#5e3861"))
        }.padding(EdgeInsets.init(top: 0, leading: 16, bottom: 0, trailing: 16))
    }
}

struct CardView: View {
    let title: String
    let subtitle: String
    let backgroundColor: Color
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .font(.title)
                .foregroundStyle(.white)
                .bold()
                .lineLimit(3)
                .minimumScaleFactor(0.8)
            
            Text(subtitle)
                .font(.subheadline)
                .foregroundStyle(.white)
            
            Spacer()
            
            Button(action: {
                
            }) {
                Text("Change Duration")
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
        .frame(maxWidth: .infinity)
        .frame(height: 220)
        .padding(16)
        .background(backgroundColor)
        .cornerRadius(16)
    }
}


#Preview {
    ContentView()
}


extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: .alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let r = Double((int >> 16) & 0xFF) / 255.0
        let g = Double((int >> 8) & 0xFF) / 255.0
        let b = Double(int & 0xFF) / 255.0
        self.init(.sRGB, red: r, green: g, blue: b)
    }
}
