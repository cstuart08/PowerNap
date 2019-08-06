//
//  PowerNapViewController.swift
//  PowerNap
//
//  Created by Cameron Stuart on 8/6/19.
//  Copyright © 2019 Cameron Stuart. All rights reserved.
//

import UIKit

class PowerNapViewController: UIViewController {

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var timeButton: UIButton!
    
    var myTimer = MyTimer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myTimer.startTimer(3)
    }
    
    @IBAction func timerButtonTapped(_ sender: UIButton) {
        print("test start nap button")
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
