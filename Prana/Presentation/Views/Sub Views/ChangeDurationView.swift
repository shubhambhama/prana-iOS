//
//  ChangeDurationView.swift
//  Prana
//
//  Created by Shubham Bhama on 16/05/25.
//

import SwiftUI

struct ChangeDurationView: View {
    @StateObject private var viewModel = HomePageViewModel()
    @State var cardType: HomeCardType
    @State var progress = 1.0
    @Environment(\.dismiss) var dismiss
    
    
    var body: some View {
        ZStack {
//            Color(hue: 0.58, saturation: 0.06, brightness: 1.0)
//                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Text("Breath Cycles")
                    .font(.title)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(16)
                ChangeDurationCircleProgress(value: $progress, in: 1...100).frame(width:250, height: 250)
                HStack {
                    Button(action: {
                        dismiss()
                    }) {
                        Text("Cancel")
                            .frame(width: 86, height: 24)
                            .padding(.vertical, 8)
                            .padding(.horizontal, 16)
                            .background(Color.white)
                            .cornerRadius(8)
                            .shadow(radius: 0.1)
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        dismiss()
                    }) {
                        Text("Save")
                            .frame(width: 86, height: 24)
                            .padding(.vertical, 8)
                            .padding(.horizontal, 16)
                            .background(Color.accentColor)
                            .cornerRadius(8)
                            .foregroundStyle(.white)
                            .shadow(radius: 0.2)
                    }
                }
                .padding(16)
            }
        }
    }
}

struct ChangeDurationCircleProgress: View {
    @Binding var progress: Double
    @State private var rotationAngle: Angle = .zero
    
    private var minValue = 0.0
    private var maxValue = 1.0
    
    init(value progress: Binding<Double>, in bounds: ClosedRange<Int> = 0...1) {
        self._progress = progress
        
        self.minValue = Double(bounds.first ?? 0)
        self.maxValue = Double(bounds.last ?? 1)
        
        self.rotationAngle = Angle(degrees: progressFraction * 360.00)
    }
    
    private var progressFraction: Double {
        return ((progress - minValue) / (maxValue - minValue))
    }
    
    private func changeAngle(location: CGPoint) {
        let vector = CGVector(dx: location.x, dy: -location.y)
        let angleRadians = atan2(vector.dx, vector.dy)
        let positiveAngle = angleRadians < 0.0 ? angleRadians + (2.0 * .pi) : angleRadians
        progress = ((positiveAngle / (2.0 * .pi)) * (maxValue - minValue)) + minValue
        rotationAngle = Angle(radians: positiveAngle)
    }
    
    var body: some View {
        GeometryReader { geo in
            let radius = (min(geo.size.width, geo.size.height)/2) * 0.9
            let sliderWidth = radius * 0.12
            
            ZStack {
                Circle()
                    .stroke(Color(hue: 0.0, saturation: 0.0, brightness: 0.9),
                            style: StrokeStyle(lineWidth: sliderWidth))
                    .overlay() {
                        HStack {
                            Text("\(Int(progress))")
                                .font(.system(size: radius * 0.6, weight: .bold, design:.rounded))
                            Text(progress >= 2 ? "Cycles" : "Cycle")
                                .font(.system(size: radius * 0.18, design:.rounded))
                            
                        }
                    }
                Circle()
                    .stroke(Color(hue: 0.0, saturation: 0.0, brightness: 0.6),
                            style: StrokeStyle(lineWidth: sliderWidth * 0.75,
                                               dash: [2, (2 * .pi * radius)/24 - 2]))
                    .rotationEffect(Angle(degrees: -90))
                Circle()
                    .trim(from: 0, to: progressFraction)
                    .stroke(Color(hue: 0.0, saturation: 0.5, brightness: 0.9),
                            style: StrokeStyle(lineWidth: sliderWidth, lineCap: .round)
                    )
                    .rotationEffect(Angle(degrees: -90))
                Circle()
                    .fill(Color.white)
                    .shadow(radius: (sliderWidth * 0.3))
                    .frame(width: sliderWidth, height: sliderWidth)
                    .offset(y: -radius)
                    .rotationEffect(rotationAngle)
                    .gesture(
                        DragGesture(minimumDistance: 0.0)
                            .onChanged() { value in
                                changeAngle(location: value.location)
                            }
                    )
            }
            .frame(width: radius * 2.0, height: radius * 2.0, alignment: .center)
            .padding(radius * 0.1)
            .onAppear {
                self.rotationAngle = Angle(degrees: progressFraction * 360.00)
            }
        }
    }
}


#Preview {
//    ChangeDurationView()
}
