//
//  UITextFieldExtensions.swift
//  MyFutureBox
//
//  Created by Ben Ormos on 22/04/2018.
//  Copyright © 2018 com.benormos. All rights reserved.
//

import UIKit

extension UITextField {
    
    private func createTextField(_ placeholder: String,
                                 font: UIFont,
                                 cornerRadius: CGFloat? = nil,
                                 borderColor: UIColor? = nil,
                                 backgroundColor: UIColor? = nil) {
        
        self.placeholder = placeholder
        self.font = font
        self.layer.cornerRadius = cornerRadius ?? 0
        self.layer.borderColor = borderColor?.cgColor
        self.backgroundColor = backgroundColor
        self.accessibilityHint = placeholder
        self.autocorrectionType = .no
    
        self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: self.frame.height))
        self.leftViewMode = .always
    }
    
    func roundedTextField(_ placeholder: String) {
        
        createTextField(placeholder,
                        font: UIFont.systemFont(ofSize: 13, weight: .regular),
                        cornerRadius: 8,
                        borderColor: .lightGray,
                        backgroundColor: .white)
        
    }
    
    
}
