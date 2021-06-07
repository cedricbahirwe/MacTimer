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
                
                VStack(spacing: 6) {
                    CounterView(left: 1, right: 0)
                    Text("Minutes")
                        .font(.headline)
                }
                
                VStack {
                    Circle()
                        .frame(width: 16, height: 16)
                    Circle()
                        .frame(width: 16, height: 16)
                }
                .frame(width: 40, height: 70)
                VStack(spacing: 6) {
                    CounterView(left: 0, right: 0)
                    Text("Seconds")
                        .font(.headline)
                }

            }
            .matchedGeometryEffect(id: "Counter", in: animation)
            }
            VStack {
                if activity == .start {
                HStack {
                    VStack(spacing: 6) {
                        CounterView(left: 1, right: 0)
                        Text("Minutes")
                            .font(.headline)
                    }
                    
                    VStack {
                        Circle()
                            .frame(width: 16, height: 16)
                        Circle()
                            .frame(width: 16, height: 16)
                    }
                    .frame(width: 40, height: 70)
                    VStack(spacing: 6) {
                        CounterView(left: 0, right: 0)
                        Text("Seconds")
                            .font(.headline)
                    }
                }
                .padding()
                .matchedGeometryEffect(id: "Counter", in: animation)
                }
                Spacer()
                
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
        }
        .frame(minWidth: 600, maxWidth: .infinity, minHeight: 500, maxHeight: 1000)
        .background(activity != .start ? Color.pinkColor : Color.purpleColor)
        .overlay(
            HStack {
                if activity == .start {
                    Button(action: {
                        withAnimation {
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
                    withAnimation{
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
            

            , alignment: .topTrailing
        )
        .foregroundColor(.black)

//        .foregroundColor(.none)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct CounterView: View {
    let left: Int
    let right: Int
    var body: some View {
        HStack(spacing: 0) {
            Text(String(left))
            Text(String(right))
        }
        .frame(width: 110, height: 70)
        .background(Color.white)
        .cornerRadius(12)
        
        .font(.system(size: 60, weight: .bold))
        .foregroundColor(.black)
    }
}
