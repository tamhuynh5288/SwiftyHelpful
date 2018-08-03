//
//  UINavigationController+Extensions.swift
//  SwiftyHelpful
//
//  Created by Tam Huynh on 7/10/18.
//  Copyright © 2018 TH. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Navigation Style
public enum NavigationStyle {
    case original(leftButtons: [Any]?, rightButtons: [Any]?, customViewCenter: UIView?)
    case fitSize(leftButtons: [Any]?, rightButtons: [Any]?, customViewCenter: UIView?)
    
    static let navigationBarHeight = UINavigationController().navigationBar.bounds.height
    
    var type: (leftButtons: [Any]?, rightButtons: [Any]?, customViewCenter: UIView?)? {
        switch self {
        case let .original(leftButtons, rightButtons, customViewCenter):
            return (leftButtons: leftButtons, rightButtons: rightButtons, customViewCenter: customViewCenter)
        case let .fitSize(leftButtons, rightButtons, customViewCenter):
            if let leftButtons = leftButtons { fitSizeFor(views: leftButtons) }
            if let rightButtons = rightButtons { fitSizeFor(views: rightButtons) }
            if let customCenterView = customViewCenter { fitSizeFor(views: [customCenterView]) }
            return (leftButtons: leftButtons, rightButtons: rightButtons, customViewCenter: customViewCenter)
        }
    }
    
    /// Create list of views which have size fit with navigation bar. If width of item larger than navigation bar height. It will use its width
    ///
    /// - Parameter views: list of views need to fit size
    func fitSizeFor(views: [Any]) {
        for view in views {
            if let view = view as? UIView {
                var frame = view.frame
                let height = NavigationStyle.navigationBarHeight
                let width = view.sizeThatFits(CGSize(width: UIScreen.main.bounds.width, height: height)).width
                frame.size = CGSize(width: width >= height ? width : height, height: height)
                view.frame = frame
            }
        }
    }
}

// MARK: - Create custom navigation item
public extension UINavigationController {
    func setCustomNavigationBar(style: NavigationStyle) {
        guard let type = style.type else { return }
        var leftBarButtons = [UIBarButtonItem]()
        var rightBarButtons = [UIBarButtonItem]()
        
        type.leftButtons?.forEach({
            var barButton: UIBarButtonItem?
            if let barItem = $0 as? UIBarButtonItem {
                barButton = barItem
            } else if let barItem = $0 as? UIView {
                barButton = UIBarButtonItem(customView: barItem)
            }
            if let item = barButton {
                leftBarButtons.append(item)
            }
        })
        
        type.rightButtons?.forEach({
            var barButton: UIBarButtonItem?
            if let barItem = $0 as? UIBarButtonItem {
                barButton = barItem
            } else if let barItem = $0 as? UIView {
                barButton = UIBarButtonItem(customView: barItem)
            }
            if let item = barButton {
                rightBarButtons.append(item)
            }
        })
        
        if leftBarButtons.isEmpty == false {
            viewControllers.last?.navigationItem.leftBarButtonItems = leftBarButtons
        }
        
        if rightBarButtons.isEmpty == false {
            viewControllers.last?.navigationItem.rightBarButtonItems = rightBarButtons
        }
        
        if let customView = type.customViewCenter {
            viewControllers.last?.navigationItem.titleView = customView
        }
    }
}

// MARK: - NavigationBarItems
public extension UIViewController {
    var leftBarButton: UIButton? {
        return navigationItem.leftBarButtonItems?.first?.customView as? UIButton
    }
    
    var rightBarButton: UIButton? {
        return navigationItem.rightBarButtonItems?.first?.customView as? UIButton
    }
    
    var leftBarButtons: [UIButton]? {
        var buttons = [UIButton]()
        navigationItem.leftBarButtonItems?.forEach({ (buttonItem) in
            if let button = buttonItem.customView as? UIButton { buttons.append(button) }
        })
        return buttons.isEmpty ? nil : buttons
    }
    
    var rightBarButtons: [UIButton]? {
        var buttons = [UIButton]()
        navigationItem.rightBarButtonItems?.forEach({ (buttonItem) in
            if let button = buttonItem.customView as? UIButton { buttons.append(button) }
        })
        return buttons.isEmpty ? nil : buttons
    }
}

// MARK: - NavigationBarItemsActions
public extension UIViewController {
    func leftBarButtonActionAt(_ index: Int, action: Selector) {
        guard let barButtons = leftBarButtons, let barButton = barButtons.indices.contains(index) ? barButtons[index] : nil else { return }
        barButton.addTarget(self, action: action, for: .touchUpInside)
    }
    
    func leftBarButtonAction(_ action: Selector) {
        leftBarButtonActionAt(0, action: action)
    }
    
    func leftBarButtonActions(_ actions: [Selector]) {
        for (index, action) in actions.enumerated() {
            leftBarButtonActionAt(index, action: action)
        }
    }
    
    func rightBarButtonActionAt(_ index: Int, action: Selector) {
        guard let barButtons = rightBarButtons, let barButton = barButtons.indices.contains(index) ? barButtons[index] : nil else { return }
        barButton.addTarget(self, action: action, for: .touchUpInside)
    }
    
    func rightBarButtonAction(action: Selector) {
        rightBarButtonActionAt(0, action: action)
    }
    
    func rightBarButtonActions(_ actions: [Selector]) {
        for (index, action) in actions.enumerated() {
            rightBarButtonActionAt(index, action: action)
        }
    }
}

//******************
// MARK: - Globals
//******************

/// Create NavigationBar button item
///
/// - Parameters:
///   - frame: Button's frame
///   - title: Button's title
///   - titleColor: Button's title color. Default is Blue
///   - image: Button's imgae
///   - imageSelected: Button's image when in selected sate
///   - horizontalAlignment: Horizontal alignment
///   - contenEdgeInsets: Button's content edge insets
/// - Returns: NavigationBar button item
public func barButtonItem(frame: CGRect = CGRect(x: 0, y: 0, width: 44, height: 44),
                   title: String? = nil, titleColor: UIColor? = UIColor.blue,
                   image: UIImage? = nil, imageSelected: UIImage? = nil,
                   horizontalAlignment: UIControlContentHorizontalAlignment = .center,
                   contenEdgeInsets: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)) -> UIButton {
    let button = UIButton(frame: frame)
    button.setTitle(title, for: .normal)
    button.setTitleColor(titleColor, for: .normal)
    button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
    button.setImage(image, for: .normal)
    button.setImage(imageSelected, for: .selected)
    button.contentEdgeInsets = contenEdgeInsets
    button.contentHorizontalAlignment = horizontalAlignment
    return button
}

public func leftBarButtonItem(frame: CGRect = CGRect(x: 0, y: 0, width: 44, height: 44),
                       title: String? = nil,
                       titleColor: UIColor? = UIColor.blue,
                       image: UIImage? = nil,
                       imageSelected: UIImage? = nil,
                       contenEdgeInsets: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)) -> UIButton {
    return barButtonItem(frame: frame, title: title, titleColor: titleColor, image: image, imageSelected: imageSelected,
                         horizontalAlignment: .left, contenEdgeInsets: contenEdgeInsets)
}

public func rightBarButtonItem(frame: CGRect = CGRect(x: 0, y: 0, width: 44, height: 44),
                        title: String? = nil, titleColor: UIColor? = UIColor.blue,
                        image: UIImage? = nil, imageSelected: UIImage? = nil,
                        contenEdgeInsets: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)) -> UIButton {
    return barButtonItem(frame: frame, title: title, titleColor: titleColor, image: image, imageSelected: imageSelected,
                         horizontalAlignment: .right, contenEdgeInsets: contenEdgeInsets)
}

public func centerLabelItem(title: String) -> UILabel {
    let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
    titleLabel.text = title
    return titleLabel
}
