//
//  ViewController.swift
//  Tipsy
//
//  Created by Angela Yu on 09/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {
    
    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var zeroPctButton: UIButton!
    @IBOutlet weak var tenPctButton: UIButton!
    @IBOutlet weak var twentyPctButton: UIButton!
    @IBOutlet weak var splitNumberLabel: UILabel!
    
    var tip = 0.10
    var numberofPeople = 2
    var billTotal = 0.0
    var resultTo2Decimal = "0.0"
    
    @IBAction func tipChanged(_ sender: UIButton) {
        clearSelectState()
        sender.isSelected = true
        billTextField.endEditing(true)
        
        let buttonTitle = sender.currentTitle!
        let buttonTitleMinusPercenting = String(buttonTitle.dropLast())
        let buttonTitleAsANumber = Double(buttonTitleMinusPercenting)!
        tip = buttonTitleAsANumber / 100
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        splitNumberLabel.text = String(format: "%.0f", sender.value)
        numberofPeople = Int(sender.value)
    }
    
    @IBAction func calculatePressed(_ sender: UIButton) {
        let bill = billTextField.text!
        
        if bill != " " {
            billTotal = Double(bill)!
            
            let result = billTotal * (1 + tip) / Double(numberofPeople)
            resultTo2Decimal = String(format: "%.2f", result)
            
            self.performSegue(withIdentifier: "goToResult", sender: self)
        }
    }
    
    func clearSelectState() {
        [zeroPctButton, tenPctButton, twentyPctButton].forEach {
            $0!.isSelected = false
            $0!.setTitleColor(#colorLiteral(red: 0.1280636191, green: 0.6198506951, blue: 0.3609129786, alpha: 1), for: .normal)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResult" {
            let destinationVC = segue.destination as! ResultsViewController
            destinationVC.total = resultTo2Decimal
            destinationVC.settings = "Split between \(numberofPeople) people, with \(Int(tip * 100))% tip."
        }
    }
}
