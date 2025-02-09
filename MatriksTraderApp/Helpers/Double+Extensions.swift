//
//  Double+Extensions.swift
//  MatriksTraderApp
//
//  Created by Selim Yılmaz on 9.02.2025.
//

import Foundation

extension Double {
    var amountString: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        formatter.groupingSeparator = "."
        formatter.decimalSeparator = ","
        
        let formattedNumber = formatter.string(from: NSNumber(value: self)) ?? String(format: "%.2f", self)
        return "₺" + formattedNumber
    }
}
