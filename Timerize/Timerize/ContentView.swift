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


enum  ActivityState {
    case start, pause, resume , stop, unknown
}
struct ContentView: View {
    
    @StateObject var timerManager = TimerStoreModel()
    let availableMinutes = Array(1...59)
    @State var selectedPickedTime = 10
    
    @State private var activity: ActivityState = .unknown
    @State private var progress: CGFloat = 0.0
    @Namespace private var animation
    var body: some View {
        ZStack {
            if activity != .start {
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
                if activity == .start {
                    HStack {
                        Text("\(self.secondsToMinutesAndSeconds(seconds: timerManager.secondsLeft))")
                            .font(.system(size: 60, weight: .bold))
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
                    
                    ProgressBar(initialProgress: $progress, color: .white)
                        .frame(height: 10)
                        .padding(.bottom, 100)
                }
                
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding( 50)
            
        }
        .frame(minWidth: 400, maxWidth: .infinity, minHeight: 300, maxHeight: 800)
        .background(activity != .start ? Color.pinkColor : Color.purpleColor)
        .overlay(
            HStack {
                if activity == .start {
                    Button(action: {
                        withAnimation(.spring()) {
                            activity = .unknown
                            timerManager.reset()
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
                        activity = .start
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
//        .onAppear(perform: start)
    }
    
    func start() {
        Timer.scheduledTimer(withTimeInterval: 0.3, repeats: true) { timer in
            self.progress += 0.1
        }
    }
    
    func startCounting() {
        if timerManager.timerMode == .initial {
            timerManager.setTimerLength(minutes: availableMinutes[selectedPickedTime] * 60)
        }
        if timerManager.timerMode == .running  {
            timerManager.pause()
        } else {
            timerManager.start()
        }
    }
    
    func secondsToMinutesAndSeconds (seconds : Int) -> String {
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

struct ProgressBar: View {

    @Binding var progress: CGFloat

    private var barColor: Color
    private var animationTime: TimeInterval = 0.3

    public init(initialProgress: Binding<CGFloat>, color: Color) {
        self._progress = initialProgress
        self.barColor = color
    }

    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .leading) {
                // Main Bar
                Rectangle()
                    .fill(Color.black.opacity(0.8))

                // Progress Bar
                Rectangle()
                    .fill(barColor)
                    .frame(width: min(geo.size.width, geo.size.width * progress))
                    
                    .animation(.linear)
            }.cornerRadius(25.0)
        }
    }
}
