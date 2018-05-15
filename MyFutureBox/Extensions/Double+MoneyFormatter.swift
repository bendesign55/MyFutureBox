//
//  String+MoneyFormatter.swift
//  MyFutureBox
//
//  Created by Ben Ormos on 23/04/2018.
//  Copyright © 2018 com.benormos. All rights reserved.
//

import Foundation

extension Double {
    
    func formatCurrency() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "en_GB")
        return formatter.string(from: NSNumber(value: self)) ?? ""
    }
}
