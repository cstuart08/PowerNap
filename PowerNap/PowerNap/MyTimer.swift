//
//  MyTimer.swift
//  PowerNap
//
//  Created by Cameron Stuart on 8/6/19.
//  Copyright © 2019 Cameron Stuart. All rights reserved.
//

import Foundation

protocol MyTimerDelegate: class {
    func timerSecondTicked()
    func timerHasStopped()
    func timerHasCompleted()
}

class MyTimer {
    private var timer: Timer?
    weak var delegate: MyTimerDelegate?
    
    // time left
    var timeLeft: TimeInterval?
    
    // timer is on or off
    var isOn: Bool {
        if timeLeft == nil {
            return false
        } else {
            return true
        }
    }
    
    // func to start timer
    func startTimer(_ time: TimeInterval) {
        if isOn {
            // do nothing
            print("Mistake made, timer should not be restarted.")
        } else {
            timeLeft = time
            timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { (_) in
                self.secondTicked()
            })
        }
    }
    
    // func to stop timer
    func stopTimer() {
        self.timeLeft = nil
        timer?.invalidate()
        print("Stop Timer.")
        delegate?.timerHasStopped()
    }
    
    // convert seconds to min/sec string
    func timeLeftAsString() -> String {
        let timeRemaining = Int(self.timeLeft ?? 20 * 60)
        let minutesLeft = timeRemaining / 60
        let secondsLeft = timeRemaining - (minutesLeft * 60)
        return String(format: "%02d : %02d", arguments: [minutesLeft, secondsLeft])
    }
    
    // private method to determine what happens when a second ticks by
    private func secondTicked() {
        // check to see how much time is left
        guard let timeLeft = timeLeft else {
            print("Someone forgot to reset timeleft.")
            return
        }
        // if greater than 0, reduce time left by 1
        if timeLeft > 0 {
            self.timeLeft = timeLeft - 1
            delegate?.timerSecondTicked()
            print(self.timeLeftAsString())
        } else {
            // otherwise stop timer because it is finished.
            self.timeLeft = nil
            timer?.invalidate()
            print("Timer Finished.")
            delegate?.timerHasCompleted()
        }
    }
}
