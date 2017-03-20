//
//  ViewController.swift
//  retroCalculatorClearBtn
//
//  Created by Sebastian Tracey on 19/03/2017.
//  Copyright © 2017 Sebastian Tracey. All rights reserved.
//

import UIKit
import AVFoundation


class ViewController: UIViewController {
    
    enum Operation: String {
        case Divide = "/"
        case Multiply = "*"
        case Add = "+"
        case Subtract = "-"
        case Empty = "Empty"
    }
    
    @IBOutlet weak var outputLbl: UILabel!
    
    var btnSound: AVAudioPlayer!
    
    var runningNumber = ""
    var leftValStr = ""
    var rightValStr = ""
    var currentOperation: Operation = Operation.Empty
    var result = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path = Bundle.main.path(forResource: "btn", ofType: "wav")!
        let url = URL(fileURLWithPath: path)
        
        do {
            try btnSound = AVAudioPlayer(contentsOf: url)
            btnSound.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
        
    }

    @IBAction func numberPressed(btn: UIButton!) {
        playSound()
        
        runningNumber += "\(btn.tag)"
        outputLbl.text = runningNumber
        
    }
    
    @IBAction func onAddPressed(_ sender: Any) {
        processOperation(op: Operation.Add)
    }
    @IBAction func onSubtractPressed(_ sender: Any) {
        processOperation(op: Operation.Subtract)
    }
    @IBAction func onMultiplyPressed(_ sender: Any) {
        processOperation(op: Operation.Multiply)
    }
    @IBAction func onDividePressed(_ sender: Any) {
        processOperation(op: Operation.Divide)
    }
    @IBAction func onEqualPressed(_ sender: Any) {
        processOperation(op: currentOperation)
    }
    @IBAction func onClearPressed(_ sender: Any) {
        playSound()
        
        leftValStr = ""
        rightValStr = ""
        runningNumber = ""
        outputLbl.text = "0"
        currentOperation = Operation.Empty
        
        print("left = " + leftValStr)
        print("rigth = " + rightValStr)
        print("running + " + runningNumber)
        print("current + " + "\(currentOperation)")
    }
    
    func processOperation(op: Operation) {
        playSound()
        
        if currentOperation != Operation.Empty {
            
            // run some math
            // User selected a operater, but then selected another operater without first entering a number
            if runningNumber != "" {
                rightValStr = runningNumber
                runningNumber = ""
                
                if currentOperation == Operation.Add {
                    result = "\(Double(leftValStr)! + Double(rightValStr)!)"
                } else if currentOperation == Operation.Subtract {
                    result = "\(Double(leftValStr)! - Double(rightValStr)!)"
                } else if currentOperation == Operation.Multiply {
                    result = "\(Double(leftValStr)! * Double(rightValStr)!)"
                } else if currentOperation == Operation.Divide {
                    result = "\(Double(leftValStr)! / Double(rightValStr)!)"
                }
                
                leftValStr = result
                outputLbl.text = result
            }
            
            currentOperation = op
        } else {
        // This is the first time the oprater is pressed
        
        leftValStr = runningNumber
        runningNumber = ""
        currentOperation = op
        }
    }
    
    func playSound() {
        if btnSound.isPlaying {
            btnSound.stop()
        }
            btnSound.play()
    }

}

