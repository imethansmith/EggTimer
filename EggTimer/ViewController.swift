//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    // Initalise audio output
    var player: AVAudioPlayer?
    
    // Initialise timer and countdown variables
    var timer = Timer()
    var counter = 60
    var countdownRatio: Double = 1.0
    var currentCountdown: Double = 1.0
    
    // Initalise default values for egg timer
    let eggTimes = ["Soft": 3, "Medium": 33, "Hard": 720]
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        // Invalidated any active timers
        timer.invalidate()
        
        // Reset environment and setup timer settings
        let hardness = sender.currentTitle!
        currentCountdown = 1.0
        counter = eggTimes[hardness]!
        countdownTimerLabel.text = "\(counter) seconds."
        countdownRatio = 1.0 / Double(counter)
        countdownProgressBar.progress = 1
        
        // Start new timer with new settings
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
    }
    
    @objc func updateCounter() {
        // Continue if timer still active
        if counter > 0 {
            // Continue countdown, update variables
            currentCountdown -= countdownRatio
            counter -= 1
            // Set label and progress bar
            countdownTimerLabel.text = "\(counter) seconds."
            if (Float(currentCountdown - countdownRatio) >= 0) {
                countdownProgressBar.progress = Float(currentCountdown)
            } else {
                countdownProgressBar.progress = 0.0
            }
        } else {
            // If timer complete, finish countdown and play alarm sound
            timer.invalidate()
            playSound()
            countdownTimerLabel.text = "Done!"
        }
    }
    
    func playSound() {
        // Egg Timer Alarm Sound
            let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
            player = try! AVAudioPlayer(contentsOf: url!)
            player!.play()
                    
        }

    @IBOutlet weak var countdownProgressBar: UIProgressView!
    
    @IBOutlet weak var countdownTimerLabel: UILabel!
}
