////
////  File.swift
////
////
////  Created by Simeon Rumyannikov on 10/11/2022.
////
//
//import Foundation
//import UIKit
//
//
///// Wraps shared methods of NSLayoutAnchors
//public protocol LayoutAnchor {
//    
//    func constraint(equalTo anchor: Self,constant: CGFloat) -> NSLayoutConstraint
//    func constraint(greaterThanOrEqualTo anchor: Self, constant: CGFloat) -> NSLayoutConstraint
//    func constraint(lessThanOrEqualTo anchor: Self,constant: CGFloat) -> NSLayoutConstraint
//}
//
//extension LayoutAnchor {
//    func constraint(equalTo anchor: Self, multiplier: CGFloat, constant: CGFloat) -> NSLayoutConstraint {
//        self.constraint(equalTo: anchor, constant: constant).multiply(multiplier)
//    }
//
//    func constraint(greaterThanOrEqualTo anchor: Self, multiplier: CGFloat, constant: CGFloat) -> NSLayoutConstraint {
//        self.constraint(greaterThanOrEqualTo: anchor, constant: constant).multiply(multiplier)
//    }
//
//    func constraint(lessThanOrEqualTo anchor: Self, multiplier: CGFloat, constant: CGFloat) -> NSLayoutConstraint {
//        self.constraint(lessThanOrEqualTo: anchor, constant: constant).multiply(multiplier)
//    }
//}
//
//
//
//public typealias XAxis = NSLayoutXAxisAnchor
//public typealias YAxis = NSLayoutYAxisAnchor
//public typealias Dimension = NSLayoutDimension
//public typealias Axis = NSLayoutXAxisAnchor & NSLayoutYAxisAnchor
//
//extension NSLayoutAnchor: LayoutAnchor {}
//
//
//public struct LayoutBlock<A> {
//    internal let anchors: [A]
//    fileprivate var constant: CGFloat = 0
//    fileprivate var multiplier: CGFloat = 1
//    
//    fileprivate init(anchor: [A]) {
//        self.anchors = anchor
//    }
//    
//    fileprivate init(block: LayoutBlock) {
//        self.anchors = block.anchors
//        self.constant = block.constant
//        self.multiplier = block.multiplier
//    }
//    
//}
//
//
//
////MARK: - Constant Addition
//
//func +<A>(lhs: LayoutBlock<A>, rhs: CGFloat) -> LayoutBlock<A> {
//    var newBlock = LayoutBlock(block: lhs)
//    newBlock.constant = newBlock.constant + rhs
//    return newBlock
//}
//
//
//func -<A>(lhs: LayoutBlock<A>, rhs: CGFloat) -> LayoutBlock<A> {
//    var newBlock = LayoutBlock(block: lhs)
//    newBlock.constant = newBlock.constant - rhs
//    return newBlock
//}
//
//func +<A>(lhs: CGFloat, rhs: LayoutBlock<A>) -> LayoutBlock<A> {
//    return rhs + lhs
//}
//
//// we do not need a inverted function for minue since that is acutally a plus with a negative int
//
////MARK: - Constant Multiplication
//
//func *<A>(lhs: LayoutBlock<A>, rhs: CGFloat) -> LayoutBlock<A> {
//    var newBlock = LayoutBlock(block: lhs)
//    newBlock.multiplier = newBlock.multiplier * rhs
//    return newBlock
//}
//
//func /<A>(lhs: LayoutBlock<A>, rhs: CGFloat) -> LayoutBlock<A> {
//    var newBlock = LayoutBlock(block: lhs)
//    newBlock.multiplier = newBlock.multiplier / rhs
//    return newBlock
//}
//
//
//func *<A>(lhs: CGFloat, rhs: LayoutBlock<A>) -> LayoutBlock<A> {
//    rhs * lhs
//}
//
//func /<A>(lhs: CGFloat, rhs: LayoutBlock<A>) -> LayoutBlock<A> {
//    rhs * lhs
//}
//
////MARK: - Layout Blocks with Constant Dimensions
//
//func ==<A: Dimension>(lhs: LayoutBlock<A>, rhs: CGFloat) -> [NSLayoutConstraint] {
//    lhs.anchors.map { $0.constraint(equalToConstant: rhs) }
//}
//
//func >=<A: Dimension>(lhs: LayoutBlock<A>, rhs: CGFloat) -> [NSLayoutConstraint] {
//    lhs.anchors.map { $0.constraint(greaterThanOrEqualToConstant: rhs) }
//}
//
//func <=<A: Dimension>(lhs: LayoutBlock<A>, rhs: CGFloat) -> [NSLayoutConstraint] {
//    lhs.anchors.map { $0.constraint(lessThanOrEqualToConstant: rhs) }
//}
//
//
////MARK: - Layout Blocks with Layout Blocks
//
//func ==<A: LayoutAnchor>(lhs: LayoutBlock<A>, rhs: LayoutBlock<A>) -> [NSLayoutConstraint] {
//    let anchors = zip(lhs.anchors, rhs.anchors)
//    return anchors.map { $0.constraint(equalTo: $1, multiplier: rhs.multiplier / lhs.multiplier, constant: rhs.constant - lhs.constant) }
//}
//
//func >=<A: LayoutAnchor>(lhs: LayoutBlock<A>, rhs: LayoutBlock<A>) -> [NSLayoutConstraint ]{
//    let anchors = zip(lhs.anchors, rhs.anchors)
//    return anchors.map { $0.constraint(greaterThanOrEqualTo: $1, multiplier: rhs.multiplier / lhs.multiplier, constant: rhs.constant - lhs.constant) }
//}
//
//func <=<A: LayoutAnchor>(lhs: LayoutBlock<A>, rhs: LayoutBlock<A>) -> [NSLayoutConstraint] {
//    let anchors = zip(lhs.anchors, rhs.anchors)
//    return anchors.map { $0.constraint(lessThanOrEqualTo: $1, multiplier: rhs.multiplier / lhs.multiplier, constant: rhs.constant - lhs.constant) }
//}
//
//
//
////MARK: - Extension on views
//
//
//public extension UIView {
//    
//    var leading: LayoutBlock<XAxis> { LayoutBlock(anchor: [self.leadingAnchor]) }
//    var trailing: LayoutBlock<XAxis> { LayoutBlock(anchor: [self.trailingAnchor]) }
//    var left: LayoutBlock<XAxis> { LayoutBlock(anchor: [self.leftAnchor]) }
//    var right: LayoutBlock<XAxis> { LayoutBlock(anchor: [self.rightAnchor]) }
//    var top: LayoutBlock<YAxis> { LayoutBlock(anchor: [self.topAnchor]) }
//    var bottom: LayoutBlock<YAxis> { LayoutBlock(anchor: [self.bottomAnchor]) }
//    var width: LayoutBlock<Dimension> { LayoutBlock(anchor: [self.widthAnchor]) }
//    var height: LayoutBlock<Dimension> { LayoutBlock(anchor: [self.heightAnchor]) }
//    var centerX: LayoutBlock<XAxis> { LayoutBlock(anchor: [self.centerXAnchor]) }
//    var centerY: LayoutBlock<YAxis> { LayoutBlock(anchor: [self.centerYAnchor]) }
//    var baseline: LayoutBlock<YAxis> { LayoutBlock(anchor: [self.lastBaselineAnchor]) }
//    var size: LayoutBlock<Dimension> { LayoutBlock(anchor: [self.heightAnchor, self.widthAnchor])}
//    var centre: LayoutBlock<Axis>
//    @available(iOS 8.0, OSX 10.11, *)
//    var firstBaseline: LayoutBlock<YAxis> { LayoutBlock(anchor: [self.firstBaselineAnchor]) }
//    var lastBaseline: LayoutBlock<YAxis> { LayoutBlock(anchor: [self.lastBaselineAnchor]) }
//}
//
//public extension UILayoutGuide {
//    
//    var leading: LayoutBlock<XAxis> { LayoutBlock(anchor: [self.leadingAnchor]) }
//    var trailing: LayoutBlock<XAxis> { LayoutBlock(anchor: [self.trailingAnchor]) }
//    var left: LayoutBlock<XAxis> { LayoutBlock(anchor: [self.leftAnchor]) }
//    var right: LayoutBlock<XAxis> { LayoutBlock(anchor: [self.rightAnchor]) }
//    var top: LayoutBlock<YAxis> { LayoutBlock(anchor: [self.topAnchor]) }
//    var bottom: LayoutBlock<YAxis> { LayoutBlock(anchor: [self.bottomAnchor]) }
//    var width: LayoutBlock<Dimension> { LayoutBlock(anchor: [self.widthAnchor]) }
//    var height: LayoutBlock<Dimension> { LayoutBlock(anchor: [self.heightAnchor]) }
//    var centerX: LayoutBlock<XAxis> { LayoutBlock(anchor: [self.centerXAnchor]) }
//    var centerY: LayoutBlock<YAxis> { LayoutBlock(anchor: [self.centerYAnchor]) }
//}
//
////MARK: - Priority
//
//
//infix operator ~ : AssignmentPrecedence
//
//public func ~(lhs: NSLayoutConstraint, rhs: UILayoutPriority) -> NSLayoutConstraint {
//    lhs.priority(rhs)
//}
//
//public func ~(lhs: NSLayoutConstraint, rhs: Float) -> NSLayoutConstraint {
//    lhs.priority(UILayoutPriority(rhs))
//}
//
//let view = UIView()
//let view2 = UIView()
//Constraints {
//    view.centre == view2.centre
//}
