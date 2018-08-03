//
//  NSMutableAttributedString+Extensions.swift
//  SwiftyHelpful
//
//  Created by Tam Huynh on 7/10/18.
//  Copyright © 2018 TH. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Properties
public extension NSMutableAttributedString {
    @discardableResult
    func addParagraphStyle(_ value: NSMutableParagraphStyle, range: NSRange? = nil) -> NSMutableAttributedString {
        addAttributes([NSAttributedStringKey.paragraphStyle: value], range: getTextRange(range: range))
        return self
    }
    
    @discardableResult
    func addLineSpacing(_ value: CGFloat, range: NSRange? = nil) -> NSMutableAttributedString {
        let paragraph = NSMutableParagraphStyle()
        paragraph.lineSpacing = value
        addParagraphStyle(paragraph)
        return self
    }
    
    @discardableResult
    func addFont(_ value: UIFont?, range: NSRange? = nil) -> NSMutableAttributedString {
        addAttributes([NSAttributedStringKey.font: value ?? UIFont.systemFontSize], range: getTextRange(range: range))
        return self
    }
    
    @discardableResult
    func addForegroundColor(_ value: UIColor, range: NSRange? = nil) -> NSMutableAttributedString {
        addAttributes([NSAttributedStringKey.foregroundColor: value], range: getTextRange(range: range))
        return self
    }
    
    @discardableResult
    func addLink(_ value: String, color: UIColor = .blue, range: NSRange? = nil) -> NSMutableAttributedString {
        addAttributes([NSAttributedStringKey.link: URL(string: value) ?? value,
                       NSAttributedStringKey.foregroundColor: color], range: getTextRange(range: range))
        return self
    }
    
    @discardableResult
    func addLink(_ value: URL, color: UIColor = .blue, range: NSRange? = nil) -> NSMutableAttributedString {
        addAttributes([NSAttributedStringKey.link: value, NSAttributedStringKey.foregroundColor: color],
                      range: getTextRange(range: range))
        return self
    }
}

// MARK: - String
public extension NSMutableAttributedString {
    func getTextRange(range: NSRange?) -> NSRange {
        if let range = range { return range }
        return NSRange(location: 0, length: self.string.count)
    }
}

// MARK: - Paragrape Style
public extension NSMutableParagraphStyle {
    @discardableResult
    func addLineSpacing(_ value: CGFloat) -> NSMutableParagraphStyle {
        lineSpacing = value
        return self
    }
    
    @discardableResult
    func addAlignment(_ value: NSTextAlignment) -> NSMutableParagraphStyle {
        alignment = value
        return self
    }
    
    @discardableResult
    func addLineBreakMode(_ value: NSLineBreakMode) -> NSMutableParagraphStyle {
        lineBreakMode = value
        return self
    }
}
