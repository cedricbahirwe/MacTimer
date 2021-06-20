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

    @Published var selectedPickedTime = 22
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
    
    public func startCounting() {
        if timerMode == .initial {
            let minutes = selectedPickedTime * 60
            setTimerLength(minutes: minutes)
        }
        
        if timerMode == .running  {
            pauseCounter()
        } else {
            startCounter()
        }
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

extension TimerStoreModel {
    
    public func secondsToMinutesAndSeconds (seconds : Int) -> String {
        let minutes = "\((seconds % 3600) / 60)"
        let seconds = "\((seconds % 3600) % 60)"
        let minuteStamp = minutes.count > 1 ? minutes : "0" + minutes
        let secondStamp = seconds.count > 1 ? seconds : "0" + seconds
        return "\(minuteStamp) : \(secondStamp)"
    }
    
    public func secondsToMinutesAndSeconds (seconds : Int) -> (hrs:String, min:String, sec: String) {
        let hours = "\(seconds / 3600)"
        let minutes = "\((seconds % 3600) / 60)"
        let seconds = "\((seconds % 3600) % 60)"
        let hourStamp = hours.count > 1 ? hours : "0" + hours
        let minuteStamp = minutes.count > 1 ? minutes : "0" + minutes
        let secondStamp = seconds.count > 1 ? seconds : "0" + seconds
        return (hourStamp, minuteStamp, secondStamp)
    }
}
