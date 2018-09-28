//
//  TestViewController2ViewController.swift
//  Paydown Calculator
//
//  Created by Timothy Platt on 26/09/2018.
//  Copyright © 2018 Timothy Platt. All rights reserved.
//

import UIKit
import UICircularProgressRing

class TestViewController2ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var progressRing: UICircularProgressRing!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var differenceLabel: UILabel!
    @IBOutlet weak var minusSymbolButton: UIButton!
    @IBOutlet weak var plusSymbolButton: UIButton!
    @IBOutlet weak var fixedAmounttextField: UITextField!
    
    var balance: Double = 0
    var APR: Double = 0
    var percentageOfBalance: Double = 0
    var percentageOfBalanceOnly: Double = 0
    var repaymentAmount: Double = 0
    var payDownTime: Int = 0
    var cumulativeInterest: Decimal = 0
    var firstMinPaymentAmount: Double = 0
    let fixedAmountCalculator = FixedAmountCalculator()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        fixedAmounttextField.delegate = self
        
        initialiseSummaryLabel()
        
        differenceLabel.numberOfLines = 0
        differenceLabel.lineBreakMode = .byWordWrapping
        
        let firstMinPaymentRounded = firstMinPaymentAmount.rounded(.toNearestOrAwayFromZero)
        let firstMinPaymentAmountAsString = String(format: "%.0f", firstMinPaymentRounded)
        let balanceRounded = balance.rounded(.toNearestOrAwayFromZero)
        let balanceAsString = String(format: "%.0f", balanceRounded)
        
        initialiseProgressRing()
        initialiseFixedAmounttextField(startValue: firstMinPaymentAmountAsString)
        setProgressRingToMaximum(firstMinPayAmount: firstMinPaymentAmountAsString)
    }
    
    func initialiseSummaryLabel() -> Void {
        summaryLabel.numberOfLines = 0
        summaryLabel.lineBreakMode = .byWordWrapping
        summaryLabel.text = "Paying only the minimum will take you \(payDownTime) months to clear your balance and cost £\(cumulativeInterest) in interest."
    }
    
    func initialiseProgressRing() -> Void {
        progressRing.maxValue = UICircularProgressRing.ProgressValue(Float(payDownTime))
        progressRing.outerRingWidth = 14
        progressRing.innerRingWidth = 14
        //progressRing.ringStyle = .dashed
        progressRing.ringStyle = .inside
        progressRing.font = UIFont.boldSystemFont(ofSize: 40)
        progressRing.valueIndicator = " months"
    }

    func initialiseFixedAmounttextField(startValue: String) -> Void {
        fixedAmounttextField.text = String(startValue)
        //Need to handle max/min amounts in the text field delegate function.
    }
    
    func setProgressRingToMaximum(firstMinPayAmount: String) -> Void {
        progressRing.startProgress(to: UICircularProgressRing.ProgressValue(Float(payDownTime)), duration: 2.0) {
            
            self.updateProgressRingForMinFixedAmount(minFixedAmount: firstMinPayAmount)
            
        }
    }
    
    func updateProgressRingForMinFixedAmount(minFixedAmount: String) -> Void {
        let payDownTimeIfPayingFixedAmount = fixedAmountCalculator.fixPayCalculator(userFixedAmount: minFixedAmount, balance: String(balance), APR: String(APR), repaymentType: 1, percentOfBalance: String(percentageOfBalance), fixedAmount: String(repaymentAmount), percentOfBalanceOnly: String(percentageOfBalanceOnly))
        
        progressRing.startProgress(to: UICircularProgressRing.ProgressValue(Float(payDownTimeIfPayingFixedAmount.payDownTime)), duration: 2.0) {
            
            var payDownDifference = self.payDownTime - payDownTimeIfPayingFixedAmount.payDownTime
            var interestDifference = self.cumulativeInterest - payDownTimeIfPayingFixedAmount.cumulativeInterestRounded
            
            self.updateDifferenceLabel(fixedAmount: minFixedAmount, payDownDifference: payDownDifference, interestDifference: interestDifference)
        }
    }
    
    func updateDifferenceLabel(fixedAmount: String, payDownDifference: Int, interestDifference: Decimal) -> Void {
        differenceLabel.text = "Paying a fixed amount of \(fixedAmount) each month will clear your balance \(payDownDifference) months more quickly, saving you £\(interestDifference) in interest!"
    }
    
    @IBAction func minusSymbolButtonAction(_ sender: Any) {
        let currentTextFeildAmount = fixedAmounttextField.text
        let newTextFieldAmount = Int(currentTextFeildAmount!)! - 1
        fixedAmounttextField.text = String(newTextFieldAmount)
        
        let payDownTimeIfPayingFixedAmount = fixedAmountCalculator.fixPayCalculator(userFixedAmount: String(newTextFieldAmount), balance: String(balance), APR: String(APR), repaymentType: 1, percentOfBalance: String(percentageOfBalance), fixedAmount: String(repaymentAmount), percentOfBalanceOnly: String(percentageOfBalanceOnly))
        
        updateProgressRingForFixedAmount(monthsForFixed: Double(payDownTimeIfPayingFixedAmount.payDownTime))
        
        var payDownDifference = self.payDownTime - payDownTimeIfPayingFixedAmount.payDownTime
        var interestDifference = self.cumulativeInterest - payDownTimeIfPayingFixedAmount.cumulativeInterestRounded
        
        self.updateDifferenceLabel(fixedAmount: String(newTextFieldAmount), payDownDifference: payDownDifference, interestDifference: interestDifference)
    }
    
    @IBAction func plusSymbolButtonAction(_ sender: Any) {
        let currentTextFeildAmount = fixedAmounttextField.text
        let newTextFieldAmount = Int(currentTextFeildAmount!)! + 1
        fixedAmounttextField.text = String(newTextFieldAmount)
        
        let payDownTimeIfPayingFixedAmount = fixedAmountCalculator.fixPayCalculator(userFixedAmount: String(newTextFieldAmount), balance: String(balance), APR: String(APR), repaymentType: 1, percentOfBalance: String(percentageOfBalance), fixedAmount: String(repaymentAmount), percentOfBalanceOnly: String(percentageOfBalanceOnly))
        
        updateProgressRingForFixedAmount(monthsForFixed: Double(payDownTimeIfPayingFixedAmount.payDownTime))
        
        var payDownDifference = self.payDownTime - payDownTimeIfPayingFixedAmount.payDownTime
        var interestDifference = self.cumulativeInterest - payDownTimeIfPayingFixedAmount.cumulativeInterestRounded
        
        self.updateDifferenceLabel(fixedAmount: String(newTextFieldAmount), payDownDifference: payDownDifference, interestDifference: interestDifference)
    }
    
    func updateProgressRingForFixedAmount(monthsForFixed: Double) -> Void {
        progressRing.startProgress(to: UICircularProgressRing.ProgressValue(Float(monthsForFixed)), duration: 2.0) {
        }
    }
    
    
    
    
    
    
    
    
    
    
    //    @IBAction func stepperControl(_ sender: UIStepper) {
    //
    //        stepperLabel.text = "£ " + Int(sender.value).description
    //
    //        let payDownTimeIfPayingFixedAmount = fixedAmountCalculator.fixPayCalculator(userFixedAmount: Int(sender.value).description, balance: String(balance), APR: String(APR), repaymentType: 1, percentOfBalance: String(percentageOfBalance), fixedAmount: String(repaymentAmount), percentOfBalanceOnly: String(percentageOfBalanceOnly))
    //
    //        updateProgressRingForFixedAmount(monthsForFixed: Double(payDownTimeIfPayingFixedAmount.payDownTime))
    //
    //    }
    
    
//    func initialiseStepper(startValue: Double, maximumValue: Double) -> Void {
//        stepper.wraps = true
//        stepper.autorepeat = true
//        stepper.value = startValue
//        stepper.maximumValue = maximumValue
//        //Needs min value, but the value I initialise with can't be -1
//    }

    
    
    
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        guard let oldText = textField.text else { return true }
        guard let r = Range(range, in: oldText) else { return true }
        let newText = oldText.replacingCharacters(in: r, with: string)
        let isNumeric = newText.isEmpty || (Double(newText) != nil)
        let numberOfIntegerDigits = newText.count
        
        print(newText)
        
        if numberOfIntegerDigits <= 2 && isNumeric {
            
            let payDownTimeIfPayingFixedAmount = fixedAmountCalculator.fixPayCalculator(userFixedAmount: String(newText), balance: String(balance), APR: String(APR), repaymentType: 1, percentOfBalance: String(percentageOfBalance), fixedAmount: String(repaymentAmount), percentOfBalanceOnly: String(percentageOfBalanceOnly))
            
            updateProgressRingForFixedAmount(monthsForFixed: Double(payDownTimeIfPayingFixedAmount.payDownTime))
            
            var payDownDifference = self.payDownTime - payDownTimeIfPayingFixedAmount.payDownTime
            var interestDifference = self.cumulativeInterest - payDownTimeIfPayingFixedAmount.cumulativeInterestRounded
            
            self.updateDifferenceLabel(fixedAmount: String(newText), payDownDifference: payDownDifference, interestDifference: interestDifference)
            
            return true
        } else {
            return false
        }
    }
    
}
