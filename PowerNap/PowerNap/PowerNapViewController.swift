//
//  PowerNapViewController.swift
//  PowerNap
//
//  Created by Cameron Stuart on 8/6/19.
//  Copyright © 2019 Cameron Stuart. All rights reserved.
//

import UIKit
import UserNotifications

class PowerNapViewController: UIViewController {
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var timeButton: UIButton!
    
    var myTimer = MyTimer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        myTimer.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated
    }
    
    @IBAction func timerButtonTapped(_ sender: UIButton) {
        if myTimer.isOn {
            //stop the timer
            myTimer.stopTimer()
        } else {
            //stop the timer
            myTimer.startTimer(10)
            scheduleLocalAlert(timeInterval: 10)
        }
    }
    
    func updateLabelAndButton() {
        timeLabel.text = myTimer.timeLeftAsString()
        var title = "Start Nap"
        if myTimer.isOn {
            title = "Stop"
        }
        timeButton.setTitle(title, for: .normal)
    }
    
    func createAlartController() {
        let alert = UIAlertController(title: "Time To Wake Up", message: "Or is it?", preferredStyle: .alert)
        
        let dismissAction = UIAlertAction(title: "I'm Up", style: .default, handler: nil)
        alert.addAction(dismissAction)
        
        let snoozeAction = UIAlertAction(title: "Snooze", style: .destructive) { (_) in
            let textField = alert.textFields?.first
            let timeAsString = textField?.text
            let timeAsDouble = Double(timeAsString!)!
            
            self.myTimer.startTimer(timeAsDouble * 60)
            self.scheduleLocalAlert(timeInterval: timeAsDouble * 60)
        }
        alert.addAction(snoozeAction)
        
        alert.addTextField { (textField) in
            textField.placeholder = "Add minutes to snooze?"
            textField.keyboardType = .numberPad
            
        }
        
        present(alert, animated: true, completion: nil)
    }
    
    func scheduleLocalAlert(timeInterval: TimeInterval) {
        
        let content = UNMutableNotificationContent()
        content.title = "Title"
        content.subtitle = "Subtitle"
        content.body = "Body"
        content.badge = 10
        content.sound = UNNotificationSound.default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeInterval, repeats: false)
        
        let request = UNNotificationRequest(identifier: "Identifier", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { (_) in
            print("User asked to get a local notification.")
        }
    }
}

// MyTimerDelegate Methods
extension PowerNapViewController: MyTimerDelegate {
    func timerSecondTicked() {
        updateLabelAndButton()
    }
    
    func timerHasStopped() {
        updateLabelAndButton()
    }
    
    func timerHasCompleted() {
        updateLabelAndButton()
        createAlartController()
    }
}
