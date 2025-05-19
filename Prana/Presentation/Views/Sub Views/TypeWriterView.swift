//
//  TypeWriterView.swift
//  Prana
//
//  Created by Shubham Bhama on 16/05/25.
//
import SwiftUI

struct TypeWriterView: View {
    var fullText: String
    @State private var currentText: String = ""
    let typingSpeed: Double
    @State private var hasAnimated = false

    var body: some View {
        Text(currentText)
            .onAppear {
                guard !hasAnimated else { return }
                hasAnimated = true
                currentText = ""
                let localizedText = NSLocalizedString(fullText, comment: "")
                let characters = Array(localizedText)
                var currentIndex = 0

                Timer.scheduledTimer(withTimeInterval: typingSpeed, repeats: true) { timer in
                    if currentIndex < characters.count {
                        currentText.append(characters[currentIndex])
                        currentIndex += 1
                    } else {
                        timer.invalidate()
                    }
                }
            }
            .font(.title)
            .fontWeight(.bold)
            .foregroundColor(.white)
    }
}


#Preview {
    TypeWriterView(fullText: "Hi, there!", typingSpeed: 0.1)
}
