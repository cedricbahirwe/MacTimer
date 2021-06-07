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
    
    @State private var activity: ActivityState = .unknown
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
            
            VStack {
                if activity == .start {
                    HStack {
                        
                        LargeText("9")
                            .foregroundColor(.white)
                        VStack {
                            Circle()
                                .frame(width: 16, height: 16)
                            Circle()
                                .frame(width: 16, height: 16)
                        }
                        .frame(width: 40, height: 70)
                        .foregroundColor(.white)
                        
                        HStack(spacing: 0) {
                            LargeText("5")
                            LargeText("9")
                        }
                        .foregroundColor(.white)
                        
                    }
                    .padding()
                    .matchedGeometryEffect(id: "Counter", in: animation)
                }
                Spacer()
                
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding( 50)
            
        }
        .frame(minWidth: 600, maxWidth: .infinity, minHeight: 500, maxHeight: 800)
        .background(activity != .start ? Color.pinkColor : Color.purpleColor)
        .overlay(
            HStack {
                if activity == .start {
                    Button(action: {
                        withAnimation(.spring()) {
                            activity = .unknown
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
                    }
                }, label: {
                    Text("Start")
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
        
        //        .foregroundColor(.none)
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
