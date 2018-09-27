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
    
    @IBOutlet weak var progressRing: UICircularProgressRing!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var stepperLabel: UILabel!
    @IBOutlet weak var stepper: UIStepper!
    
    var balance: Double = 0
    var APR: Double = 0
    var percentageOfBalance: Double = 0
    var percentageOfBalanceOnly: Double = 0
    var repaymentAmount: Double = 0
    var payDownTime: Int = 0
    var cumulativeInterest: Decimal = 0
    var firstMinPaymentAmount: Double = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        summaryLabel.text = "Paying only the minimum will take you \(payDownTime) months to clear your balance and cost £\(cumulativeInterest)"
        summaryLabel.numberOfLines = 0
        summaryLabel.lineBreakMode = .byWordWrapping
        
        progressRing.maxValue = UICircularProgressRing.ProgressValue(Float(payDownTime))
        progressRing.outerRingWidth = 12
        progressRing.innerRingWidth = 12
        progressRing.ringStyle = .dashed
        progressRing.font = UIFont.boldSystemFont(ofSize: 40)
        progressRing.valueIndicator = " months"
        
        let firstMinPaymentRounded = firstMinPaymentAmount.rounded(.toNearestOrAwayFromZero)
        let firstMinPaymentAmountAsString = String(format: "%.0f", firstMinPaymentRounded)
        
        let balanceRounded = balance.rounded(.toNearestOrAwayFromZero)
        let balanceAsString = String(format: "%.0f", balanceRounded)
        
        stepper.wraps = true
        stepper.autorepeat = true
        stepper.value = Double(firstMinPaymentAmountAsString)!-1
        stepper.maximumValue = Double(balanceAsString)!
        
        test()
    }
    
    
    @IBAction func stepperControl(_ sender: UIStepper) {
        
        stepperLabel.text = "£ " + Int(sender.value).description
        
        let fixedAmountCalculator = FixedAmountCalculator()
        
        let payDownTimeIfPayingFixedAmount = fixedAmountCalculator.fixPayCalculator(userFixedAmount: Int(sender.value).description, balance: String(balance), APR: String(APR), repaymentType: 1, percentOfBalance: String(percentageOfBalance), fixedAmount: String(repaymentAmount), percentOfBalanceOnly: String(percentageOfBalanceOnly))
        
        test1(monthsForFixed: Double(payDownTimeIfPayingFixedAmount.payDownTime))
        
    }

    func test() -> Void {
        // Somewhere not in viewDidLoad (since the views have not set yet, thus cannot be animated)
        // Remember to use unowned or weak self if refrencing self to avoid retain cycle
        progressRing.startProgress(to: UICircularProgressRing.ProgressValue(Float(payDownTime)), duration: 2.0) {
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
