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
    @IBOutlet weak var differenceLabel: UILabel!
    @IBOutlet weak var stepperLabel: UILabel!
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var minusSymbolButton: UIButton!
    @IBOutlet weak var plusSymbolButton: UIButton!
    
    @IBAction func minusSymbolButtonAction(_ sender: Any) {
    }
    
    @IBAction func plusSymbolButtonAction(_ sender: Any) {
    }
    
    
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
        
        let firstMinPaymentRounded = firstMinPaymentAmount.rounded(.toNearestOrAwayFromZero)
        let firstMinPaymentAmountAsString = String(format: "%.0f", firstMinPaymentRounded)
        
        let balanceRounded = balance.rounded(.toNearestOrAwayFromZero)
        let balanceAsString = String(format: "%.0f", balanceRounded)
        
        summaryLabel.text = "Paying only the minimum will take you \(payDownTime) months to clear your balance and cost £\(cumulativeInterest) in interest."
        summaryLabel.numberOfLines = 0
        summaryLabel.lineBreakMode = .byWordWrapping
        
        differenceLabel.numberOfLines = 0
        differenceLabel.lineBreakMode = .byWordWrapping
        
        initialiseProgressRing()
        initialiseStepper(startValue: Double(firstMinPaymentAmountAsString)!-1, maximumValue: Double(balanceAsString)!)
        
        test()
    }
    
    @IBAction func stepperControl(_ sender: UIStepper) {
        
        stepperLabel.text = "£ " + Int(sender.value).description
        
        let fixedAmountCalculator = FixedAmountCalculator()
        
        let payDownTimeIfPayingFixedAmount = fixedAmountCalculator.fixPayCalculator(userFixedAmount: Int(sender.value).description, balance: String(balance), APR: String(APR), repaymentType: 1, percentOfBalance: String(percentageOfBalance), fixedAmount: String(repaymentAmount), percentOfBalanceOnly: String(percentageOfBalanceOnly))
        
        test1(monthsForFixed: Double(payDownTimeIfPayingFixedAmount.payDownTime))
        
        //differenceLabel.text = "Paying a fixed amount of \(firstMinPaymentRounded) each month will clear your balance X months more quickly, saving you £Y"
        
    }

    func test() -> Void {

        progressRing.startProgress(to: UICircularProgressRing.ProgressValue(Float(payDownTime)), duration: 2.0) {
            print("Done animating!")
            // Do anything your heart desires...
        }
    }
    
    func test1(monthsForFixed: Double) -> Void {

        progressRing.startProgress(to: UICircularProgressRing.ProgressValue(Float(monthsForFixed)), duration: 2.0) {
            print("Done animating!")
            // Do anything your heart desires...
        }
    }

    
    
    
    
    
    
    
    func initialiseProgressRing () -> Void {
        progressRing.maxValue = UICircularProgressRing.ProgressValue(Float(payDownTime))
        progressRing.outerRingWidth = 12
        progressRing.innerRingWidth = 12
        progressRing.ringStyle = .dashed
        progressRing.font = UIFont.boldSystemFont(ofSize: 40)
        progressRing.valueIndicator = " months"
    }
    
    func initialiseStepper (startValue: Double, maximumValue: Double) -> Void {
        stepper.wraps = true
        stepper.autorepeat = true
        stepper.value = startValue
        stepper.maximumValue = maximumValue
    }
    
}
