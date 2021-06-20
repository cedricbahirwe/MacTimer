//
//  ContentView.swift
//  Timerize
//
//  Created by Cédric Bahirwe on 06/06/2021.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var timerManager = TimerStoreModel()
    
    @Namespace private var animation
    var body: some View {
        ZStack {
            if timerManager.timerMode == .initial {
                HStack {
                    
                    let (_, min, sec) = timerManager.secondsToMinutesAndSeconds(seconds: timerManager.selectedPickedTime*60)
                    CounterView(title: "Minutes",
                                left: String(min.first!),
                                right: String(min.last!))
                    
                    VStack {
                        Circle()
                            .frame(width: 16, height: 16)
                        
                        Circle()
                            .frame(width: 16, height: 16)
                    }
                    .frame(width: 40)
                    .foregroundColor(.black)
                    .offset(y: -8)
                    
                    CounterView(title: "Seconds",
                                left: String(sec.first!),
                                right: String(sec.last!))

                    
                }
                .foregroundColor(.black)
                .matchedGeometryEffect(id: "Counter", in: animation)
            }
            
            VStack(alignment: .leading) {
                if timerManager.timerMode != .initial {
                    HStack(spacing: 8) {
                        let (_, min, sec) = timerManager.secondsToMinutesAndSeconds(seconds: timerManager.secondsLeft)
                       
                        HStack(spacing: 0) {
                            LargeText(String(min.first!))
                            LargeText(String(min.last!))
                        }
                        VStack(spacing: 8) {
                            Circle()
                                .frame(width: 12, height: 12)
                            Circle()
                                .frame(width: 12, height: 12)
                        }

                        HStack(spacing: 0) {
                            LargeText(String(sec.first!))
                            LargeText(String(sec.last!))
                        }
                        
                    }
                    .foregroundColor(.white)

                    .padding()
                    .matchedGeometryEffect(id: "Counter", in: animation)
                    Spacer()
                    let progress = CGFloat(timerManager.secondsLeft)/60 / CGFloat(timerManager.selectedPickedTime)
                    ProgressBar(initialProgress: progress, color: .pureBlue)
                        .frame(height: 10)
                        .padding(.bottom, 100)
                }
                
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding( 50)
            
        }
        .frame(minWidth: 400, maxWidth: 800, minHeight: 300, maxHeight: 600)
        .overlay(
            HStack {
                if timerManager.timerMode == .paused {
                    Button(action: {
                        withAnimation(.spring()) {
                            timerManager.resetCounter()
                        }
                    }, label: {
                        Text("Reset")
                            .frame(width: 60, height: 30)
                            .background(Color.white)
                            .cornerRadius(5)
                        
                    })
                    .buttonStyle(PlainButtonStyle())
                }
                Button(action: {
                    withAnimation(.spring()) {
                        timerManager.startCounting()
                    }
                }, label: {
                    Text(timerManager.timerMode == .running  ? "Pause" : "Start")
                        .frame(width: 60, height: 30)
                        .background(Color.white)
                        .cornerRadius(5)
                    
                })
                .buttonStyle(PlainButtonStyle())
            }
            .padding()
            .foregroundColor(.black)
            , alignment: .topTrailing
        )
        .frame(
            maxWidth: (NSScreen.main?.frame.size.width ?? 1000) * 0.8,
            maxHeight: (NSScreen.main?.frame.size.height ?? 800) * 0.8)
        .background(mainBackground())
    }
    
    private func mainBackground() -> Color {
        switch timerManager.timerMode {
        case .initial:
            return .pinkColor
        case .running:
            return .mainBg
        case .paused:
            return Color.mainBg.opacity(0.5)
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
