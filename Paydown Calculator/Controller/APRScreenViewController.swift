//
//  APRScreenViewController.swift
//  Paydown Calculator
//
//  Created by Timothy Platt on 18/09/2018.
//  Copyright © 2018 Timothy Platt. All rights reserved.
//

import UIKit

class APRScreenViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var APRTextField: UITextField!
    @IBOutlet weak var APRLabel: UILabel!
    @IBOutlet weak var nextButtonOutlet: UIBarButtonItem!
    
    @IBAction func nextButton(_ sender: UIBarButtonItem) {
    }
    
    var balance: Double = 0;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        APRTextField.delegate = self
        APRTextField.keyboardType = .decimalPad
        nextButtonOutlet?.isEnabled = false
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
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
            updateAPRTextField(newText: formattedNewText, numberOfIntegerDigits: numberOfIntegerDigits)
        }
        return false
    }
    
    func updateAPRTextField(newText: String, numberOfIntegerDigits: Int) -> Void {
        if newText.count == 0 {
            APRTextField.text = newText
            nextButtonOutlet?.isEnabled = false
        }
//        else if numberOfIntegerDigits == 2 {
//            APRTextField.text = newText + "%" + "."
//            nextButtonOutlet?.isEnabled = true
//        }
        else {
            APRTextField.text = newText + "%"
            nextButtonOutlet?.isEnabled = true
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "APRScreenToMinPayScreen" {
            let viewController = segue.destination as! MinPayFormulaViewController
            
            guard let APRString = APRTextField.text?.dropLast() else { return }
            guard let APRStringDouble = Double(APRString) else { return }
            
            viewController.APR = APRStringDouble
            viewController.balance = balance
        }
    }
    
}
