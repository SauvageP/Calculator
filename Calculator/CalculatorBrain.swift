//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Perry Gabriel on 12/10/16.
//  Copyright © 2016 Perry R. Gabriel. All rights reserved.
//

import Foundation

class CalculatorBrain {

	private var accumulator = 0.0
	
	func setOperand(_ operand: Double) {
		accumulator = operand
	}
	
	private var operations: Dictionary<String, Operation> = [
		"π" : Operation.Constant(M_PI),
		"e" : Operation.Constant(M_E),
		"√" : Operation.UnaryOperation(sqrt),
		"cos" : Operation.UnaryOperation(cos),
		"sin" : Operation.UnaryOperation(sin),
		"tan" : Operation.UnaryOperation(tan),
		"x" : Operation.BinaryOpertaion({$0 * $1}),
		"-" : Operation.BinaryOpertaion({$0 - $1}),
		"÷" : Operation.BinaryOpertaion({$0 / $1}),
		"+" : Operation.BinaryOpertaion({$0 + $1}),
		"±" : Operation.UnaryOperation({ -$0}),
		"%" : Operation.UnaryOperation({$0 * 0.01}),
		"=" : Operation.Equals,
		"clr" : Operation.Constant(0),
		"^" : Operation.BinaryOpertaion({pow($0, $1)})
	]
	
	private enum Operation {
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
			case .BinaryOpertaion(let function):	pending = PendingBinaryOperationInfo(binaryFunction: function, firstOperand: accumulator)
			case .Equals:
				executePendingBinaryOperation()
			}
		}
	}
	
	private func executePendingBinaryOperation() {
		if pending != nil {
		accumulator = pending!.binaryFunction(pending!.firstOperand, accumulator)
			pending = nil
		}
	}
	
	private var pending: PendingBinaryOperationInfo?
	
	private struct PendingBinaryOperationInfo  {
		var binaryFunction: (Double, Double) -> Double
		var firstOperand: Double
	}
	
	var result: Double {
		get {
			return accumulator
		}
	}
	
}
