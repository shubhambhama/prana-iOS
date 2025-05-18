//
//  BreathingInfoView.swift
//  Prana
//
//  Created by Shubham Bhama on 18/05/25.
//

import SwiftUI

struct BreathingInfoView: View {
    let metaData: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Your Breathing Journey So Far")
                .font(.title2)
                .padding(16)
                .fontWeight(.bold)
            
            Image("breathing_image")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity)
                .clipped()
            
            Text(metaData)
                .font(.subheadline)
                .padding(16)
        }
    }
}

#Preview {
    BreathingInfoView(metaData: "")
}
