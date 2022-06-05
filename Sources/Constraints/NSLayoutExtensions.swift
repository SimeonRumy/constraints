//
//  File.swift
//  
//
//  Created by Simeon Rumyannikov on 05/06/2022.
//

import Foundation
import UIKit

//MARK: - Activate

public extension NSLayoutConstraint {
    func activate() {
        self.isActive = true
    }
}

public extension Array where Element: NSLayoutConstraint {
    func activate() {
        NSLayoutConstraint.activate(self)
    }
}

//MARK: - Priority

public extension NSLayoutConstraint {
    func setPriority(_ val: Float) -> NSLayoutConstraint {
        self.priority = UILayoutPriority(rawValue: val)
        return self
    }
    
    func setPriority(_ val: UILayoutPriority) -> NSLayoutConstraint {
        self.priority = val
        return self
    }
}

public extension Collection where Element: NSLayoutConstraint {
    
    func setPriority(_ val: Float) -> [NSLayoutConstraint] {
        self.map { $0.setPriority(val) }
    }
    
    func setPriority(_ val: UILayoutPriority) -> [NSLayoutConstraint] {
        self.map { $0.setPriority(val) }
    }
}

public extension UILayoutPriority {
    static let almostRequired = UILayoutPriority(rawValue: 999)
}

//MARK: - Auto Layout

public extension UIView {
    func enableAutoLayout() {
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func disableAutoLayout() {
        translatesAutoresizingMaskIntoConstraints = false
    }
}
 
