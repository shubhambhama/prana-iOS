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
        LinearGradient(
            gradient: Gradient(
                colors: animate ? [.blue,.purple,.mint]:[.mint,.purple,.blue]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        .animation(.easeOut(duration: 5).repeatForever(autoreverses: true), value: animate)
        .onAppear { animate = true }
        .ignoresSafeArea()
    }
}


#Preview {
    HomePageBackgroundView()
}
