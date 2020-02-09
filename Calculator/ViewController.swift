//
//  ViewController.swift
//  Calculator
//
//  Created by Radu Onescu on 07/02/2020.
//  Copyright © 2020 Radu Onescu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var resultLabel: UILabel!
    
    var numberOnScreen: Double = 0
    var previousNumber: Double = 0
    var operation = ""
    var isPerformingOperation = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resultLabel.text=""
    }
    
    //Make the status bar text white
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    
    @IBAction func handleNumberPress(_ sender: UIButton) {
        
        let numberPressed = sender.titleLabel?.text
        
        if(isPerformingOperation)
        {
            isPerformingOperation = false
            resultLabel.text = numberPressed
            numberOnScreen = Double(resultLabel.text!)!
        } else {
            resultLabel.text = resultLabel.text! + numberPressed!
            numberOnScreen = Double(resultLabel.text!)!
        }
        
    }
    
    @IBAction func handleOperatorPress(_ sender: UIButton) {
        let operatorPressed = sender.titleLabel?.text
        isPerformingOperation = true;
        operation = operatorPressed!
        
        switch operatorPressed {
        case "AC":
            resultLabel.text = ""
            numberOnScreen = 0
            previousNumber = 0
            operation = ""
            return
        case "+/-":
            isPerformingOperation = true
            previousNumber = Double(resultLabel.text!)!
            resultLabel.text = "+/-"
            operation = "+/-"
        case "%":
            isPerformingOperation = true
             previousNumber = Double(resultLabel.text!)!
            resultLabel.text = "%"
            operation = "%"
        case "÷":
            isPerformingOperation = true
             previousNumber = Double(resultLabel.text!)!
            resultLabel.text = "÷"
            operation = "÷"
        case "x":
            isPerformingOperation = true
             previousNumber = Double(resultLabel.text!)!
            resultLabel.text = "x"
            operation = "x"
        case "-":
            isPerformingOperation = true
             previousNumber = Double(resultLabel.text!)!
            resultLabel.text = "-"
            operation = "-"
        case "+":
            isPerformingOperation = true
            previousNumber = Double(resultLabel.text!)!
            resultLabel.text = "+"
            operation = "+"
        case "=":
            switch operation {
            case "+":
                resultLabel.text = String(previousNumber + numberOnScreen)
            case "-":
                resultLabel.text = String(previousNumber - numberOnScreen)
            case "x":
            resultLabel.text = String(previousNumber * numberOnScreen)
            case "÷":
                resultLabel.text = String(previousNumber / numberOnScreen)
            case "%":
                resultLabel.text = String(previousNumber.truncatingRemainder(dividingBy: numberOnScreen) )
            default:
                return
            }
            
        case ".":
            print(".")
        default:
            print("default")
        }
    }

}

