//
//  SplashScreenViewController.swift
//  JeopardyTrainer
//
//  Created by Kim-An Quinn on 12/13/19.
//  Copyright © 2019 Kim-An Quinn. All rights reserved.
//

import UIKit
import AVFoundation

class SplashScreenViewController: UIViewController {
    @IBOutlet weak var logoImageView: UIImageView!
    
    var yAtLaunch: CGFloat = 0.0
    var audioPlayer = AVAudioPlayer()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        yAtLaunch = logoImageView.frame.origin.y
        logoImageView.frame.origin.y = self.view.frame.height
    }
    
    override func viewDidAppear(_ animated: Bool) {
        playSound(soundName: "jeopardy-intro", audioPlayer: &audioPlayer)
        UIView.animate(withDuration: 2.0) {
            self.logoImageView.frame.origin.y = self.yAtLaunch
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if audioPlayer.isPlaying{
            audioPlayer.stop()
        }
    }
    
    func playSound(soundName: String, audioPlayer: inout AVAudioPlayer){
        if let sound = NSDataAsset(name: soundName){
            do{
                try audioPlayer = AVAudioPlayer(data: sound.data)
                audioPlayer.play()
            }catch{
                print("Error: Data from sound could not be played as audio file")
            }
        }else{
            print("Error: could not load data from sound")
        }
    }
    
    @IBAction func logoTapped(_ sender: UITapGestureRecognizer) {
        performSegue(withIdentifier: "ShowCategories", sender: nil)
    }
    
}
