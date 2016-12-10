//
//  ViewController.swift
//  Calculator
//
//  Created by Perry Gabriel on 12/6/16.
//  Copyright © 2016 Perry R. Gabriel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
	
	@IBOutlet private weak var display: UILabel!
	
	private var userIsInTheMiddleOfTyping = false
	
	private var displayValue: Double { get {
			return Double(display.text!)!
		} set {
			display.text = String(newValue)
		}
	}
	
	private var brain = CalculatorBrain()
	
	@IBAction private func touchDigit(_ sender: UIButton) {
		let digit = sender.currentTitle!
		if userIsInTheMiddleOfTyping {
			let textCurrentlyInDisplay = display.text!
			display.text = textCurrentlyInDisplay + digit
		} else {
			display.text = digit
		}
		userIsInTheMiddleOfTyping = true
	}
	
	@IBAction private func performOperation(_ sender: UIButton) {
		if userIsInTheMiddleOfTyping {
			brain.setOperand(displayValue)
			userIsInTheMiddleOfTyping = false
		}
	
		if let mathSymbol = sender.currentTitle {
			brain.performOperation(mathSymbol)
		}
		displayValue = brain.result
	}
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}


}

