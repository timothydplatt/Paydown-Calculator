//
//  LandingScreenControllerViewController.swift
//  Paydown Calculator
//
//  Created by Timothy Platt on 18/09/2018.
//  Copyright © 2018 Timothy Platt. All rights reserved.
//

import UIKit

class LandingScreenControllerViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var balanceTextField: CurrencyField!
    @IBOutlet weak var balanceLabel: UILabel!
    @IBOutlet weak var balanceButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        balanceTextField.delegate = self
        
        if balanceTextField.text == "£0.00" {
            balanceButton.isUserInteractionEnabled = false
            balanceButton.isEnabled = false
        }
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        balanceButton.setTitleColor(UIColor .white, for: .normal)
        balanceButton.isUserInteractionEnabled = true
        balanceButton.isEnabled = true
    }
    
//    func textFieldDidEndEditing(_ textField: UITextField) {
//        balanceButton.setTitleColor(UIColor .white, for: .normal)
//        balanceButton.isUserInteractionEnabled = true
//        balanceButton.isEnabled = true
//    }

}
