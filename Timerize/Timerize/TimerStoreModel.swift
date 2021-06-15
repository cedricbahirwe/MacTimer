//
//  TimerStoreModel.swift
//  Timerize
//
//  Created by Cédric Bahirwe on 15/06/2021.
//


import Combine
import Foundation

public enum TimerMode {
    case running, paused, initial
}

class TimerStoreModel: ObservableObject {
    @Published var timerMode: TimerMode = .initial
    @Published var secondsLeft = UserDefaults.standard.integer(forKey: "timerLength")
//        {
//        didSet {
//            objectWillChange.send(self)
//        }
//    }
    var timer = Timer()
    
    public func startCounter() {
        timerMode = .running
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { timer in

            if self.secondsLeft == 0 {
                self.resetCounter()
            }
            self.secondsLeft -= 1
            
        })
        
    }
    
    public func resetCounter() {
        timerMode = .initial
        secondsLeft = UserDefaults.standard.integer(forKey: "timerLength")
        timer.invalidate()
    }
    
    public func pauseCounter() {
        timerMode = .paused
        timer.invalidate()
    }
    
    public func setTimerLength(minutes: Int) {
        let defaults = UserDefaults.standard
        defaults.set(minutes, forKey: "timerLength")
        secondsLeft = minutes
    }
}
