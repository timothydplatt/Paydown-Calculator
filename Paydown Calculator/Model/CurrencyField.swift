//
//  CurrencyField.swift
//  Paydown Calculator
//
//  Created by Timothy Platt on 18/09/2018.
//  Copyright © 2018 Timothy Platt. All rights reserved.
//

import UIKit

class CurrencyField: UITextField {

    var string: String { return text ?? "" }
    var decimal: Decimal {
        return string.digits.decimal /
            Decimal(pow(10, Double(Formatter.currency.maximumFractionDigits)))
    }
    var decimalNumber: NSDecimalNumber { return decimal.number }
    var doubleValue: Double { return decimalNumber.doubleValue }
    var integerValue: Int { return decimalNumber.intValue   }
    let maximum: Decimal = 999_999.99
    private var lastValue: String?
    override func willMove(toSuperview newSuperview: UIView?) {
        // you can make it a fixed locale currency if needed
        Formatter.currency.locale = Locale(identifier: "en_GB") // or "en_US", "fr_FR", etc
        addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        keyboardType = .numberPad
        textAlignment = .right
        tintColor = UIColor .white
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

extension NumberFormatter {
    convenience init(numberStyle: Style) {
        self.init()
        self.numberStyle = numberStyle
    }
}
extension Formatter {
    static let currency = NumberFormatter(numberStyle: .currency)
}
extension String {
    var digits: [UInt8] {
        return map(String.init).compactMap(UInt8.init)
    }
}
extension Collection where Iterator.Element == UInt8 {
    var string: String { return map(String.init).joined() }
    var decimal: Decimal { return Decimal(string: string) ?? 0 }
}
extension Decimal {
    var number: NSDecimalNumber { return NSDecimalNumber(decimal: self) }
}
