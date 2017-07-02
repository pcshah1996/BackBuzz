//
//  ViewController.swift
//  BackBuzz
//
//  Created by Prateek Shah on 7/1/17.
//  Copyright © 2017 Prateek Shah. All rights reserved.
//

import UIKit
import AudioToolbox.AudioServices
import AVFoundation

class ViewController: UIViewController {

    //MARK: Properties
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var timeCount: UILabel!
    @IBOutlet weak var bottomLabel: UILabel!
    @IBOutlet weak var onOffText: UILabel!
    @IBOutlet weak var timeSlider: UISlider!
    @IBOutlet weak var activateBuzz: UISwitch!
    
    var timeInterval: Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback, with: .mixWithOthers)
            print("AV running")
            do {
                try AVAudioSession.sharedInstance().setActive(true)
                print("AV is Active")
            } catch {
                print(error)
            }
        } catch {
            print(error)
        }
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
        AudioServicesPlayAlertSound(kSystemSoundID_Vibrate);
    }

    @IBAction func activateBuzz(_ sender: UISwitch, forEvent event: UIEvent) {
        if sender.isOn == true {
            topLabel.text = "Buzzing every"
            timeSlider.alpha = 0.2
            timeSlider.isEnabled = false

        } else {
            topLabel.text = "Buzz every"
            timeSlider.alpha = 1
            timeSlider.isEnabled = true
        }
    }
}

