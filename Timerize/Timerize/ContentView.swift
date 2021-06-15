//
//  ContentView.swift
//  Timerize
//
//  Created by Cédric Bahirwe on 06/06/2021.
//

import SwiftUI

extension Color {
    static let pinkColor =  Color(red: 0.999, green: 0.825, blue: 0.846)
    
    static let purpleColor = Color(red: 0.372, green: 0.186, blue: 0.848)
}


struct ContentView: View {
    
    @StateObject var timerManager = TimerStoreModel()

    @State var selectedPickedTime = 10
    
    @Namespace private var animation
    var body: some View {
        ZStack {
            if timerManager.timerMode != .running {
                HStack {
                    
                    CounterView(title: "Minutes", left: 1, right: 0)
                    
                    VStack {
                        Circle()
                            .frame(width: 16, height: 16)
                        Circle()
                            .frame(width: 16, height: 16)
                    }
                    .frame(width: 40, height: 70)
                    .foregroundColor(.black)
                    
                    CounterView(title: "Seconds", left: 0, right: 0)
                    
                }
                .foregroundColor(.black)
                .matchedGeometryEffect(id: "Counter", in: animation)
            }
            
            VStack(alignment: .leading) {
                if timerManager.timerMode == .running {
                    HStack {
                        Text(secondsToMinutesAndSeconds(seconds: timerManager.secondsLeft))
                            .font(Font.system(size: 60, weight: .bold))
                            .frame(width: 200, alignment: .leading)
                            
//                        LargeText("9")
//                        VStack {
//                            Circle()
//                                .frame(width: 16, height: 16)
//                            Circle()
//                                .frame(width: 16, height: 16)
//                        }
//                        .frame(width: 40, height: 70)
//
//                        HStack(spacing: 0) {
//                            LargeText("5")
//                            LargeText("9")
//                        }
                        
                    }
                    .foregroundColor(.white)

                    .padding()
                    .matchedGeometryEffect(id: "Counter", in: animation)
                    Spacer()
                    let progress = CGFloat(timerManager.secondsLeft)/60 / CGFloat(selectedPickedTime)
                    ProgressBar(initialProgress: progress, color: .white)
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
                if timerManager.timerMode == .running {
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
                        startCounting()
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
        .background(timerManager.timerMode != .running ? Color.pinkColor : Color.purpleColor)
    }
    
    
    private func startCounting() {
        if timerManager.timerMode == .initial {
            let minutes = selectedPickedTime * 60
            timerManager.setTimerLength(minutes: minutes)
        }
        
        if timerManager.timerMode == .running  {
            timerManager.pauseCounter()
        } else {
            timerManager.startCounter()
        }
    }
    
    private func secondsToMinutesAndSeconds (seconds : Int) -> String {
        let minutes = "\((seconds % 3600) / 60)"
        let seconds = "\((seconds % 3600) % 60)"
        let minuteStamp = minutes.count > 1 ? minutes : "0" + minutes
        let secondStamp = seconds.count > 1 ? seconds : "0" + seconds
        return "\(minuteStamp):\(secondStamp)"
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct CounterView: View {
    let title: String
    let left: Int
    let right: Int
    var body: some View {
        VStack(spacing: 6) {
            HStack(spacing: 0) {
                LargeText(String(left))
                LargeText(String(right))
            }
            .frame(width: 110, height: 70)
            .background(Color.white)
            .cornerRadius(12)
            .foregroundColor(.black)
            
            Text("Seconds")
                .font(.headline)
        }
        .frame(width: 110)
    }
}

struct LargeText: View {
    let text: String
    
    init(_ value: String) {
        self.text = value
    }
    var body: some View {
        Text(text)
            .font(.system(size: 60, weight: .bold))
    }
}

