//
//  UIViewController+Extensions.swift
//  SwiftyHelpful
//
//  Created by Tam Huynh on 7/10/18.
//  Copyright © 2018 TH. All rights reserved.
//

import Foundation
import UIKit

//*******************************
// MARK: - Identifiable Protocol
//*******************************
public protocol ViewControllerIdentifiable {
    static var viewControllerIdentifier: String { get }
}

public extension ViewControllerIdentifiable where Self: UIViewController {
    static var viewControllerIdentifier: String {
        return String(describing: self)
    }
}

//**************************
// MARK: - Conform protocol
//**************************
extension UIViewController: ViewControllerIdentifiable { }
extension UIViewController: ExtensionCompatible {}

//**************************
// MARK: - Go Back Action
//**************************
public extension UIViewController {
    @objc func goBack() {
        if navigationController != nil { popController() }
        dismissController()
    }
    
    @objc func popController() {
        view.endEditing(true)
        navigationController?.popViewController(animated: true)
    }
    
    @objc func dismissController() {
        view.endEditing(true)
        dismiss(animated: true, completion: nil)
    }
}

//*****************************
// MARK: - ChildViewController
//*****************************
public extension UIViewController {
    func addViewController(_ viewController: UIViewController, containerView: UIView) {
        addChildViewController(viewController)
        containerView.addSubview(viewController.view)
        viewController.view.frame = view.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        viewController.didMove(toParentViewController: self)
    }
    
    func addViewController(_ viewController: UIViewController) {
        addViewController(viewController, containerView: view)
    }
    
    func removeViewController(_ viewController: UIViewController) {
        guard parent != nil else { return }
        viewController.willMove(toParentViewController: nil)
        viewController.view.removeFromSuperview()
        viewController.removeFromParentViewController()
    }
}

//*****************************************************
// MARK: - (ExtensionCompatible) CurrentViewController
//*****************************************************
public extension Extension where Base: UIViewController {
    static var currentViewController: UIViewController? {
        if let topController = UIApplication.shared.keyWindow?.rootViewController {
            return topViewController(topController)
        }
        return nil
    }
    
    static func topViewController(_ viewController: UIViewController?) -> UIViewController? {
        if let nav = viewController as? UINavigationController {
            return topViewController(nav.visibleViewController)
        }
        if let tab = viewController as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topViewController(selected)
            }
        }
        if let presented = viewController?.presentedViewController {
            return topViewController(presented)
        }
        return viewController
    }
}

//*****************************************************
// MARK: - (ExtensionCompatible) Instantiate
//*****************************************************
public extension Extension where Base: UIViewController {
    static func instantiate() -> UIViewController {
        let type = Base.self
        let className = type.className
        let storyboardName = nameConverter(className)
        let sb = UIStoryboard(name: storyboardName, bundle: Bundle.main)
        if let vc = sb.instantiateInitialViewController() as? UINavigationController {
            return vc
        } else if let vc = sb.instantiateInitialViewController() as? UITabBarController {
            return vc
        }
        return instantiate(type: Base.self)
    }
    
    static func instantiate<T: UIViewController>(type: T.Type) -> T {
        let className = type.className
        let storyboardName = nameConverter(className)
        let sb = UIStoryboard(name: storyboardName, bundle: Bundle.main)
        guard let vc = sb.instantiateInitialViewController() as? T else {
            fatalError("Couldn't instantiate initial view controller")
        }
        return vc
    }
    
    static func nameConverter(_ className: String) -> String {
        let name = className.replacingOccurrences(of: "View", with: "", options: .literal, range: nil)
        return name.replacingOccurrences(of: "Controller", with: "", options: .literal, range: nil)
    }
}
