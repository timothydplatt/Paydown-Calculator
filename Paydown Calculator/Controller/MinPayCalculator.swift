//
//  MinPayCalculator.swift
//  Paydown Calculator
//
//  Created by Timothy Platt on 17/09/2018.
//  Copyright © 2018 Timothy Platt. All rights reserved.
//

import UIKit

class MinPayCalculator {
    
    /*  Repayment Type 1: Greater of % of balance + interest or amount
     Repayment Type 2: Greater of % of balance + interest, % of balance or amount */
    
    func minPayCalculator(balance: String, APR: String, repaymentType: Int, percentOfBalance: String, fixedAmount: String, percentOfBalanceOnly: String) -> Int {
        
        let balance = Decimal(string: balance)!
        let APR = Decimal(string: APR)!
        let monthlyInterestRate = (APR/Decimal(100))/Decimal(12) as Decimal
        let repaymentType: Int = repaymentType
        var remainingBalance = balance as Decimal
        let percentOfBalance = Decimal(string: percentOfBalance)!
        let percentOfBalanceDecimal = percentOfBalance/Decimal(100) as Decimal
        let fixedAmount = Decimal(string: fixedAmount)!
        let percentOfBalanceOnly = Decimal(string: percentOfBalanceOnly)!
        var actualPaymentAmount = Decimal(string: "0.00")!
        var principalPaymentAmount = Decimal(string: "0.00")!
        var interestPaymentAmount = Decimal(string: "0.00")!
        var cumulativeInterest = Decimal(string: "0.00")!
        var monthsToPayOff: Int = 0
        
        var actualPaymentAmountRounded = Decimal()
        var principalPaymentAmountRounded = Decimal()
        var interestPaymentAmountRounded = Decimal()
        var remainingBalanceRounded = Decimal()
        var cumulativeInterestRounded = Decimal()
        
        while remainingBalance > 0 {
            
            monthsToPayOff += 1
            
            interestPaymentAmount = (remainingBalance * monthlyInterestRate * Decimal(100))/Decimal(100)
            cumulativeInterest += interestPaymentAmount
            actualPaymentAmount = (remainingBalance * percentOfBalanceDecimal) + interestPaymentAmount
            
            if repaymentType == 1 && actualPaymentAmount < fixedAmount {
                actualPaymentAmount = fixedAmount
                
            } else if repaymentType == 2 && actualPaymentAmount < remainingBalance * percentOfBalanceOnly{
                actualPaymentAmount = remainingBalance * percentOfBalanceOnly
                
                if actualPaymentAmount < fixedAmount {
                    actualPaymentAmount = fixedAmount
                }
            }
            
            principalPaymentAmount = actualPaymentAmount - interestPaymentAmount
            
            if principalPaymentAmount > remainingBalance {
                remainingBalance -= remainingBalance
            } else {
                remainingBalance -= principalPaymentAmount
            }
            
            NSDecimalRound(&actualPaymentAmountRounded, &actualPaymentAmount, 2, .plain)
            NSDecimalRound(&principalPaymentAmountRounded, &principalPaymentAmount, 2, .plain)
            NSDecimalRound(&interestPaymentAmountRounded, &interestPaymentAmount, 2, .plain)
            NSDecimalRound(&remainingBalanceRounded, &remainingBalance, 2, .plain)
            NSDecimalRound(&cumulativeInterestRounded, &cumulativeInterest, 2, .plain)
            
            print("Actual minimum payment amount: \(actualPaymentAmountRounded)")
            print("Principle payment amount: \(principalPaymentAmountRounded)")
            print("Interest payment amount: \(interestPaymentAmountRounded)")
            print("Remaining balance: \(remainingBalanceRounded)")
            print("Running interest: \(cumulativeInterestRounded)")
            print("")
        }
        
        NSDecimalRound(&cumulativeInterestRounded, &cumulativeInterest, 2, .plain)
        
        print("Months to payoff: \(monthsToPayOff)")
        print("Total interest: \(cumulativeInterest)")
        
        return monthsToPayOff
    }
    
}
