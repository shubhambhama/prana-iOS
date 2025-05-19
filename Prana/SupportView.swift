//
//  SupportView.swift
//  Prana
//
//  Created by Shubham Bhama on 19/05/25.
//

import SwiftUI

struct SupportView: View {
    var body: some View {
        ScrollView {
            ZStack {
                VStack(alignment: .leading, spacing: 8) {
                    
                    Image("support_image")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity)
                        .cornerRadius(16)
                        .clipped()
                    
                    SupportContent()
                    
                    SocialView()
                }
                .padding()
            }
            .frame(maxHeight: .infinity, alignment: .top)
        }
    }
}

struct SupportContent: View {
    var body: some View {
        Text("Support")
            .font(.title)
            .multilineTextAlignment(.leading)
            .padding(.top, 16)
            .frame(maxWidth: .infinity, alignment: .center)
        
        Text("Prana is a thoughtfully designed iOS app that guides adults and senior citizens through gentle, effective breathing exercises to support mental clarity, relaxation, and overall well-being.")
            .font(.subheadline)
            .multilineTextAlignment(.center)
            .padding(.top, 8)
        
        Text("Built with simplicity and accessibility at its core, Prana features a calming user interface, intuitive navigation, and voice or visual cues that make breathing routines easy to follow—no matter the user’s age or tech familiarity. Whether someone needs a quick stress reset or a daily wellness ritual, Prana adapts to their pace.")
            .font(.subheadline)
            .multilineTextAlignment(.center)
            .padding(.top, 4)
        
        Text("Each element, from the color palette to the flow of exercises, was designed with empathy and intention. Prana isn’t just an app—it’s a companion in wellness, created to bring peace of mind, one breath at a time.")
            .font(.subheadline)
            .multilineTextAlignment(.center)
            .padding(.top, 4)
    }
}

struct SocialView: View {
    var body: some View {
        HStack(spacing: 24) {
            Link(destination: URL(string: "https://www.linkedin.com/in/shubhambhama")!) {
                Image("linkedin")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 36, height: 36)
                    .clipped()
            }
            
            Link(destination: URL(string: "https://github.com/shubhambhama")!) {
                Image("github-mark")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 36, height: 36)
                    .cornerRadius(16)
                    .clipped()
            }
            
            Link(destination: URL(string: "https://www.instagram.com/shubhambhama")!) {
                Image("instagram")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 36, height: 36)
                    .clipped()
            }
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .padding()
        .padding(.top, 24)
    }
}

#Preview {
    SupportView()
}
