//
//  MinPayFormulaViewController.swift
//  Paydown Calculator
//
//  Created by Timothy Platt on 23/09/2018.
//  Copyright © 2018 Timothy Platt. All rights reserved.
//

import UIKit

class MinPayFormulaVC: UIViewController, UITextFieldDelegate {
    
    //MARK: - Class Properties
    var balance: Double = 0
    var APR: Double = 0
    
    
    //MARK: - IB Outlets
    @IBOutlet weak var percentOfBalanceTextfield: UITextField!
    @IBOutlet weak var percentOfBalanceOnlyTextfield: UITextField!
    @IBOutlet weak var amountTextfield: UITextField!
    @IBOutlet weak var doneOutlet: UIBarButtonItem!
    @IBOutlet weak var scrollView: UIScrollView!
    
    
    //MARK: - IB Actions
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
    
    
    //MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        percentOfBalanceTextfield.delegate = self
        percentOfBalanceTextfield.keyboardType = .decimalPad
        percentOfBalanceOnlyTextfield.delegate = self
        percentOfBalanceOnlyTextfield.keyboardType = .decimalPad
        amountTextfield.delegate = self
        doneOutlet.isEnabled = false
        
        NotificationCenter.default.addObserver(self, selector: #selector(MinPayFormulaVC.keyboardWillShow), name: UIResponder.keyboardWillShowNotification , object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(MinPayFormulaVC.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    //MARK: - Delegate Methods
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField == percentOfBalanceTextfield || textField == percentOfBalanceOnlyTextfield {
            
            guard let currentText = textField.text else { return true }
            let updatedText = (currentText as NSString).replacingCharacters(in: range, with: string)
            let formattedUpdatedText = updatedText.replacingOccurrences(of: "%", with: "")
            let isNumeric = formattedUpdatedText.isEmpty || (Double(formattedUpdatedText) != nil)
            let numberOfDots = formattedUpdatedText.components(separatedBy: ".").count - 1
            let numberOfIntegerDigits: Int
            var numberOfDecimalDigits: Int
            
            if let indexOfDot = formattedUpdatedText.index(of: ".") {
                numberOfDecimalDigits = formattedUpdatedText.distance(from: indexOfDot, to: formattedUpdatedText.endIndex) - 1
            } else {
                numberOfDecimalDigits = 0
            }
            
            if !(formattedUpdatedText.contains(".")) {
                numberOfIntegerDigits = formattedUpdatedText.count
            } else {
                numberOfIntegerDigits = formattedUpdatedText.distance(from: formattedUpdatedText.startIndex, to: formattedUpdatedText.lastIndex(of: ".")!)
            }
            
            if isNumeric == true && numberOfDots <= 1 && numberOfDecimalDigits <= 2 && numberOfIntegerDigits <= 2 {
                
                updateTextField(formattedUpdatedText, textField, numberOfIntegerDigits, numberOfDecimalDigits)
            }
            return false
            
        } else if textField == amountTextfield {
            
            guard let oldText = textField.text else { return true }
            let newText = (oldText as NSString).replacingCharacters(in: range, with: string)
            
            if newText == "£0.0" || newText == "£0.000" {
                doneOutlet.isEnabled = false
            } else if newText != "£0.0" {
                doneOutlet.isEnabled = true
            }
            return true
        }
        return false
    }

    
    func updateTextField(_ formattedUpdatedText: String, _ textfield: UITextField, _ numberOfIntegerDigits: Int, _ numberOfDecimalDigits: Int) -> Void {
        
        textfield.text = formattedUpdatedText + "%"
        updateCursorPosition(textfield)
        
        if formattedUpdatedText.count == 0 || formattedUpdatedText == "0" || formattedUpdatedText.contains(".") && numberOfDecimalDigits == 0 || formattedUpdatedText == "00" || formattedUpdatedText == "00.0" || formattedUpdatedText == "00.00" {
            doneOutlet?.isEnabled = false
        } else {
            doneOutlet?.isEnabled = true
        }
        
    }
    
    
    func updateCursorPosition(_ textfield: UITextField) {
        //let cursorPosition = APRTextField.offset(from: APRTextField.beginningOfDocument, to: APRTextField.endOfDocument)
        
        if let selectedTextRange = textfield.selectedTextRange {
            if let newPosition = textfield.position(from: selectedTextRange.start, offset: -1) {
                textfield.selectedTextRange = textfield.textRange(from: newPosition, to: newPosition)
            }
        }
    }
    
    
    @objc func keyboardWillShow(notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height/2
                print(keyboardSize.height)
            }
        }
    }
    
    
    @objc func keyboardWillHide(notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y != 0 {
                self.view.frame.origin.y += keyboardSize.height/2
                print(keyboardSize.height)
            }
        }
    }
}
