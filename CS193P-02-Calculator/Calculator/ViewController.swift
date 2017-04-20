//
//  ViewController.swift
//  Calculator
//
//  Created by Igor Smirnov on 20/04/2017.
//  Copyright © 2017 Complex Numbers. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var displayLabel: UILabel!

    var isUserEntering = false
    
    var displayValue: Double {
        get {
            return Double(displayLabel.text!)!
        }
        set {
            displayLabel.text = String(newValue)
        }
    }
    
    private var brain = CalculatorBrain()
    
    @IBAction func digitsAction(_ sender: UIButton) {
        guard let digit = sender.currentTitle else { return }
        if isUserEntering {
            displayLabel.text = displayLabel.text! + digit
        } else {
            displayLabel.text = digit
            isUserEntering = true
        }
    }

    @IBAction func operationAction(_ sender: UIButton) {
        guard let operation = sender.currentTitle else { return }
        if isUserEntering {
            brain.setOperand(displayValue)
            isUserEntering = false
        }
        brain.performOperation(operation)
        if let result = brain.result {
            displayValue = result
        }
    }
}

