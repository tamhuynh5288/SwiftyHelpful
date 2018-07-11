//
//  UIViewController+Extensions.swift
//  SwiftyExtensions
//
//  Created by Tam Huynh on 7/10/18.
//  Copyright © 2018 TH. All rights reserved.
//

import Foundation
import UIKit

/// MARK: - Identifiable Protocol
public protocol ViewControllerIdentifiable {
    static var viewControllerIdentifier: String { get }
}

public extension ViewControllerIdentifiable where Self: UIViewController {
    static var viewControllerIdentifier: String {
        return String(describing: self)
    }
}

/// MARK: - Conform protocol
extension UIViewController: ViewControllerIdentifiable { }

// MARK: - Go Back Action
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

// MARK: - ChildViewController
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
