//
//  playRecordedSoundViewController.swift
//  pitchPerfect
//
//  Created by john galatti on 4/17/15.
//  Copyright (c) 2015 john galatti. All rights reserved.
//


import UIKit
import AVFoundation


class playRecordedSoundViewController: UIViewController {
    var audPlayer: audioPlayer!
    var receivedAudio:RecordedAudio!
    var audioEngine: AVAudioEngine!
    var audioFile: AVAudioFile!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        audPlayer=audioPlayer(argFilePathUrl:receivedAudio.filePathUrl)
        
        audioEngine = AVAudioEngine()
        audioFile = AVAudioFile(forReading: receivedAudio.filePathUrl, error: nil)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func playPitchedAudio(pitch: Float) {
        audPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        var changePitch = AVAudioUnitTimePitch()
        changePitch.pitch = pitch
        audioEngine.attachNode(changePitch)
        audioEngine.connect(audioPlayerNode, to: changePitch, format: nil)
        audioEngine.connect(changePitch, to: audioEngine.outputNode, format: nil)
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        
        audioPlayerNode.play()
        
    }
    
    
    
    @IBAction func playSlowSound(sender: AnyObject) {
        audioEngine.stop()
        audioEngine.reset()
        audPlayer.playAudioFile(false,atBegin:false,rate:0.5)

    }
    
    
    @IBAction func playFastSound(sender: AnyObject) {
        audioEngine.stop()
        audioEngine.reset()
        audPlayer.playAudioFile(true,atBegin:true,rate:1.5)
        
    }
    
    @IBAction func playChipMunkAdio(sender: AnyObject) {
            playPitchedAudio(1000)
        
    }
    
    @IBAction func playDarkVaderAudio(sender: AnyObject) {
        playPitchedAudio(-1000)
    }
    
    @IBAction func stopAudio(sender: AnyObject) {
        audioEngine.stop()
        audioEngine.reset()
        audPlayer?.stop()
    }
}
