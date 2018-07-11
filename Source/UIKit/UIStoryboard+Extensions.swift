//
//  UIStoryboard+Extensions.swift
//  SwiftyExtensions
//
//  Created by Tam Huynh on 7/10/18.
//  Copyright © 2018 TH. All rights reserved.
//

import Foundation
import UIKit

/// Mark: - Instantiate
public protocol StoryboardInstantiate {
    func instantiateRootController(storyboardName name: String?) -> UIViewController?
    func instantiateViewController(identifier: String, storyboardName name: String?) -> UIViewController
    func instantiateViewController<T: UIViewController>(type: T.Type, storyboardName name: String?) -> T
}

public extension StoryboardInstantiate {
    func instantiateRootController(storyboardName name: String? = nil) -> UIViewController? {
        let storyboard = UIStoryboard(name: name ?? "Main", bundle: nil)
        return storyboard.instantiateInitialViewController()
    }
    
    func instantiateViewController(identifier: String, storyboardName name: String? = nil) -> UIViewController {
        let storyboard = UIStoryboard(name: name ?? "Main", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: identifier)
    }
    
    func instantiateViewController<T: UIViewController>(type: T.Type, storyboardName name: String? = nil) -> T {
        let identifier = T.viewControllerIdentifier
        guard let vc = instantiateViewController(identifier: identifier, storyboardName: name) as? T else {
            fatalError("Couldn't instantiate view controller with identifier \(identifier) ")
        }
        return vc
    }
}
