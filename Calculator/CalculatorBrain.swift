//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Perry Gabriel on 12/10/16.
//  Copyright © 2016 Perry R. Gabriel. All rights reserved.
//

import Foundation

func multiply(_ op1: Double,_ op2: Double) -> Double {
	return op1 * op2
}

class CalculatorBrain {

	private var accumulator = 0.0
	
	func setOperand(_ operand: Double) {
		accumulator = operand
	}
	
	var operations: Dictionary<String, Operation> = [
		"π" : Operation.Constant(M_PI),
		"e" : Operation.Constant(M_E),
		"√" : Operation.UnaryOperation(sqrt),
		"cos" : Operation.UnaryOperation(cos),
		"x" : Operation.BinaryOpertaion(multiply),
		"=" : Operation.Equals
	]
	
	enum Operation {
		case Constant(Double)
		case UnaryOperation((Double) -> Double)
		case BinaryOpertaion((Double, Double) -> Double)
		case Equals
	}
	
	func performOperation(_ symbol: String) {
		if let operation = operations[symbol]{
			switch operation {
			case .Constant(let associatedValue):	accumulator = associatedValue
			case .UnaryOperation(let function):		accumulator = function(accumulator)
			case .BinaryOpertaion(let function):	pending = PendingBinaryOpertaitonInfo(binaryFunction: function, firstOperand: accumulator)
			case .Equals:
				executePendingBinaryOperation()
			}
		}
	}
	
	private func executePendingBinaryOperation() {
		accumulator = pending!.binaryFunction(pending!.firstOperand, accumulator)
	}
	
	private var pending: PendingBinaryOpertaitonInfo?
	
	struct PendingBinaryOpertaitonInfo  {
		var binaryFunction: (Double, Double) -> Double
		var firstOperand: Double
	}
	
	var result: Double {
		get {
			return accumulator
		}
	}
	
}
