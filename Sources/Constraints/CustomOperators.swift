//
//  CustomOperators.swift
//  
//
//  Created by Simeon Rumyannikov on 10/11/2022.
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

public typealias XAxis = NSLayoutXAxisAnchor
public typealias YAxis = NSLayoutYAxisAnchor
public typealias Dimension = NSLayoutDimension

public typealias DimensionAnchorPair = AnchorPair<Dimension, Dimension>

//MARK: - Layout Block

public struct LayoutBlock<A> {
    internal let anchor: A
    fileprivate var constant: CGFloat = 0
    fileprivate var multiplier: CGFloat = 1
    
    internal init(anchor: A) {
        self.anchor = anchor
    }
    
    internal init(block: LayoutBlock) {
        self.anchor = block.anchor
        self.constant = block.constant
        self.multiplier = block.multiplier
    }
}

//MARK: - Constant Addition

public func +<A>(lhs: LayoutBlock<A>, rhs: CGFloat) -> LayoutBlock<A> {
    var newBlock = LayoutBlock(block: lhs)
    newBlock.constant = newBlock.constant + rhs
    return newBlock
}


public func -<A>(lhs: LayoutBlock<A>, rhs: CGFloat) -> LayoutBlock<A> {
    var newBlock = LayoutBlock(block: lhs)
    newBlock.constant = newBlock.constant - rhs
    return newBlock
}

public func +<A>(lhs: CGFloat, rhs: LayoutBlock<A>) -> LayoutBlock<A> {
    return rhs + lhs
}

// we do not need a inverted function for minue since that is acutally a plus with a negative int

//MARK: - Constant Multiplication

public func *<A>(lhs: LayoutBlock<A>, rhs: CGFloat) -> LayoutBlock<A> {
    var newBlock = LayoutBlock(block: lhs)
    newBlock.multiplier = newBlock.multiplier * rhs
    return newBlock
}

public func /<A>(lhs: LayoutBlock<A>, rhs: CGFloat) -> LayoutBlock<A> {
    var newBlock = LayoutBlock(block: lhs)
    newBlock.multiplier = newBlock.multiplier / rhs
    return newBlock
}


public func *<A>(lhs: CGFloat, rhs: LayoutBlock<A>) -> LayoutBlock<A> {
    rhs * lhs
}

public func /<A>(lhs: CGFloat, rhs: LayoutBlock<A>) -> LayoutBlock<A> {
    rhs * lhs
}

//MARK: - Layout Blocks with Constant Dimensions

public func ==<A: Dimension>(lhs: LayoutBlock<A>, rhs: CGFloat) -> NSLayoutConstraint {
    lhs.anchor.constraint(equalToConstant: rhs)
}

public func >=<A: Dimension>(lhs: LayoutBlock<A>, rhs: CGFloat) -> NSLayoutConstraint {
    lhs.anchor.constraint(greaterThanOrEqualToConstant: rhs)
}

public func <=<A: Dimension>(lhs: LayoutBlock<A>, rhs: CGFloat) -> NSLayoutConstraint {
    lhs.anchor.constraint(lessThanOrEqualToConstant: rhs)
}


public func ==<A: DimensionAnchorPair>(lhs: LayoutBlock<A>, rhs: CGFloat) -> [NSLayoutConstraint] {
    lhs.anchor.constraint(equalToConstant: rhs)
}

public func >=<A: DimensionAnchorPair>(lhs: LayoutBlock<A>, rhs: CGFloat) -> [NSLayoutConstraint] {
    lhs.anchor.constraint(greaterThanOrEqualToConstant: rhs)
}

public func <=<A: DimensionAnchorPair>(lhs: LayoutBlock<A>, rhs: CGFloat) -> [NSLayoutConstraint] {
    lhs.anchor.constraint(lessThanOrEqualToConstant: rhs)
}


public func ==<A: DimensionAnchorPair>(lhs: LayoutBlock<A>, rhs: CGSize) -> [NSLayoutConstraint] {
    [
        lhs.anchor.anchor1.constraint(equalToConstant: rhs.width),
        lhs.anchor.anchor2.constraint(equalToConstant: rhs.height)
    ]
}

public func >=<A: DimensionAnchorPair>(lhs: LayoutBlock<A>, rhs: CGSize) -> [NSLayoutConstraint] {
    [
        lhs.anchor.anchor1.constraint(greaterThanOrEqualToConstant: rhs.width),
        lhs.anchor.anchor2.constraint(greaterThanOrEqualToConstant: rhs.height)
    ]
}

public func <=<A: DimensionAnchorPair>(lhs: LayoutBlock<A>, rhs: CGSize) -> [NSLayoutConstraint] {
    [
        lhs.anchor.anchor1.constraint(lessThanOrEqualToConstant: rhs.width),
        lhs.anchor.anchor2.constraint(lessThanOrEqualToConstant: rhs.height)
    ]
}



//MARK: - Layout Blocks with Layout Blocks

public func ==<A: LayoutAnchor>(lhs: LayoutBlock<A>, rhs: LayoutBlock<A>) -> NSLayoutConstraint {
    lhs.anchor.constraint(equalTo: rhs.anchor, multiplier: rhs.multiplier / lhs.multiplier, constant: rhs.constant - lhs.constant)
}

public func >=<A: LayoutAnchor>(lhs: LayoutBlock<A>, rhs: LayoutBlock<A>) -> NSLayoutConstraint {
    lhs.anchor.constraint(greaterThanOrEqualTo: rhs.anchor, multiplier: rhs.multiplier / lhs.multiplier, constant: rhs.constant - lhs.constant)
}

public func <=<A: LayoutAnchor>(lhs: LayoutBlock<A>, rhs: LayoutBlock<A>) -> NSLayoutConstraint {
    lhs.anchor.constraint(lessThanOrEqualTo: rhs.anchor, multiplier: rhs.multiplier / lhs.multiplier, constant: rhs.constant - lhs.constant)
}

// Anchor Pairs

public func ==<A: LayoutAnchors>(lhs: LayoutBlock<A>, rhs: LayoutBlock<A>) -> [NSLayoutConstraint] {
    lhs.anchor.constraint(equalTo: rhs.anchor, multiplier: rhs.multiplier / lhs.multiplier, constant: rhs.constant - lhs.constant)
}

public func >=<A: LayoutAnchors>(lhs: LayoutBlock<A>, rhs: LayoutBlock<A>) -> [NSLayoutConstraint] {
    lhs.anchor.constraint(greaterThanOrEqualTo: rhs.anchor, multiplier: rhs.multiplier / lhs.multiplier, constant: rhs.constant - lhs.constant)
}

public func <=<A: LayoutAnchors>(lhs: LayoutBlock<A>, rhs: LayoutBlock<A>) -> [NSLayoutConstraint] {
    lhs.anchor.constraint(lessThanOrEqualTo: rhs.anchor, multiplier: rhs.multiplier / lhs.multiplier, constant: rhs.constant - lhs.constant)
}


//MARK: - Priority


infix operator ~ : AssignmentPrecedence

public func ~(lhs: NSLayoutConstraint, rhs: UILayoutPriority) -> NSLayoutConstraint {
    lhs.priority(rhs)
}

public func ~(lhs: [NSLayoutConstraint], rhs: UILayoutPriority) -> [NSLayoutConstraint] {
    lhs.priority(rhs)
}
