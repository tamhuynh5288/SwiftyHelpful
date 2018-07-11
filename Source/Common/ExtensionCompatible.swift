//
//  ExtensionCompatible.swift
//  SwiftyExtensions
//
//  Created by Tam Huynh on 7/10/18.
//  Copyright © 2018 TH. All rights reserved.
//

import Foundation

// MARK: - Extension utils
public struct Extension<Base> {
    let base: Base
    init (_ base: Base) {
        self.base = base
    }
}

public protocol ExtensionCompatible {
    associatedtype Compatible
    static var ext: Extension<Compatible>.Type { get }
    var ext: Extension<Compatible> { get }
}

public extension ExtensionCompatible {
    static var ext: Extension<Self>.Type {
        return Extension<Self>.self
    }
    
    var ext: Extension<Self> {
        return Extension(self)
    }
}
