//
//  NSLayoutExtensions.swift
//  
//
//  Created by Simeon Rumyannikov on 05/06/2022.
//
//  Permission is hereby granted, free of charge, to any person obtaining
//  a copy of this software and associated documentation files (the
//  Software"), to deal in the Software without restriction, including
//  without limitation the rights to use, copy, modify, merge, publish,
//  distribute, sublicense, and/or sell copies of the Software, and to
//  permit persons to whom the Software is furnished to do so, subject to
//  the following conditions:
//
//  The above copyright notice and this permission notice shall be
//  included in all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
//  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
//  MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
//  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
//  LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
//  OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
//  WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.


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
    func priority(_ val: Float) -> NSLayoutConstraint {
        self.priority = UILayoutPriority(rawValue: val)
        return self
    }
    
    func priority(_ val: UILayoutPriority) -> NSLayoutConstraint {
        self.priority = val
        return self
    }
}

public extension Collection where Element: NSLayoutConstraint {
    
    func priority(_ val: Float) -> [NSLayoutConstraint] {
        self.map { $0.priority(val) }
    }
    
    func priority(_ val: UILayoutPriority) -> [NSLayoutConstraint] {
        self.map { $0.priority(val) }
    }
}

public extension UILayoutPriority {
    static let almostRequired = UILayoutPriority(rawValue: 999)
}

public extension UILayoutPriority {
    static func priority(_ custom: Float) -> UILayoutPriority {
        UILayoutPriority(rawValue: custom)
    }
}

//MARK: - Auto Layout

public extension UIView {
    func enableAutoLayout() {
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func disableAutoLayout() {
        translatesAutoresizingMaskIntoConstraints = true
    }
}

//MARK: - Inject Multiplier

internal extension NSLayoutConstraint {
    func multiply(_ multiplier: CGFloat) -> NSLayoutConstraint {
        return NSLayoutConstraint(item: firstItem!,
                                  attribute: firstAttribute,
                                  relatedBy: relation,
                                  toItem: secondItem,
                                  attribute: secondAttribute,
                                  multiplier: multiplier,
                                  constant: constant)
    }
}

public extension Collection where Element: NSLayoutConstraint {
    
    func multiplyEach(_ val: CGFloat) -> [NSLayoutConstraint] {
        self.map { $0.multiply(val) }
    }

}
