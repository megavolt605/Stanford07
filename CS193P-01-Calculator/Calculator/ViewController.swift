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
        isUserEntering = false
        switch operation {
        case "π":
            displayValue = Double.pi
        case "√":
            displayValue = sqrt(displayValue)
        default:
            break
        }
    }
}

