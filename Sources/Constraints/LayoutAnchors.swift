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

//MARK: - Layout Anchor

/// Wraps the default methods available to all NSLayoutAnchors
public protocol LayoutAnchor {
    
    func constraint(equalTo anchor: Self,constant: CGFloat) -> NSLayoutConstraint
    func constraint(greaterThanOrEqualTo anchor: Self, constant: CGFloat) -> NSLayoutConstraint
    func constraint(lessThanOrEqualTo anchor: Self,constant: CGFloat) -> NSLayoutConstraint
}


/// Adds multiplier paramater to default BaseLayoutAnchor/NSLayoutAnchor methods
/// Default implementation of multiply methods
extension LayoutAnchor {
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
    func constraint(equalTo anchor: Self, multiplier: CGFloat, insets: EdgeInsetPair) -> [NSLayoutConstraint]
    func constraint(greaterThanOrEqualTo anchor: Self, multiplier: CGFloat, insets: EdgeInsetPair) -> [NSLayoutConstraint]
    func constraint(lessThanOrEqualTo anchor: Self, multiplier: CGFloat, insets: EdgeInsetPair) -> [NSLayoutConstraint]
}

public class LayoutAnchorPair<T: LayoutAnchor, R: LayoutAnchor> {

    var anchor1: T
    var anchor2: R
    
    init(anchor1: T, anchor2: R) {
        self.anchor1 = anchor1
        self.anchor2 = anchor2
    }
}

public protocol EdgeInsetPair {
    var constant1: CGFloat { get }
    var constant2: CGFloat { get }
}

struct HorizontalInsetPair: EdgeInsetPair {
    
    let right: CGFloat
    let left: CGFloat
    
    var constant1: CGFloat {
        return right
    }
    
    var constant2: CGFloat {
        return left
    }
    
}

struct VerticalInsetPair: EdgeInsetPair {
    
    let top: CGFloat
    let bottom: CGFloat
    
    var constant1: CGFloat {
        return top
    }
    
    var constant2: CGFloat {
        return bottom
    }
    
}

struct GenericInsetPair: EdgeInsetPair {
    
    var constant1: CGFloat
    
    var constant2: CGFloat
    
    init(constant1: CGFloat, constant2: CGFloat) {
        self.constant1 = constant1
        self.constant2 = constant2
    }
    
    init(constant: CGFloat) {
        self.init(constant1: constant, constant2: constant)
    }
    
}

extension LayoutAnchorPair: LayoutAnchors {

    public func constraint(equalTo anchor: LayoutAnchorPair, multiplier: CGFloat,  insets: EdgeInsetPair) -> [NSLayoutConstraint] {
        [
            self.anchor1.constraint(equalTo: anchor.anchor1, multiplier: multiplier, constant: insets.constant1),
            self.anchor2.constraint(equalTo: anchor.anchor2, multiplier: multiplier, constant: insets.constant2),
        ]
    }

    public func constraint(greaterThanOrEqualTo anchor: LayoutAnchorPair, multiplier: CGFloat,  insets: EdgeInsetPair) -> [NSLayoutConstraint] {
        [
            self.anchor1.constraint(greaterThanOrEqualTo: anchor.anchor1, multiplier: multiplier, constant: insets.constant1),
            self.anchor2.constraint(greaterThanOrEqualTo: anchor.anchor2, multiplier: multiplier, constant: insets.constant2),
        ]
    }


    public func constraint(lessThanOrEqualTo anchor: LayoutAnchorPair, multiplier: CGFloat, insets: EdgeInsetPair) -> [NSLayoutConstraint] {
        [
            self.anchor1.constraint(lessThanOrEqualTo: anchor.anchor1, multiplier: multiplier, constant: insets.constant1),
            self.anchor2.constraint(lessThanOrEqualTo: anchor.anchor2, multiplier: multiplier, constant: insets.constant2),
        ]
    }
}



//MARK: - Edge Anchors 


public protocol LayoutAnchorGroup {
    func constraint(equalTo anchor: Self, multiplier: CGFloat, insets: UIEdgeInsets) -> [NSLayoutConstraint]
    func constraint(greaterThanOrEqualTo anchor: Self, multiplier: CGFloat, insets: UIEdgeInsets) -> [NSLayoutConstraint]
    func constraint(lessThanOrEqualTo anchor: Self, multiplier: CGFloat, insets: UIEdgeInsets) -> [NSLayoutConstraint]
}


public struct EdgeAnchors {

    var xAxis: XAxisAnchorPair
    var yAxis: YAxisAnchorPair
    
    init(xAxis: XAxisAnchorPair, yAxis: YAxisAnchorPair) {
        self.xAxis = xAxis
        self.yAxis = yAxis
    }
}

extension EdgeAnchors: LayoutAnchorGroup {
    

    public func constraint(equalTo anchor: EdgeAnchors, multiplier: CGFloat,  insets: UIEdgeInsets) -> [NSLayoutConstraint] {
        Constraints {
            self.xAxis.constraint(equalTo: anchor.xAxis, multiplier: multiplier, insets: insets.horizontalInsets())
            self.yAxis.constraint(equalTo: anchor.yAxis, multiplier: multiplier, insets: insets.verticalInsets())
        }
    }

    public func constraint(greaterThanOrEqualTo anchor: EdgeAnchors, multiplier: CGFloat,  insets: UIEdgeInsets) -> [NSLayoutConstraint] {
        Constraints {
            self.xAxis.constraint(greaterThanOrEqualTo: anchor.xAxis, multiplier: multiplier, insets: insets.horizontalInsets())
            self.yAxis.constraint(greaterThanOrEqualTo: anchor.yAxis, multiplier: multiplier, insets: insets.verticalInsets())
        }
    }


    public func constraint(lessThanOrEqualTo anchor: EdgeAnchors, multiplier: CGFloat, insets: UIEdgeInsets) -> [NSLayoutConstraint] {
        Constraints {
            self.xAxis.constraint(lessThanOrEqualTo: anchor.xAxis, multiplier: multiplier, insets: insets.horizontalInsets())
            self.yAxis.constraint(lessThanOrEqualTo: anchor.yAxis, multiplier: multiplier, insets: insets.verticalInsets())
        }
    }

}




extension UIEdgeInsets {
    func horizontalInsets() -> HorizontalInsetPair {
        HorizontalInsetPair(right: self.right, left: self.left)
    }
}

extension UIEdgeInsets {
    func verticalInsets() -> VerticalInsetPair {
        VerticalInsetPair(top: self.top, bottom: self.bottom)
    }
}
