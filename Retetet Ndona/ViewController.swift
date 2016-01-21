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
    var motorTypes = ["A", "B", "C", "D"]

    override func viewDidLoad() {
        super.viewDidLoad()
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
   

    
    override func didRotateFromInterfaceOrientation(fromInterfaceOrientation: UIInterfaceOrientation) {
        buttonWidth = (buttonsContainer.bounds.width-40)/4
        buttonHeight = buttonsContainer.frame.size.height - 16
        for index in 0...3 {
            buttons[index].frame = CGRect(x: (CGFloat(index) * (buttonWidth + 8)) + 8, y: 8, width: buttonWidth, height: buttonHeight)
        }
    }
    
}

