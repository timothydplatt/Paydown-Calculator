//
//  TestViewController2ViewController.swift
//  Paydown Calculator
//
//  Created by Timothy Platt on 26/09/2018.
//  Copyright © 2018 Timothy Platt. All rights reserved.
//

import UIKit
import UICircularProgressRing

class TestViewController2ViewController: UIViewController {
    
    var APR: Double = 20
    var balance: Double = 2000
    var percentageOfBalance: Double = 1
    var percentageOfBalanceOnly: Double = 0
    var repaymentAmount: Double = 25
    
    var payDownTime: Int = 0
    var cumulativeInterest: Decimal = 0

    @IBOutlet weak var progressRing: UICircularProgressRing!
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var interestLabel: UILabel!
    @IBOutlet weak var stepperLabel: UILabel!
    @IBOutlet weak var stepper: UIStepper!
    
    @IBAction func stepperControl(_ sender: UIStepper) {
        
        stepperLabel.text = Int(sender.value).description
        
        let fixedAmountCalculator = FixedAmountCalculator()
        
        let payDownTimeIfPayingFixedAmount = fixedAmountCalculator.fixPayCalculator(userFixedAmount: Int(sender.value).description, balance: String(balance), APR: String(APR), repaymentType: 1, percentOfBalance: String(percentageOfBalance), fixedAmount: String(repaymentAmount), percentOfBalanceOnly: String(percentageOfBalanceOnly))
        
        monthLabel.text = String(payDownTimeIfPayingFixedAmount.payDownTime) + " Months"
        test1(monthsForFixed: Double(payDownTimeIfPayingFixedAmount.payDownTime))
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("LOADED")
        
        print("Balance: \(balance)")
        print("APR: \(APR)")
        print("Percentage Of Balance: \(percentageOfBalance)")
        print("Percentage Of Balance Only: \(percentageOfBalanceOnly)")
        print("Repayment Amount: \(repaymentAmount)")
        
        let minPayCalculator = MinPayCalculator()
        let payDownTimeIfPayingMinimum = minPayCalculator.minPayCalculator(balance: String(balance), APR: String(APR), repaymentType: 1, percentOfBalance: String(percentageOfBalance), fixedAmount: String(repaymentAmount), percentOfBalanceOnly: String(percentageOfBalanceOnly))
        
        payDownTime = payDownTimeIfPayingMinimum.0
        cumulativeInterest = payDownTimeIfPayingMinimum.cumulativeInterest
        
        monthLabel.text = String(payDownTime)
        interestLabel.text = cumulativeInterest.description
        
        //progressRing.maxValue = 100
        progressRing.maxValue = UICircularProgressRing.ProgressValue(Float(payDownTime))
        progressRing.outerRingColor = .green
        progressRing.innerRingColor = .lightGray
        progressRing.outerRingWidth = 10
        progressRing.innerRingWidth = 10
        progressRing.ringStyle = .inside
        progressRing.font = UIFont.boldSystemFont(ofSize: 40)
        progressRing.valueIndicator = " Months"
        
        stepper.wraps = true
        stepper.autorepeat = true
        stepper.value = 25
        
        test()
    }
    

    func test() -> Void {
        // Somewhere not in viewDidLoad (since the views have not set yet, thus cannot be animated)
        // Remember to use unowned or weak self if refrencing self to avoid retain cycle
        progressRing.startProgress(to: 75, duration: 2.0) {
            print("Done animating!")
            // Do anything your heart desires...
        }
    }
    
    func test1(monthsForFixed: Double) -> Void {
        // Somewhere not in viewDidLoad (since the views have not set yet, thus cannot be animated)
        // Remember to use unowned or weak self if refrencing self to avoid retain cycle
        progressRing.startProgress(to: UICircularProgressRing.ProgressValue(Float(monthsForFixed)), duration: 2.0) {
            print("Done animating!")
            // Do anything your heart desires...
        }
    }

}
