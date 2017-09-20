//
//  ViewController.swift
//  RomanNumerals
//
//  Created by Stefan Petcu on 21/03/2017.
//  Copyright © 2017 Stefan Petcu. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var arabicTextField: UITextField!
    @IBOutlet weak var romanTextField: UITextField!
    
    let baseRomanNumerals = [1: "I", 5: "V", 10: "X", 50: "L", 100: "C", 500: "D", 1000: "M"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        arabicTextField.text = "0"
        romanTextField.text = "nulla"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func enteredArabicNumber(_ sender: UITextField) {
        if !isCoercibleToInt(sender.text!) || "0" == sender.text || Int(sender.text!)! < 0 {
            sender.text = "0"
            romanTextField.text = "nulla"
            
            return
        }
        
        let value = Int(sender.text!)!
        
        if value > 3999 {
            sender.text = "3999"
        }
        
        romanTextField.text = convertToRomanNumerals(sender.text!)
    }

    @IBAction func enteredRomanNumber(_ sender: UITextField) {
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        self.view.endEditing(true)
        
        return true
        
    }
    
    // MARK: Private methods.
    private func isCoercibleToInt(_ value: String) -> Bool {
        return Int(value) != nil
    }
    
    private func convertToRomanNumerals(_ value: String, _ output: String = "", _ step: Int = 1) -> String {
        var numericValue = Int(value)!
        
        while numericValue > 0 {
            let relevantBaseNumber = 5 * Int(pow(Double(10), Double(step - 1)))
            let numberPiece = numericValue % Int(pow(Double(10), Double(step)))
            
            var newOutput = ""
            
            if numberPiece != 0 {
                if numberPiece == relevantBaseNumber {
                    newOutput = baseRomanNumerals[relevantBaseNumber]!
                } else if numberPiece < relevantBaseNumber {
                    if numberPiece == 5 * Int(pow(Double(10), Double(step - 1))) - Int(pow(Double(10), Double(step - 1))) {
                        newOutput = baseRomanNumerals[Int(pow(Double(10), Double(step - 1)))]!
                            + baseRomanNumerals[5 * Int(pow(Double(10), Double(step - 1)))]!
                    } else {
                        var temp = numberPiece
                    
                        while temp > 0 {
                            newOutput += baseRomanNumerals[Int(pow(Double(10), Double(step - 1)))]!
                            temp -= Int(pow(Double(10), Double(step - 1)))
                        }
                    }
                } else if numberPiece > relevantBaseNumber {
                    if numberPiece > 2 * relevantBaseNumber {
                        var temp = numberPiece
                        
                        while temp > 0 {
                            newOutput += baseRomanNumerals[Int(pow(Double(10), Double(step)))]!
                            temp -= Int(pow(Double(10), Double(step)))
                        }
                    } else if numberPiece == 10 * Int(pow(Double(10), Double(step - 1))) - Int(pow(Double(10), Double(step - 1))) {
                        newOutput = baseRomanNumerals[Int(pow(Double(10), Double(step - 1)))]!
                            + baseRomanNumerals[10 * Int(pow(Double(10), Double(step - 1)))]!
                    } else {
                        var temp = numberPiece
                    
                        newOutput = baseRomanNumerals[5 * Int(pow(Double(10), Double(step - 1)))]!
                        temp -= 5 * Int(pow(Double(10), Double(step - 1)))
                    
                        while temp > 0 {
                            newOutput += baseRomanNumerals[Int(pow(Double(10), Double(step - 1)))]!
                            temp -= Int(pow(Double(10), Double(step - 1)))
                        }
                    }
                }
            
                numericValue -= numberPiece
            }
            
            return convertToRomanNumerals(String(describing: numericValue), newOutput + output, step + 1)
        }
        
        return output
    }
}

