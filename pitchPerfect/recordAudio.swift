//
//  recordAudio.swift
//  pitchPerfect
//
//  Created by john galatti on 4/20/15.
//  Copyright (c) 2015 john galatti. All rights reserved.
//

import Foundation

class RecordedAudio:NSObject
{
    var filePathUrl:NSURL!
    var title:String!
    init(filePathUrl:NSURL,title:String!)
    {
        self.filePathUrl=filePathUrl
        self.title=title
        
    }
    
    
}