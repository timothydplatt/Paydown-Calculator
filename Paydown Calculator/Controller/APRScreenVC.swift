//
//  APRScreenViewController.swift
//  Paydown Calculator
//
//  Created by Timothy Platt on 18/09/2018.
//  Copyright © 2018 Timothy Platt. All rights reserved.
//

import UIKit

class APRScreenVC: UIViewController, UITextFieldDelegate {
    
    //MARK: - Class Properties
    var balance: Double = 0;
    
    //MARK: - IB Outlets
    @IBOutlet weak var APRTextField: UITextField!
    @IBOutlet weak var APRLabel: UILabel!
    @IBOutlet weak var nextButtonOutlet: UIBarButtonItem!
    
    //MARK: - IB Actions
    @IBAction func nextButton(_ sender: UIBarButtonItem) {
    }
    
    //MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        APRTextField.delegate = self
        APRTextField.keyboardType = .decimalPad
        nextButtonOutlet.isEnabled = false
    }
    
    //MARK: - Delegate Methods
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
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
            
            updateAPRTextField(formattedUpdatedText, numberOfIntegerDigits, numberOfDecimalDigits)
        }
        
        return false
    }
    
    
    func updateAPRTextField(_ formattedUpdatedText: String, _ numberOfIntegerDigits: Int, _ numberOfDecimalDigits: Int) -> Void {

        APRTextField.text = formattedUpdatedText + "%"
        updateCursorPosition()
        
        if formattedUpdatedText.count == 0 || formattedUpdatedText == "0" || formattedUpdatedText.contains(".") && numberOfDecimalDigits == 0 || formattedUpdatedText == "00" || formattedUpdatedText == "00.0" || formattedUpdatedText == "00.00" {
            nextButtonOutlet?.isEnabled = false
        } else {
            nextButtonOutlet?.isEnabled = true
        }
        
    }
    
    
    func updateCursorPosition() {
        //let cursorPosition = APRTextField.offset(from: APRTextField.beginningOfDocument, to: APRTextField.endOfDocument)

        if let selectedTextRange = APRTextField.selectedTextRange {
            if let newPosition = APRTextField.position(from: selectedTextRange.start, offset: -1) {
                APRTextField.selectedTextRange = APRTextField.textRange(from: newPosition, to: newPosition)
            }
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "APRScreenToMinPayScreen" {
            let viewController = segue.destination as! MinPayFormulaVC
            
            guard let APRString = APRTextField.text?.dropLast() else { return }
            guard let APRStringDouble = Double(APRString) else { return }
            
            viewController.APR = APRStringDouble
            viewController.balance = balance
        }
    }
}
