//
//  UITextField+Extensions.swift
//  SwiftyExtensions
//
//  Created by Tam Huynh on 7/10/18.
//  Copyright © 2018 TH. All rights reserved.
//

import Foundation
import UIKit

public extension UITextField {
    func setLeftInset(_ value: CGFloat, mode: UITextFieldViewMode = .always) {
        let insetView = UIView(frame: CGRect(x: 0, y: 0, width: value, height: self.frame.size.height))
        leftView = insetView
        leftViewMode = mode
    }
    
    func setRightInset(_ value: CGFloat, mode: UITextFieldViewMode = .always) {
        let insetView = UIView(frame: CGRect(x: 0, y: 0, width: value, height: self.frame.size.height))
        rightView = insetView
        rightViewMode = mode
    }
    
    func setLeftRightInset(_ value: CGFloat) {
        setLeftInset(value)
        setRightInset(value)
    }
}
