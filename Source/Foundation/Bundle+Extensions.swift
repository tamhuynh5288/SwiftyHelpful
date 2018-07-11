//
//  Bundle+Extensions.swift
//  SwiftyExtensions
//
//  Created by Tam Huynh on 7/10/18.
//  Copyright © 2018 TH. All rights reserved.
//

import Foundation

public extension Bundle {    
    func getAppSchema() -> String {
        guard let bundleURLTypes: [Any] = self.object(forInfoDictionaryKey: "CFBundleURLTypes") as? [Any] else {
            fatalError()
        }
        let urlSchemeAny = (bundleURLTypes[0] as AnyObject)["CFBundleURLSchemes"]!!
        guard let schema: String = (urlSchemeAny as? [String])?[0] else {
            fatalError()
        }
        return schema
    }
}
