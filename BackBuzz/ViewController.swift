//
//  ViewController.swift
//  BackBuzz
//
//  Created by Prateek Shah on 7/1/17.
//  Copyright © 2017 Prateek Shah. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {

    //MARK: Properties
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var timeCount: UILabel!
    @IBOutlet weak var bottomLabel: UILabel!
    @IBOutlet weak var onOffText: UILabel!
    @IBOutlet weak var timeSlider: UISlider!
    @IBOutlet weak var activateBuzz: UISwitch!
    
    var timeInterval: Int = 1
    var prevBrightness: CGFloat = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: Actions
    @IBAction func timeSlider(_ sender: UISlider, forEvent event: UIEvent) {
        timeInterval = Int(sender.value)
        timeCount.text = "\(timeInterval)"
        if (timeInterval == 1) {
            bottomLabel.text = "minute"
        } else {
            bottomLabel.text = "minutes"
        }
    }

    @IBAction func activateBuzz(_ sender: UISwitch, forEvent event: UIEvent) {
        let center = UNUserNotificationCenter.current()
        if sender.isOn == true {
            center.getNotificationSettings { (settings) in
                if settings.authorizationStatus == .authorized {
                    self.askForNotifications()
                }
            }
            
            topLabel.text = "Buzzing every"
            timeSlider.alpha = 0.2
            timeSlider.isEnabled = false
            for idx in 0...5 {
                let notif = NotificationItem(deadline: Date() + Double(idx * 5) , title: "Wooooo!", UUID: UUID().uuidString)
                NotificationQueue.sharedInstance.addItem(notif)
            }
            UIApplication.shared.isIdleTimerDisabled = true
            prevBrightness = UIScreen.main.brightness
            UIScreen.main.brightness = CGFloat(0.01)
            
            

        } else {
            NotificationQueue.sharedInstance.clear()
            topLabel.text = "Buzz every"
            timeSlider.alpha = 1
            timeSlider.isEnabled = true
            UIApplication.shared.isIdleTimerDisabled = false
            UIScreen.main.brightness = prevBrightness
        }
    }
    
    func askForNotifications() {
        let alert = UIAlertController(title: "Notifications Not Enabled",
                                      message: " Please enable in Settings>blah>blah \n and return to this page",
                                      preferredStyle: .alert)
        
        let submitAction = UIAlertAction(title: "Did it!", style: .default, handler: { (action) -> Void in
            print("They said it's enabled")
        })
        
        let cancelBtn = UIAlertAction(title: "Cancel", style: .destructive, handler: { (action) -> Void in })

        alert.addTextField { (textField: UITextField) in
            textField.keyboardAppearance = .dark
            textField.keyboardType = .default
            textField.autocorrectionType = .default
            textField.placeholder = "Type something here"
            textField.clearButtonMode = .whileEditing
        }
        
        alert.addAction(submitAction)
        alert.addAction(cancelBtn)
        present(alert, animated: true, completion: nil)
    }
}

