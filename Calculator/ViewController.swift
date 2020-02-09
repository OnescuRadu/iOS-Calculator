//
//  ViewController.swift
//  Calculator
//
//  Created by Radu Onescu on 07/02/2020.
//  Copyright © 2020 Radu Onescu. All rights reserved.
//

import UIKit

extension Double {
    //Formatter to remove trailing zeros from Double
    //Returns String
    func removeZerosFromEnd() -> String {
        let formatter = NumberFormatter()
        let number = NSNumber(value: self)
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 9 //maximum 9 decimals
        return String(formatter.string(from: number) ?? "")
    }
}

class ViewController: UIViewController {
    
    //Reference to the result label
    @IBOutlet weak var resultLabel: UILabel!

    
    var firstNumber = 0.0
    var resultNumber = 0.0
    var currentOperation = ""
    var isPerformingOperation = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resultLabel.text = "0"
        //Adjust font size to fit in the result label
        resultLabel.adjustsFontSizeToFitWidth = true
    }
    
    //Make the status bar text white
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
    @IBAction func handleNumberPress(_ sender: UIButton) {
        
        //If it is performing operation remove the operator symbol from the result label
        if isPerformingOperation{
            resultLabel.text = "0"
            isPerformingOperation = false
        }
        
        let number = sender.titleLabel?.text
        
        //If result label is 0 change it to to pressed number else concatenate the pressed number to the previos number
        if resultLabel.text == "0" {
            resultLabel.text = number
        }
        else if let text = resultLabel.text {
            resultLabel.text = text + String(number!)
        }
        
    }
    
    
    @IBAction func clearResult(_ sender: UIButton) {
        resultLabel.text = "0"
        currentOperation = ""
        firstNumber = 0.0
    }
    
    //Avoid having "00" in the result label
    @IBAction func handleZeroPress(_ sender: UIButton) {
        if resultLabel.text != "0" {
            if let text = resultLabel.text {
                resultLabel.text = "\(text)\(0)"
            }
        }
    }
    
    //Making the number negative or positive
    @IBAction func handlePositiveNegative(_ sender: UIButton) {
        if(resultLabel.text != "0")
        {
            resultLabel.text = (-Double(resultLabel.text!)!).removeZerosFromEnd()
        }
    }
    
    //Add decimal if there is no other decimal already
    @IBAction func handleDecimal(_ sender: UIButton) {
        if resultLabel.text?.contains(".") == false
        {
            resultLabel.text?.append(".")
        }
    }
    
    
    //Handle the press of operator symbols
    @IBAction func handleOperatorPress(_ sender: UIButton) {
        
        let pressedOperator = sender.titleLabel?.text
        
        if firstNumber == 0.0, resultLabel.text != "" {
            firstNumber = Double(resultLabel.text!)!
        }
        
        if pressedOperator == "=" {
            if currentOperation != "" {
                var secondNumber = 0.0
                if resultLabel.text != ""
                {
                    secondNumber = Double(resultLabel.text!)!
                }
                
                switch currentOperation {
                case "+":
                    resultLabel.text = (firstNumber + secondNumber).removeZerosFromEnd()
                    break
                    
                case "-":
                    resultLabel.text = (firstNumber - secondNumber).removeZerosFromEnd()
                    break
                    
                case "x":
                    resultLabel.text = (firstNumber * secondNumber).removeZerosFromEnd()
                    break
                    
                case "÷":
                    resultLabel.text = (firstNumber / secondNumber).removeZerosFromEnd()
                    break
                    
                case "%":
                    resultLabel.text = (firstNumber.truncatingRemainder(dividingBy: secondNumber)).removeZerosFromEnd()
                    break
                    
                default:
                    print(currentOperation)
                }
            }
        }
        else
        {
            firstNumber = Double(resultLabel.text!)!
            resultLabel.text = pressedOperator
            currentOperation = pressedOperator!
            isPerformingOperation = true
        }
        
    }
}


