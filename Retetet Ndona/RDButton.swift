//
//  RDButton.swift
//  Retetet Ndona
//
//  Created by Banu Antoro on 12/15/15.
//  Copyright © 2015 Banu Antoro. All rights reserved.
//

import UIKit
import AVFoundation

class RDButton: UIButton {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    var audioName:String!
    var audioPlayer:AVAudioPlayer!
    var audioPlayers = [AVAudioPlayer]()
    var index:Int! = 0
    var motorType:String! = "A"
    var playing = [Int]()
    
    var touchArea = UIView()
    var touchAreaSize = CGSize(width: 100.0, height: 100.0)
    var maxVol:CGFloat!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        maxVol = bounds.height
        
        touchArea.frame = CGRect(origin: CGPoint(x: 0.0, y: 0.0), size: touchAreaSize)
        touchArea.backgroundColor = UIColor.clearColor()
        touchArea.hidden = true
        touchArea.layer.cornerRadius = 50
        touchArea.layer.borderColor = UIColor.blueColor().CGColor
        touchArea.layer.borderWidth = 5
        touchArea.clipsToBounds = true
        self.addSubview(touchArea)
        self.clipsToBounds = true
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch = (touches as NSSet).anyObject() as! UITouch
        //        let touch = touches.anyObject()! as UITouch
        let location = touch.locationInView(self)
        
        backgroundColor = UIColor(red: 1.0 - (location.y/maxVol), green: location.y/maxVol, blue: 0.0, alpha: 1.0)
        audioPlayers[index].currentTime = 0
        var volume = Float(1.0 - (location.y/(maxVol*4/5)))
        if (volume<=0.0) {
            volume = 0.0
        }
        audioPlayers[index].volume = volume
        audioPlayers[index].play()
        
        var touchX = location.x-50
        var touchY = location.y-50
        
        
        if (location.x <= 0) {
            touchX = -50
        }
        
        if (location.x >= bounds.width) {
            touchX = bounds.width - 50
        }
        
        if (location.y <= 0) {
            touchY = -50
        }
        
        if (location.y >= bounds.height) {
            touchY = bounds.height - 50
        }
        
        
        touchArea.hidden = false
        touchArea.frame = CGRect(origin: CGPoint(x: touchX, y: touchY), size: touchAreaSize)
        
////        print("playing \(playing.first)")
//        
//        if(playing.first == nil) {
//            index = 0
//        }
//        print("play \(index)")
//        playing.append(index)
//        index = index + 1
        print(audioPlayers[index].url)
//                audioPlayers[index].url?.absoluteString
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch = (touches as NSSet).anyObject() as! UITouch
        //        let touch = touches.anyObject()! as UITouch
        let location = touch.locationInView(self)
        var volume = Float(1.0 - (location.y/(maxVol*4/5)))
        if (volume<=0.0) {
            volume = 0.0
        }
        audioPlayers[index].volume = volume
        print(audioPlayers[index].volume)
        backgroundColor = UIColor(red: 1.0 - (location.y/maxVol), green: location.y/maxVol, blue: 0.0, alpha: 1.0)
        
        var touchX = location.x-50
        var touchY = location.y-50
        
        
        if (location.x <= 0) {
            touchX = -50
        }
        
        if (location.x >= bounds.width) {
            touchX = bounds.width - 50
        }
        
        if (location.y <= 0) {
            touchY = -50
        }
        
        if (location.y >= bounds.height) {
            touchY = bounds.height - 50
        }
        
        
        touchArea.hidden = false
        touchArea.frame = CGRect(origin: CGPoint(x: touchX, y: touchY), size: touchAreaSize)
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        backgroundColor = UIColor.lightGrayColor()
        audioPlayers[index].stop()
        
//        let fadeOut = audioPlayers.first!.volume/5

//        for i in 1...5 {
//            let timeToDelay = Double(i) * 1
//            delay(timeToDelay) {
//                if (i == 5) {
//                    print("stop \(self.playing.first)")
//                    self.playing.removeFirst()
//                }
//            }
//        }
        
        touchArea.hidden = true

    }
    
    func delay(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }
    
    func audioName(audioName: String) {
        self.audioName = audioName
        
        let audioFilePath = NSBundle.mainBundle().pathForResource(audioName, ofType: "wav")
        print(audioName)
        
        let audioFileUrl = NSURL.fileURLWithPath(audioFilePath!)
        
        do {
            try audioPlayer = AVAudioPlayer(contentsOfURL: audioFileUrl, fileTypeHint: nil)
            audioPlayer.numberOfLoops = -1
            audioPlayers.append(audioPlayer)
        } catch {
            print("audio file is not found")
        }

    }
    
    func setAudioName(audioName: String, index: Int) {
        self.audioName = audioName
        
        let audioFilePath = NSBundle.mainBundle().pathForResource(audioName, ofType: "wav")

        let audioFileUrl = NSURL.fileURLWithPath(audioFilePath!)
        
        print(audioName)
        do {
            try audioPlayers[0] = AVAudioPlayer(contentsOfURL: audioFileUrl, fileTypeHint: nil)
            audioPlayers[0].numberOfLoops = -1
        } catch {
            print("audio file is not found")
        }
    }
}
