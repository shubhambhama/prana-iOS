//
//  BreathAnimatedBackgroundView.swift
//  Prana
//
//  Created by Shubham Bhama on 15/05/25.
//

import SwiftUI

struct HomePageBackgroundView: View {
    @State private var animate = false

    var body: some View {
        let animatedGradient = LinearGradient(
            gradient: Gradient(colors: animate ? [.blue, .purple, .mint] : [.mint, .purple, .blue]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )

        animatedGradient
            .animation(nil, value: animate)
            .ignoresSafeArea()
            .onAppear {
                DispatchQueue.main.async {
                    withAnimation(.easeInOut(duration: 5).repeatForever(autoreverses: true)) {
                        animate.toggle()
                    }
                }
            }
    }
}



#Preview {
    HomePageBackgroundView()
}
