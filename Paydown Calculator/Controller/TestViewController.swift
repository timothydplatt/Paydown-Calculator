//
//  TestViewController.swift
//  Paydown Calculator
//
//  Created by Timothy Platt on 23/09/2018.
//  Copyright © 2018 Timothy Platt. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {
    
    var APR: Double = 0
    var balance: Double = 0
    var percentageOfBalance: Double = 0
    var percentageOfBalanceOnly: Double = 0
    var repaymentAmount: Double = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Balance: \(balance)")
        print("APR: \(APR)")
        print("Percentage Of Balance: \(percentageOfBalance)")
        print("Percentage Of Balance Only: \(percentageOfBalanceOnly)")
        print("Repayment Amount: \(repaymentAmount)")
        
        let minPayCalculator = MinPayCalculator()
        minPayCalculator.minPayCalculator(balance: String(balance), APR: String(APR), repaymentType: 1, percentOfBalance: String(percentageOfBalance), fixedAmount: String(repaymentAmount), percentOfBalanceOnly: String(percentageOfBalanceOnly))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

