//
//  LandingScreenControllerViewController.swift
//  Paydown Calculator
//
//  Created by Timothy Platt on 18/09/2018.
//  Copyright © 2018 Timothy Platt. All rights reserved.
//

import UIKit

class BalanceScreenControllerViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var balanceTextField: CurrencyField!
    @IBOutlet weak var balanceLabel: UILabel!
    @IBOutlet weak var nextButtonOutlet: UIBarButtonItem!
    
    @IBAction func nextButton(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        balanceTextField.delegate = self

    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let text = (balanceTextField.text! as NSString).replacingCharacters(in: range, with: string)
        
        if text != "£0.0" {
            nextButtonOutlet?.isEnabled = true
        } else {
            nextButtonOutlet?.isEnabled = false
        }
        return true
    }
    
}




