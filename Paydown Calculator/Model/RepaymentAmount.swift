//
//  RepaymentAmount.swift
//  Paydown Calculator
//
//  Created by Timothy Platt on 24/09/2018.
//  Copyright © 2018 Timothy Platt. All rights reserved.
//

import UIKit

class RepaymentAmount: UITextField {
    
    var string: String { return text ?? "" }
    var decimal: Decimal {
        return string.digits.decimal /
            Decimal(pow(10, Double(Formatter.currency.maximumFractionDigits)))
    }
    var decimalNumber: NSDecimalNumber { return decimal.number }
    var doubleValue: Double { return decimalNumber.doubleValue }
    var integerValue: Int { return decimalNumber.intValue   }
    let maximum: Decimal = 99.99
    private var lastValue: String?
    override func willMove(toSuperview newSuperview: UIView?) {
        // you can make it a fixed locale currency if needed
        Formatter.currency.locale = Locale(identifier: "en_GB") // or "en_US", "fr_FR", etc
        addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        keyboardType = .numberPad
        textAlignment = .right
        tintColor = UIColor .white
        //returnKeyType = .done
        editingChanged()
    }
    override func deleteBackward() {
        text = string.digits.dropLast().string
        editingChanged()
    }
    
    @objc func editingChanged(_ textField: UITextField? = nil) {
        guard decimal <= maximum else {
            text = lastValue
            return
        }
        text = Formatter.currency.string(for: decimal)
        lastValue = text
    }

}
