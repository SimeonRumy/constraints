//
//  File.swift
//  
//
//  Created by Simeon Rumyannikov on 05/06/2022.
//

import Foundation
import UIKit

//MARK: - Activate

extension NSLayoutConstraint {
    func activate() {
        self.isActive = true
    }
}

extension Array where Element: NSLayoutConstraint {
    func activate() {
        NSLayoutConstraint.activate(self)
    }
}

//MARK: - Priority

extension NSLayoutConstraint {
    func setPriority(_ val: Float) -> NSLayoutConstraint {
        self.priority = UILayoutPriority(rawValue: val)
        return self
    }
    
    func setPriority(_ val: UILayoutPriority) -> NSLayoutConstraint {
        self.priority = val
        return self
    }
}

extension Collection where Element: NSLayoutConstraint {
    
    func setPriority(_ val: Float) -> [NSLayoutConstraint] {
        self.map { $0.setPriority(val) }
    }
    
    func setPriority(_ val: UILayoutPriority) -> [NSLayoutConstraint] {
        self.map { $0.setPriority(val) }
    }
}

extension UILayoutPriority {
    static let almostRequired = UILayoutPriority(rawValue: 999)
}

//MARK: - Auto Layout

extension UIView {
    func enableAutoLayout() {
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func disableAutoLayout() {
        translatesAutoresizingMaskIntoConstraints = false
    }
}
 
