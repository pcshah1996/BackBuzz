//
//  ViewController.swift
//  BackBuzz
//
//  Created by Prateek Shah on 7/1/17.
//  Copyright © 2017 Prateek Shah. All rights reserved.
//

import UIKit
import AudioToolbox.AudioServices

class ViewController: UIViewController {

    //MARK: Properties
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var timeCount: UILabel!
    @IBOutlet weak var bottomLabel: UILabel!
    @IBOutlet weak var onOffText: UILabel!
    @IBOutlet weak var timeSlider: UISlider!
    @IBOutlet weak var activateBuzz: UISwitch!
    
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
        var currentValue = Int(sender.value)
        timeCount.text = "\(currentValue)"
        AudioServicesPlayAlertSound(kSystemSoundID_Vibrate);
    }

    @IBAction func activateBuzz(_ sender: UISwitch, forEvent event: UIEvent) {
    }
}

