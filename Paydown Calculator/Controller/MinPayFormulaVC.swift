//
//  MinPayFormulaViewController.swift
//  Paydown Calculator
//
//  Created by Timothy Platt on 23/09/2018.
//  Copyright © 2018 Timothy Platt. All rights reserved.
//

import UIKit

class MinPayFormulaVC: UIViewController, UITextFieldDelegate {
    
    var validPercentage = false
    var validAmount = false
    
    var APR: Double = 0
    var balance: Double = 0
    
    @IBOutlet weak var percentOfBalanceTextfield: UITextField!
    @IBOutlet weak var percentOfBalanceOnlyTextfield: UITextField!
    @IBOutlet weak var amountTextfield: UITextField!
    @IBOutlet weak var doneOutlet: UIBarButtonItem!
    
    @IBAction func doneButton(_ sender: UIBarButtonItem) {
        let storyboard = UIStoryboard(name: "MainApp", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "testViewController") as! TestViewController
        
        guard let percentageOfBalance = percentOfBalanceTextfield.text?.dropLast() else { return }
        guard let percentageOfBalanceDouble = Double(percentageOfBalance) else { return }

        guard let percentageOfBalanceOnly = percentOfBalanceOnlyTextfield.text?.dropLast() else { return }
        guard let percentageOfBalanceOnlyDouble = Double(percentageOfBalanceOnly) else { return }

        guard let repaymentAmountWithoutCurrencySymbol = amountTextfield.text?.dropFirst() else { return }
        let repaymentAmountWithoutComma = repaymentAmountWithoutCurrencySymbol.replacingOccurrences(of: ",", with: "")
        guard let repaymentAmountDouble = Double(repaymentAmountWithoutComma) else { return }

        vc.balance = balance
        vc.APR = APR
        vc.percentageOfBalance = percentageOfBalanceDouble
        vc.percentageOfBalanceOnly = percentageOfBalanceOnlyDouble
        vc.repaymentAmount = repaymentAmountDouble
        
        self.navigationController!.pushViewController(vc, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        percentOfBalanceTextfield.delegate = self
        percentOfBalanceTextfield.keyboardType = .decimalPad
        percentOfBalanceOnlyTextfield.delegate = self
        percentOfBalanceOnlyTextfield.keyboardType = .decimalPad
        amountTextfield.delegate = self
        doneOutlet.isEnabled = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField == percentOfBalanceTextfield || textField == percentOfBalanceOnlyTextfield {
            
            guard let oldText = textField.text else { return true }
            guard let r = Range(range, in: oldText) else { return true }
            let newText = oldText.replacingCharacters(in: r, with: string)
            var formattedNewText = newText.replacingOccurrences(of: "%", with: "")
            
            let isNumeric = formattedNewText.isEmpty || (Double(formattedNewText) != nil)
            let numberOfDots = formattedNewText.components(separatedBy: ".").count - 1
            
            let numberOfIntegerDigits: Int
            let numberOfDecimalDigits: Int
            
            if let dotIndex = formattedNewText.index(of: ".") {
                numberOfDecimalDigits = formattedNewText.distance(from: dotIndex, to: formattedNewText.endIndex) - 1
            } else {
                numberOfDecimalDigits = 0
            }
            
            if !(newText.contains(".")) {
                numberOfIntegerDigits = formattedNewText.count
            } else {
                numberOfIntegerDigits = 0
            }
            
            if string == "" && formattedNewText.count > 0 {
                formattedNewText.removeLast()
            }
            
            if  isNumeric == true && numberOfDots <= 1 && numberOfDecimalDigits <= 2 && numberOfIntegerDigits <= 2 {
                updateTextField(newText: formattedNewText, textField)
            }
            return false
            
        } else if textField == amountTextfield {
            
            let text = (amountTextfield.text! as NSString).replacingCharacters(in: range, with: string)
            
            if text != "£0.0" {
                validAmount = true
            } else {
                validAmount = false
            }
            
            enableDoneButton()
            return true
        }
        
        return false
    }
    
    func updateTextField(newText: String, _ textfield: UITextField) -> Void {
        if newText.count == 0 {
            textfield.text = newText
            validPercentage = false
        } else {
            textfield.text = newText + "%"
            validPercentage = true
        }
        enableDoneButton()
    }
    
    func enableDoneButton() -> Void {
        if validAmount == true && validPercentage == true {
            doneOutlet.isEnabled = true
        }
    }
    
}
