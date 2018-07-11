//
//  UIView+Extensions.swift
//  SwiftyExtensions
//
//  Created by Tam Huynh on 7/10/18.
//  Copyright © 2018 TH. All rights reserved.
//

import Foundation
import UIKit

// MARK: Load Bundle
public extension UIView {
    func loadViewFromNib() {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        guard let view = nib.instantiate(withOwner: self, options: nil).first as? UIView else { return }
        addSubview(view)
        view.scaleEqualSuperView()
    }
    
    func scaleEqualSuperView() {
        guard let superView = superview else { return }
        translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([leadingAnchor.constraint(equalTo: superView.leadingAnchor),
                                     trailingAnchor.constraint(equalTo: superView.trailingAnchor),
                                     topAnchor.constraint(equalTo: superView.topAnchor),
                                     bottomAnchor.constraint(equalTo: superView.bottomAnchor)])
    }
}

public extension UIView {
    @discardableResult
    func layoutConstraint(attr1: NSLayoutAttribute, relatedBy: NSLayoutRelation = .equal, toItem view: UIView, attr2: NSLayoutAttribute, multiplier: CGFloat = 1, constant: CGFloat = 0, isActive: Bool = true) -> NSLayoutConstraint {
        let constraint = NSLayoutConstraint(item: self, attribute: attr1, relatedBy: relatedBy, toItem: view, attribute: attr2, multiplier: multiplier, constant: constant)
        constraint.isActive = isActive
        return constraint
    }
    
    @discardableResult
    func topLayoutConstraint(relatedBy: NSLayoutRelation = .equal, toItem view: UIView, attr2: NSLayoutAttribute, multiplier: CGFloat = 1, constant: CGFloat = 0, isActive: Bool = true) -> NSLayoutConstraint {
        return layoutConstraint(attr1: .top, relatedBy: relatedBy, toItem: view, attr2: attr2, multiplier: multiplier, constant: constant, isActive: isActive)
    }
    
    @discardableResult
    func bottomLayoutConstraint(relatedBy: NSLayoutRelation = .equal, toItem view: UIView, attr2: NSLayoutAttribute, multiplier: CGFloat = 1, constant: CGFloat = 0, isActive: Bool = true) -> NSLayoutConstraint {
        return layoutConstraint(attr1: .bottom, relatedBy: relatedBy, toItem: view, attr2: attr2, multiplier: multiplier, constant: constant, isActive: isActive)
    }
    
    @discardableResult
    func leadingLayoutConstraint(relatedBy: NSLayoutRelation = .equal, toItem view: UIView, attr2: NSLayoutAttribute, multiplier: CGFloat = 1, constant: CGFloat = 0, isActive: Bool = true) -> NSLayoutConstraint {
        return layoutConstraint(attr1: .leading, relatedBy: relatedBy, toItem: view, attr2: attr2, multiplier: multiplier, constant: constant, isActive: isActive)
    }
    
    @discardableResult
    func trailingLayoutConstraint(relatedBy: NSLayoutRelation = .equal, toItem view: UIView, attr2: NSLayoutAttribute, multiplier: CGFloat = 1, constant: CGFloat = 0, isActive: Bool = true) -> NSLayoutConstraint {
        return layoutConstraint(attr1: .trailing, relatedBy: relatedBy, toItem: view, attr2: attr2, multiplier: multiplier, constant: constant, isActive: isActive)
    }
}

//******************
// MARK: - Animation
//******************
public extension UIView {
    func rotate(_ toValue: CGFloat, duration: CFTimeInterval = 0.2) {
        let animation = CABasicAnimation(keyPath: "transform.rotation")
        animation.toValue = toValue
        animation.duration = duration
        animation.isRemovedOnCompletion = false
        animation.fillMode = kCAFillModeForwards
        layer.add(animation, forKey: nil)
    }
}
