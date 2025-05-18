//
//  BreathView.swift
//  Prana
//
//  Created by Shubham Bhama on 17/05/25.
//

import SwiftUI

struct BreathView: View {
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
    BreathView(metaData: "")
}
