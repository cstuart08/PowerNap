//
//  AppDelegate.swift
//  PowerNap
//
//  Created by Cameron Stuart on 8/6/19.
//  Copyright © 2019 Cameron Stuart. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { (success, _) in
            if success {
                print("User allowed us to send alerts.")
            }
        }

        return true
    }
}

