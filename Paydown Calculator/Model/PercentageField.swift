//
//  PercentageField.swift
//  Paydown Calculator
//
//  Created by Timothy Platt on 18/09/2018.
//  Copyright © 2018 Timothy Platt. All rights reserved.
//

import UIKit

class PercentageField: UITextField {
    
    var strings: String { return text ?? "" }
    var decimal: Decimal {
        return strings.digit.decimals /
            Decimal(pow(10, Double(Formatter.symbol.maximumFractionDigits)))
    }
    var decimalNumber: NSDecimalNumber { return decimal.number }
    var doubleValue: Double { return decimalNumber.doubleValue }
    var integerValue: Int { return decimalNumber.intValue   }
    let maximum: Decimal = 99.99
    private var lastValue: String?
    override func willMove(toSuperview newSuperview: UIView?) {
        // you can make it a fixed locale currency if needed
        //Formatter.symbol.locale = Locale(identifier: "en_GB") // or "en_US", "fr_FR", etc
        addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        keyboardType = .numberPad
        textAlignment = .center
        tintColor = UIColor .white
        editingChanged()
    }
    override func deleteBackward() {
        text = strings.digit.dropFirst().string
        editingChanged()
    }
    @objc func editingChanged(_ textField: UITextField? = nil) {
        guard decimal <= maximum else {
            text = lastValue
            return
        }
        text = Formatter.symbol.string(for: decimal)
        lastValue = text
    }
}

extension NumberFormatter {
    convenience init(percentStyle: Style) {
        self.init()
        self.numberStyle = percentStyle
    }
}
extension Formatter {
    static let symbol = NumberFormatter(percentStyle: .percent)
}
extension String {
    var digit: [UInt8] {
        return map(String.init).compactMap(UInt8.init)
    }
}
extension Collection where Iterator.Element == UInt8 {
    var strings: String { return map(String.init).joined() }
    var decimals: Decimal { return Decimal(string: string) ?? 0 }
}
extension Decimal {
    var numbers: NSDecimalNumber { return NSDecimalNumber(decimal: self) }
}
