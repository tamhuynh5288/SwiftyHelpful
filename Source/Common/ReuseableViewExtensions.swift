//
//  ReuseableViewExtensions.swift
//  SwiftyExtensions
//
//  Created by Tam Huynh on 7/10/18.
//  Copyright © 2018 TH. All rights reserved.
//

import UIKit
import Foundation

public protocol ReusableView: class {
    static var reuseIdentifier: String { get }
}

public extension ReusableView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

// MARK: - Conform ReusableView for tableView and collectionView cell, header & footer
extension UITableViewCell: ReusableView {}
extension UITableViewHeaderFooterView: ReusableView {}
extension UICollectionViewCell: ReusableView {}

// MARK: - Register cell, header and footer for tableView
public extension UITableView {
    /// Register a UITableViewCell which using a nib file
    ///
    /// - Parameter cell: Type of UITableViewCell class
    func registerNib<T: UITableViewCell>(forCell cell: T.Type) {
        register(UINib(nibName: T.reuseIdentifier, bundle: nil), forCellReuseIdentifier: T.reuseIdentifier)
    }
    
    /// Register a UITableViewCell which only using a class file
    ///
    /// - Parameter cell: Type of UITableViewCell class
    func registerClass<T: UITableViewCell>(forCell cell: T.Type) {
        register(T.self, forCellReuseIdentifier: T.reuseIdentifier)
    }
    
    /// Register a UITableViewHeaderFooterView which using a nib file
    ///
    /// - Parameter cell: Type of UITableViewHeaderFooterView class
    func registerNib<T: UITableViewHeaderFooterView>(forHeaderFooterView view: T.Type) {
        register(UINib(nibName: T.reuseIdentifier, bundle: nil), forHeaderFooterViewReuseIdentifier: T.reuseIdentifier)
    }
    
    /// Register a UITableViewHeaderFooterView which only using a class file
    ///
    /// - Parameter cell: Type of UITableViewHeaderFooterView class
    func registerClass<T: UITableViewHeaderFooterView>(forHeaderFooterView view: T.Type) {
        register(T.self, forHeaderFooterViewReuseIdentifier: T.reuseIdentifier)
    }
}

// MARK: - Dequeue reuse cell, header and footer for tableView
public extension UITableView {
    /// Dequeue a Reuseable table view cell with only use identifier
    ///
    /// - Returns: Class of UITableViewCell
    func dequeueReusableCell<T: UITableViewCell>() -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.reuseIdentifier)")
        }
        return cell
    }
    
    /// Dequeue a Reuseable tableViewCell
    ///
    /// - Parameter indexPath: correctly indexPath of tableViewCell in tableView
    /// - Returns: Class of UITableViewCell
    func dequeueReusableCell<T: UITableViewCell>(forIndexPath indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.reuseIdentifier)")
        }
        return cell
    }
    
    /// Dequeue a Reuseable table header & footer view
    ///
    /// - Parameter indexPath: correctly indexPath of UITableViewHeaderFooterView in tableView
    /// - Returns: Class of UITableViewHeaderFooterView
    func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>() -> T {
        guard let view = dequeueReusableHeaderFooterView(withIdentifier: T.reuseIdentifier) as? T else {
            fatalError("Could not dequeue header/footer view with identifier: \(T.reuseIdentifier)")
        }
        return view
    }
}

// MARK: - Register cell, header and footer for collectionView
public extension UICollectionView {
    /// Register a UICollectionViewCell which using a nib file
    ///
    /// - Parameter cell: Type of UICollectionViewCell class
    func registerNib<T: UICollectionViewCell>(forCell cell: T.Type) {
        register(UINib(nibName: T.reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: T.reuseIdentifier)
    }
    
    /// Register a UICollectionViewCell which only using a class file
    ///
    /// - Parameter cell: Type of UICollectionViewCell class
    func registerClass<T: UICollectionViewCell>(forCell cell: T.Type) {
        register(T.self, forCellWithReuseIdentifier: T.reuseIdentifier)
    }
}

// MARK: - Dequeue reuse cell, header and footer for collection view
public extension UICollectionView {
    /// Dequeue a Reuseable collectionViewCell
    ///
    /// - Parameter indexPath: correctly indexPath of collectionViewCell in collectionView
    /// - Returns: Class of UICollectionViewCell
    func dequeueReusableCell<T: UICollectionViewCell>(forIndexPath indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.reuseIdentifier)")
        }
        return cell
    }
}
