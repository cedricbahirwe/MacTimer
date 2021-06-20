//
//  TimerStoreModel.swift
//  Timerize
//
//  Created by Cédric Bahirwe on 15/06/2021.
//


import Foundation

public enum TimerMode {
    case running, paused, initial
}

class TimerStoreModel: ObservableObject {
    let defaults = UserDefaults.standard

    @Published var timerMode: TimerMode = .initial
    @Published var secondsLeft = UserDefaults.standard.integer(forKey: UserDefaults.Keys.TimerLength)
    var timer = Timer()
    
    public func startCounter() {
        timerMode = .running
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { timer in

            if self.secondsLeft == 0 {
                self.resetCounter()
            }
            self.secondsLeft -= 10
            
        })
        
    }
    
    public func resetCounter() {
        timerMode = .initial
        secondsLeft = defaults.integer(forKey: UserDefaults.Keys.TimerLength)
        timer.invalidate()
    }
    
    public func pauseCounter() {
        timerMode = .paused
        timer.invalidate()
    }
    
    public func setTimerLength(minutes: Int) {
        defaults.set(minutes, forKey: UserDefaults.Keys.TimerLength)
        secondsLeft = minutes
    }
}
