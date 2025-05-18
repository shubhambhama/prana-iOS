//
//  BreathView.swift
//  Prana
//
//  Created by Shubham Bhama on 17/05/25.
//

import SwiftUI

struct BreathePractiseView: View {
    @State var currentType: BreatheTypeModel = SampleType[0]
    @Namespace var animation
    @State var showBreatheView: Bool = false
    @State var startAnimation: Bool = false
    
    @State var timerCount: CGFloat = 0
    @State var breatheAction: String = "Breathe In"
    @State var count: Int = 0
    
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
            if showBreatheView {
                if timerCount >=  3.2 {
                    timerCount = 0
                    breatheAction = (breatheAction == "Breathe Out" ? "Breathe In" : "Breathe Out")
                    withAnimation(.easeInOut(duration: 3).delay(0.01)) {
                        startAnimation.toggle()
                    }
                    
                    UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
                } else {
                    timerCount += 0.01
                }
                
                count = 3 - Int(timerCount)
            } else {
                timerCount = 0
            }
        }
    }
    
    @ViewBuilder
    func Content() -> some View {
        VStack {
            HStack {
                Text("Breathe")
                    .font(.largeTitle )
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Button {
                    
                } label: {
                    Image(systemName: "suit.heart")
                        .font(.title2)
                        .foregroundStyle(.white)
                        .frame(width: 42, height: 42)
                        .background {
                            RoundedRectangle(cornerRadius: 10, style: .continuous).fill(.ultraThinMaterial)
                        }
                }
                
            }
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
                        HStack(spacing: 12 ) {
                            ForEach(SampleType) { type in
                                Text(type.title)
                                    .foregroundColor(currentType.id == type.id ? .black : .white )
                                    .padding(.vertical, 10)
                                    .padding(.horizontal, 15)
                                    .background {
                                        // MARK: Testing
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
                    
                    Button(action: startBreathing){
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
            Text("\(count == 0 ? 3 : count)")
                .font(.title)
                .fontWeight(.semibold)
                .foregroundColor(.white)
                .animation(.easeInOut, value: count)
                .opacity(showBreatheView ? 1: 0)
            
        })
        .frame(height: (size.width - 40 ))
    }
    
    @ViewBuilder
    func Background() -> some View {
        GeometryReader { geo in
            let size = geo.size
            Image("breath_bg_portraint")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .offset(y:  -150)
                .frame(width: size.width, height: size.height)
                .clipped()
                .blur(radius: startAnimation ? 4 : 0, opaque: true)
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
                                .black,
                                .black,
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
            showBreatheView.toggle()
        }
        
        if showBreatheView {
            withAnimation(.easeInOut(duration: 3).delay(0.05)) {
                startAnimation = true
            }
        } else {
            withAnimation(.easeInOut(duration: 1.6)) {
                startAnimation = false
            }
        }
    }
}

#Preview {
    BreathePractiseView()
}
