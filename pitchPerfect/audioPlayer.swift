//
//  audioPlayer.swift
//  pitchperfet
//
//  Created by john galatti on 3/25/15.
//  Copyright (c) 2015 john galatti. All rights reserved.
//

import AVFoundation


class audioPlayer:AVAudioPlayer
{
   var filePathUrl:NSURL!    
   override  init()
    {
        
        
    
        super.init(contentsOfURL:filePathUrl! ,fileTypeHint:AVFileTypeMPEGLayer3,error:nil)
        
        
        
        
        
    }
    init(argFilePathUrl:NSURL)
    {
        filePathUrl=argFilePathUrl
        
        
        
        super.init(contentsOfURL:filePathUrl! ,fileTypeHint:AVFileTypeMPEGLayer3,error:nil)

        
    }
    func playAudioFile(stopPlay:Bool!,atBegin:Bool!,rate:Float!)
    {
        self.rate=rate;
        if(stopPlay!)
        {
            self.stop();
        }
        if(atBegin!)
        {
            self.currentTime=0.0;
        }
        self.play();
    }
    
    
}
