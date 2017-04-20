//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Igor Smirnov on 20/04/2017.
//  Copyright © 2017 Complex Numbers. All rights reserved.
//

import Foundation

struct CalculatorBrain {
    
    private var accumulator: Double?
    
    var result: Double? {
        return accumulator
    }
    
    private enum Operation {
        case constant(Double)
        case unaryOperation((Double) -> Double)
        case binaryOperation((Double, Double) -> Double)
        case equals
    }
    
    private struct PendingBinaryOperation {
        let function: (Double, Double) -> Double
        let firstOperand: Double
        func perform(with secondOperand: Double) -> Double {
            return function(firstOperand, secondOperand)
        }
    }
    
    private var operations: Dictionary<String, Operation> = [
        "π": .constant(Double.pi),
        "e": .constant(M_E),
        "√": .unaryOperation(sqrt),
        "cos": .unaryOperation(cos),
        "±": .unaryOperation({ -$0 }),
        "+": .binaryOperation(+),
        "-": .binaryOperation(-),
        "×": .binaryOperation(*),
        "÷": .binaryOperation(/),
        "=": .equals
    ]
    
    private var pendingBinaryOperation: PendingBinaryOperation?
    
    mutating func performOperation(_ symbol: String) {
        if let constant = operations[symbol] {
            switch constant {
            case .constant(let value):
                accumulator = value
            case .unaryOperation(let function):
                if let value = accumulator {
                    accumulator = function(value)
                }
            case .binaryOperation(let function):
                if let value = accumulator {
                    pendingBinaryOperation = PendingBinaryOperation(function: function, firstOperand: value)
                    accumulator = nil
                }
            case .equals:
                performBinaryOperation()
            }
            //accumulator = constant
        }
        
//        switch symbol {
//        case "π":
//            accumulator = Double.pi
//        case "√":
//            if let operand = accumulator {
//                accumulator = sqrt(operand)
//            }
//        default:
//            break
//        }
    }
    
    mutating func performBinaryOperation() {
        if let value = accumulator {
            accumulator = pendingBinaryOperation?.perform(with: value)
            pendingBinaryOperation = nil
        }
    }
    
    mutating func setOperand(_ operand: Double) {
        accumulator = operand
    }
    
}
