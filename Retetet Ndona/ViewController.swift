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

    var backgroundColors = [
        UIColor(red: 0.643, green: 0.561, blue: 0.212, alpha: 1.00),
        UIColor(red: 0.157, green: 0.475, blue: 0.251, alpha: 1.00),
        UIColor(red: 0.643, green: 0.271, blue: 0.212, alpha: 1.00),
        UIColor(red: 0.235, green: 0.180, blue: 0.443, alpha: 1.00)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = backgroundColors[0]
        selector.tintColor = backgroundColors[0]
    }
    
    var buttonWidth:CGFloat!
    var buttonHeight:CGFloat!
    
    override func viewDidAppear(animated: Bool) {
        buttonWidth = (buttonsContainer.bounds.width-40)/4
        buttonHeight = buttonsContainer.frame.size.height - 16
        
        for index in 0...3 {
            
            let button = RDButton(frame: CGRect(x: (CGFloat(index) * (buttonWidth + 8)) + 8, y: 8, width: buttonWidth, height: buttonHeight))
            button.backgroundColor = UIColor.lightGrayColor()

            buttons.append(button)
            buttons[index].audioName("motor_jay-" + motorTypes[0] + "-" + String(index+1))
            
            buttonsContainer.addSubview(button)

        }
    }
    @IBAction func selectorValueChanged(sender: AnyObject) {
        self.view.backgroundColor = backgroundColors[sender.selectedSegmentIndex]
        selector.tintColor = backgroundColors[sender.selectedSegmentIndex]
        for index in 0...3 {
            buttons[index].setAudioName("motor_jay-" + motorTypes[sender.selectedSegmentIndex] + "-" + String(index+1), index: index)
            buttons[index].audioPlayer.stop()
        }
    }
   

    
    override func didRotateFromInterfaceOrientation(fromInterfaceOrientation: UIInterfaceOrientation) {
        buttonWidth = (buttonsContainer.bounds.width-40)/4
        buttonHeight = buttonsContainer.frame.size.height - 16
        for index in 0...3 {
            buttons[index].frame = CGRect(x: (CGFloat(index) * (buttonWidth + 8)) + 8, y: 8, width: buttonWidth, height: buttonHeight)
        }
    }
    
}

