//
//  UIButtonExtensions.swift
//  MyFutureBox
//
//  Created by Ben Ormos on 22/04/2018.
//  Copyright © 2018 com.benormos. All rights reserved.
//

import UIKit

extension UIButton {
    
    private func createButton(_ font: UIFont,
                              tintColor: UIColor? = nil,
                              cornerRadius: CGFloat? = nil,
                              borderColor: UIColor? = nil,
                              backgroundColor: UIColor? = nil) {
        

        self.titleLabel?.font = font
        self.tintColor = tintColor ?? nil
        self.backgroundColor = backgroundColor
        self.layer.cornerRadius = cornerRadius ?? 0
        self.layer.borderColor = borderColor?.cgColor
    }
    
    func roundedButton() {
        createButton(UIFont.systemFont(ofSize: 16, weight: .bold), tintColor: .white, cornerRadius: 8, borderColor: .white, backgroundColor: .red)
    }
    
}
