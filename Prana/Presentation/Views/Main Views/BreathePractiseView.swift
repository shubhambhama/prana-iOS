//
//  BreathView.swift
//  Prana
//
//  Created by Shubham Bhama on 17/05/25.
//

import SwiftUI

struct BreathePractiseView: View {
    @State var inhaleDuration: CGFloat = 4.0
    @State var inhaleHoldDuration: CGFloat = 0.0
    @State var exhaleDuration: CGFloat = 10.0
    @State var exhaleHoldDuration: CGFloat = 0.0
    
    @State var totalCycles: Int = 2
    
    @State private var currentDuration: CGFloat = 0.0
    
    @State private var currentType: BreatheTypeModel = SampleType[0]
    @Namespace private var animation
    @State private var showBreatheView: Bool = false
    @State private var startAnimation: Bool = false
    @State private var timerCount: CGFloat = 0
    @State private var breatheAction: String = "Breathe In"
    @State private var count: Int = 0
    @State private var currentPhase: BreathingPhase = .inhale
    @State private var currentCycle: Int = 0
    
    @State private var elapsedSeconds: Int = 0
    @State private var timerRunning: Bool = false
    @State private var timer: Timer? = nil
    
    var body: some View {
        ZStack {
            Background()
            
            Content()
            
            Text(breatheAction)
                .font(.largeTitle)
                .foregroundColor(.white)
                .frame(maxHeight: .infinity, alignment: .top)
                .padding(.top, 50)
                .opacity(showBreatheView ? 1 : 0)
                .animation(.easeInOut(duration: 1), value: breatheAction)
                .animation(.easeInOut(duration: 1), value: showBreatheView)
        }
        .onReceive(Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()) { _ in
            guard showBreatheView else {
                timerCount = 0
                return
            }
            
            if timerCount >= currentDuration {
                switch currentPhase {
                case .inhale:
                    currentPhase = .holdInhale
                    currentDuration = inhaleHoldDuration
                    breatheAction = "Hold"
                case .holdInhale:
                    currentPhase = .exhale
                    currentDuration = exhaleDuration
                    breatheAction = "Breathe Out"
                    withAnimation(.easeInOut(duration: Double(currentDuration))) {
                        startAnimation.toggle()
                    }
                case .exhale:
                    currentPhase = .holdExhale
                    currentDuration = exhaleHoldDuration
                    breatheAction = "Hold"
                case .holdExhale:
                    currentCycle += 1
                    if currentCycle >= totalCycles {
                        stopBreathing()
                        return
                    }
                    currentPhase = .inhale
                    currentDuration = inhaleDuration
                    breatheAction = "Breathe In"
                    withAnimation(.easeInOut(duration: Double(currentDuration))) {
                        startAnimation.toggle()
                    }
                }
                
                timerCount = 0
                UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                
            } else {
                timerCount += 0.01
            }
            
            count = max(0, Int(ceil(currentDuration - timerCount)))
        }
        
        
        
    }
    
    @ViewBuilder
    func Content() -> some View {
        VStack {
            Text("Breathe")
                .font(.largeTitle )
                .fontWeight(.semibold)
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .opacity(showBreatheView ? 0 : 1)
            
            
            GeometryReader { proxy in
                let size = proxy.size
                
                VStack {
                    BreatheView(size: size)
                    
                    Text("Breathe to reduce")
                        .font(.title3)
                        .foregroundColor(.white)
                        .opacity(showBreatheView ? 0 : 1)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 12) {
                            ForEach(SampleType) { type in
                                Text(type.title)
                                    .foregroundColor(currentType.id == type.id ? .black : .white )
                                    .padding(.vertical, 10)
                                    .padding(.horizontal, 15)
                                    .background {
                                        ZStack {
                                            if currentType.id == type.id{
                                                RoundedRectangle(cornerRadius: 10, style: .continuous)
                                                    .fill(.white)
                                                    .matchedGeometryEffect(id: "TAB", in: animation)
                                            } else{
                                                RoundedRectangle(cornerRadius: 10, style: .continuous)
                                                    .stroke(.white.opacity(0.5))
                                            }
                                        }
                                    }
                                    .contentShape(Rectangle())
                                    .onTapGesture {
                                        withAnimation(.easeInOut) {
                                            currentType = type
                                        }
                                    }
                            }
                        }
                        .padding()
                        .padding(.leading, 45 )
                    }
                    .opacity(showBreatheView ? 0 : 1)
                    
                    Button(action: {
                        if showBreatheView {
                            stopBreathing()
                        } else {
                            startBreathing()
                        }
                    }) {
                        Text(showBreatheView ? "Finish Breathing" : "Let's Start")
                            .fontWeight(.semibold)
                            .foregroundColor(showBreatheView ? .white.opacity(0.75) : .black)
                            .padding(.vertical, 15)
                            .frame(maxWidth: .infinity)
                            .background {
                                if showBreatheView {
                                    RoundedRectangle(cornerRadius: 10,  style: .continuous)
                                        .stroke(.white.opacity(0.5))
                                } else {
                                    RoundedRectangle(cornerRadius: 10,  style: .continuous)
                                        .fill(currentType.color.gradient)
                                }
                            }
                    }
                    .padding()
                    
                }
                .frame(width: size.width, height: size.height, alignment: .bottom)
            }
        }
        .frame(maxHeight: .infinity, alignment: .top)
    }
    
    @ViewBuilder
    func BreatheView(size: CGSize) -> some View {
        ZStack {
            ForEach(1...8, id: \.self) { index in
                Circle()
                    .fill(currentType.color.gradient.opacity(0.5))
                    .frame(width: 150, height: 150)
                    .offset(x: startAnimation ? 0 : 75)
                    .rotationEffect(Angle(degrees: Double(index) * 45))
                    .rotationEffect(Angle(degrees: startAnimation ? 0 : -45))
            }
        }
        .scaleEffect(startAnimation ? 0.8 : 1)
        .overlay(content: {
            if(inhaleHoldDuration != 1000.0) {
                Text("\(count == 0 ? 3 : count)")
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .animation(.easeInOut, value: count)
                    .opacity(showBreatheView ? 1: 0)
            } else {
                Text(timeString(from: elapsedSeconds))
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
            }
            
        })
        .frame(height: (size.width - 40))
    }
    
    @ViewBuilder
    func Background() -> some View {
        GeometryReader { geo in
            let size = geo.size
            Image("breath_bg_portraint")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .offset(y:  -100)
                .frame(width: size.width, height: size.height)
                .clipped()
                .blur(radius: startAnimation ? 6 : 0, opaque: true)
                .overlay {
                    ZStack {
                        Rectangle()
                            .fill(.linearGradient(colors: [
                                currentType.color.opacity(0.9),
                                .clear,
                                .clear
                            ], startPoint: .top, endPoint: .bottom))
                            .frame(height: size.height / 1.5)
                            .frame(maxHeight: .infinity, alignment: .top)
                        
                        Rectangle()
                            .fill(.linearGradient(colors: [
                                .clear,
                                .black.opacity(0.85),
                                .black.opacity(0.9),
                                .black,
                                .black
                            ], startPoint: .top, endPoint: .bottom))
                            .frame(height: size.height / 1.35)
                            .frame(maxHeight: .infinity, alignment: .bottom)
                    }
                }
            
        }
        .ignoresSafeArea()
    }
    
    func startBreathing() {
        withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7)) {
            showBreatheView = true
        }
        
        currentPhase = .inhale
        currentDuration = inhaleDuration
        breatheAction = "Breathe In"
        currentCycle = 0
        timerCount = 0
        
        withAnimation(.easeInOut(duration: Double(currentDuration)).delay(0.05)) {
            startAnimation = true
        }
        
        if !timerRunning {
            startTimer()
        }
    }
    
    
    func stopBreathing() {
        withAnimation(.easeInOut(duration: 1.6)) {
            showBreatheView = false
            startAnimation = false
        }
        
        stopTimer()
        resetTimer()
    }
    
    func startTimer() {
        timerRunning = true
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            elapsedSeconds += 1
        }
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
        timerRunning = false
    }
    
    func resetTimer() {
        stopTimer()
        elapsedSeconds = 0
    }
    
    func timeString(from seconds: Int) -> String {
        let minutes = seconds / 60
        let seconds = seconds % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}

#Preview {
    BreathePractiseView()
}
