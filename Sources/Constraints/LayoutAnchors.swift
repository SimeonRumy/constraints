//
//  LayoutAnchors.swift
//  
//
//  Created by Simeon Rumyannikov on 12/11/2022.
//
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


#if os(macOS)
import Cocoa

#else
import UIKit

#endif

//MARK: - Base Layout Anchor

/// Wraps the default methods available to all NSLayoutAnchors
public protocol BaseLayoutAnchor {
    
    func constraint(equalTo anchor: Self,constant: CGFloat) -> NSLayoutConstraint
    func constraint(greaterThanOrEqualTo anchor: Self, constant: CGFloat) -> NSLayoutConstraint
    func constraint(lessThanOrEqualTo anchor: Self,constant: CGFloat) -> NSLayoutConstraint
}

extension NSLayoutAnchor: BaseLayoutAnchor {}

//MARK: - Layout Anchor

/// Adds multiplier paramater to default BaseLayoutAnchor/NSLayoutAnchor methods
public protocol LayoutAnchor {
    func constraint(equalTo anchor: Self, multiplier: CGFloat, constant: CGFloat) -> NSLayoutConstraint
    func constraint(greaterThanOrEqualTo anchor: Self, multiplier: CGFloat, constant: CGFloat) -> NSLayoutConstraint
    func constraint(lessThanOrEqualTo anchor: Self, multiplier: CGFloat, constant: CGFloat) -> NSLayoutConstraint
}

/// Default implementation of multiply methods
extension LayoutAnchor where Self: BaseLayoutAnchor {
    public func constraint(equalTo anchor: Self, multiplier: CGFloat, constant: CGFloat) -> NSLayoutConstraint {
        self.constraint(equalTo: anchor, constant: constant).multiply(multiplier)
    }

    public func constraint(greaterThanOrEqualTo anchor: Self, multiplier: CGFloat, constant: CGFloat) -> NSLayoutConstraint {
        self.constraint(greaterThanOrEqualTo: anchor, constant: constant).multiply(multiplier)
    }

    public func constraint(lessThanOrEqualTo anchor: Self, multiplier: CGFloat, constant: CGFloat) -> NSLayoutConstraint {
        self.constraint(lessThanOrEqualTo: anchor, constant: constant).multiply(multiplier)
    }
}

extension NSLayoutAnchor: LayoutAnchor {}


//MARK: - Anchor Pair

/// Similar to LayoutAnchor (signular), but each method can return multiple constraints.
/// Designed to be a common interface for  types containing more than one anchor. Ex: AnchorPair
public protocol LayoutAnchors {
    func constraint(equalTo anchor: Self, multiplier: CGFloat, constant: CGFloat) -> [NSLayoutConstraint]
    func constraint(greaterThanOrEqualTo anchor: Self, multiplier: CGFloat, constant: CGFloat) -> [NSLayoutConstraint]
    func constraint(lessThanOrEqualTo anchor: Self, multiplier: CGFloat, constant: CGFloat) -> [NSLayoutConstraint]
}

public class AnchorPair<T: BaseLayoutAnchor, R: BaseLayoutAnchor> {

    var anchor1: T
    var anchor2: R
    
    init(anchor1: T, anchor2: R) {
        self.anchor1 = anchor1
        self.anchor2 = anchor2
    }
}

extension AnchorPair: LayoutAnchors {

    public func constraint(equalTo anchor: AnchorPair, multiplier: CGFloat,  constant: CGFloat) -> [NSLayoutConstraint] {
        [
            self.anchor1.constraint(equalTo: anchor.anchor1, constant: constant).multiply(multiplier),
            self.anchor2.constraint(equalTo: anchor.anchor2, constant: constant).multiply(multiplier),
        ]
    }

    public func constraint(greaterThanOrEqualTo anchor: AnchorPair, multiplier: CGFloat,  constant: CGFloat) -> [NSLayoutConstraint] {
        [
            self.anchor1.constraint(greaterThanOrEqualTo: anchor.anchor1, constant: constant).multiply(multiplier),
            self.anchor2.constraint(greaterThanOrEqualTo: anchor.anchor2, constant: constant).multiply(multiplier),
        ]
    }


    public func constraint(lessThanOrEqualTo anchor: AnchorPair, multiplier: CGFloat, constant: CGFloat) -> [NSLayoutConstraint] {
        [
            self.anchor1.constraint(lessThanOrEqualTo: anchor.anchor1, constant: constant).multiply(multiplier),
            self.anchor2.constraint(lessThanOrEqualTo: anchor.anchor2, constant: constant).multiply(multiplier),
        ]
    }

}

extension AnchorPair where T: Dimension, R: Dimension {
    
    public func constraint(equalToConstant constant: CGFloat) -> [NSLayoutConstraint] {
        [
            self.anchor1.constraint(equalToConstant: constant),
            self.anchor2.constraint(equalToConstant: constant),
        ]
    }
    
    public func constraint(greaterThanOrEqualToConstant constant: CGFloat) -> [NSLayoutConstraint] {
        [
            self.anchor1.constraint(greaterThanOrEqualToConstant: constant),
            self.anchor2.constraint(greaterThanOrEqualToConstant: constant),
        ]
    }
    
    public func constraint(lessThanOrEqualToConstant constant: CGFloat) -> [NSLayoutConstraint] {
        [
            self.anchor1.constraint(lessThanOrEqualToConstant: constant),
            self.anchor2.constraint(lessThanOrEqualToConstant: constant),
        ]
    }
}

