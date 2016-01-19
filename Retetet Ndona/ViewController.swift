//
//  ViewController.swift
//  Retetet Ndona
//
//  Created by Banu Antoro on 12/14/15.
//  Copyright © 2015 Banu Antoro. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet var buttonsContainer: UIView!
    
    @IBOutlet weak var selector: UISegmentedControl!
    
    var buttons = [RDButton]()
    
    var audioPlayer:AVAudioPlayer!
    var maxVol:CGFloat!
    
    var audioName = [
        "train-whistle-01",
        "motorcycle-start-and-revs-02",
        "grass-trimmer-1",
        "bell-ring-01"
    ]
    var motorTypes = ["A", "B", "C", "D"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
//        button[1] = RDButton()
        
        

        let audioFilePath = NSBundle.mainBundle().pathForResource("motorcycle-start-and-revs-02", ofType: "wav")
        
        if audioFilePath != nil {
            
            let audioFileUrl = NSURL.fileURLWithPath(audioFilePath!)
            
            do {
                try audioPlayer = AVAudioPlayer(contentsOfURL: audioFileUrl, fileTypeHint: nil)
                audioPlayer.numberOfLoops = -1
            } catch {
                print("audio file is not found")
            }
            
            
        } else {
            print("audio file is not found")
        }
        
        maxVol = view.bounds.height
        
    }
    
    var buttonWidth:CGFloat!
    var buttonHeight:CGFloat!
    
    override func viewDidAppear(animated: Bool) {
        buttonWidth = (buttonsContainer.bounds.width-40)/4
        buttonHeight = buttonsContainer.frame.size.height - 16
        
        for index in 0...3 {
            
            let button = RDButton(frame: CGRect(x: (CGFloat(index) * (buttonWidth + 8)) + 8, y: 8, width: buttonWidth, height: buttonHeight))
            //            button.frame = CGRect(x: index * 100, y: 0, width: 100, height: 100)
            button.backgroundColor = UIColor.lightGrayColor()
//            button.audioName("motor_jay-" + motorTypes[0] + "-" + String(index+1))
            
            buttons.append(button)
            buttons[index].audioName("motor_jay-" + motorTypes[0] + "-" + String(index+1))
            
            buttonsContainer.addSubview(button)
            
        }
        

    }
    @IBAction func selectorValueChanged(sender: AnyObject) {
        for index in 0...3 {
            buttons[index].setAudioName("motor_jay-" + motorTypes[sender.selectedSegmentIndex] + "-" + String(index+1), index: index)
//            print("motor_jay-" + motorTypes[sender.selectedSegmentIndex] + "-" + String(index+1))
            buttons[index].audioPlayer.stop()
        }
//        print(motorTypes[sender.selectedSegmentIndex])
    }
   
//    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
//        buttonWidth = (buttonsContainer.bounds.width-40)/4
//        buttonHeight = buttonsContainer.frame.size.height - 16
//        for index in 0...3 {
//            buttons[index].frame = CGRect(x: (CGFloat(index) * (buttonWidth + 8)) + 8, y: 8, width: buttonWidth, height: buttonHeight)
//        }
//        
//    }
    
    override func didRotateFromInterfaceOrientation(fromInterfaceOrientation: UIInterfaceOrientation) {
        buttonWidth = (buttonsContainer.bounds.width-40)/4
        buttonHeight = buttonsContainer.frame.size.height - 16
        for index in 0...3 {
            buttons[index].frame = CGRect(x: (CGFloat(index) * (buttonWidth + 8)) + 8, y: 8, width: buttonWidth, height: buttonHeight)
        }
    }
    
}

