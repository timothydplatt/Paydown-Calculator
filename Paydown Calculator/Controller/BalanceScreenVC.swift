//
//  LandingScreenControllerViewController.swift
//  Paydown Calculator
//
//  Created by Timothy Platt on 18/09/2018.
//  Copyright © 2018 Timothy Platt. All rights reserved.
//

import UIKit

class BalanceScreenVC: UIViewController, UITextFieldDelegate {
    
    //MARK: - IB Outlets
    @IBOutlet weak var balanceTextField: CurrencyField!
    @IBOutlet weak var balanceLabel: UILabel!
    @IBOutlet weak var nextButtonOutlet: UIBarButtonItem!
    
    //MARK: - IB Actions
    @IBAction func nextButton(_ sender: Any) {
    }
    
    //MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        balanceTextField.delegate = self

    }
    
    //MARK: - Text Field Delegate Methods
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        guard let oldText = textField.text else { return true }
        let newText = (oldText as NSString).replacingCharacters(in: range, with: string)
        
        if newText == "£0.0" || newText == "£0.000" {
            nextButtonOutlet.isEnabled = false
        } else if newText != "£0.0" {
            nextButtonOutlet.isEnabled = true
        }
        return true
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "BalanceScreentoAPRScreen" {
            let viewController = segue.destination as! APRScreenVC
            
            guard let balanceStringWithoutCurrencySymbol = balanceTextField.text?.dropFirst() else { return }
            let balanceStringWithoutComma = balanceStringWithoutCurrencySymbol.replacingOccurrences(of: ",", with: "")
            guard let balanceStringDouble = Double(balanceStringWithoutComma) else { return }
            
            viewController.balance = balanceStringDouble
        }
    }
    
}
