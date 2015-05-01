//
//  ViewController.swift
//  pitchPerfect
//
//  Created by john galatti on 4/17/15.
//  Copyright (c) 2015 john galatti. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate{

    @IBOutlet weak var microphoneButton: UIButton!
    
    @IBOutlet weak var recordingLabel: UILabel!
    
    
    var audioRecorder:AVAudioRecorder!
    var recordedAudio:RecordedAudio!
    
    @IBOutlet weak var stopButton: UIButton!
    
    
        override func viewDidLoad() {
        super.viewDidLoad()
            }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
            }
    override func viewWillAppear(animated: Bool) {
        recordingLabel.text="Tap to Record"
        recordingLabel.hidden=false
        
        stopButton.hidden=true
    }
    


    @IBAction func recordAudio(sender: AnyObject) {
        println("recording audio")
        recordingLabel.hidden=false
        recordingLabel.text="Recording"
        
        stopButton.hidden=false
        microphoneButton.enabled=false
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as! String
        let currentDateTime = NSDate()
        let formatter = NSDateFormatter()
        formatter.dateFormat = "ddMMyyyy-HHmmss"
        let recordingName = formatter.stringFromDate(currentDateTime)+".wav"
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        println(filePath)
        var session = AVAudioSession.sharedInstance()
        session.setCategory(AVAudioSessionCategoryPlayAndRecord, error: nil)
        
        audioRecorder = AVAudioRecorder(URL: filePath, settings: nil, error: nil)
        audioRecorder.meteringEnabled = true
        audioRecorder.delegate=self
        
        
        audioRecorder.record()
    }
    
    @IBAction func stopRecording(sender: AnyObject) {
        recordingLabel.hidden=true
        stopButton.hidden=true
        microphoneButton.enabled=true
        audioRecorder.stop()
        
        var audioSession = AVAudioSession.sharedInstance()
        audioSession.setActive(false, error: nil)
    }
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder!, successfully flag: Bool) {
        if(flag)
        {
            recordedAudio=RecordedAudio(filePathUrl:recorder.url
                ,title:recorder.url.lastPathComponent)
            
            
        
            self.performSegueWithIdentifier("stopRecording", sender: recordedAudio)
        }
        else
        {
            println("DID NOT FINISH")
        }
    }
       override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        println(segue.identifier)
        if(segue.identifier == "stopRecording")
        {
            let playSoundsVC:playRecordedSoundViewController=segue.destinationViewController as! playRecordedSoundViewController
            
            
            let data=sender as! RecordedAudio
            playSoundsVC.receivedAudio=data
        }
        
    }
  
}

