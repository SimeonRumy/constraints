//
//  CustomOperatorTests.swift
//  
//
//  Created by Simeon Rumyannikov on 12/11/2022.
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

import XCTest
import Constraints

#if os(macOS)
import Cocoa

internal typealias View = NSView
internal typealias LayoutGuide = NSLayoutGuide

#else
import UIKit

internal typealias View = UIView
internal typealias LayoutGuide = UILayoutGuide

#endif



final class CustomOperatorTests: XCTestCase {
    
    let view1 = View(frame: CGRect.zero)
    let view2 = View(frame: CGRect.zero)

    //MARK: - Layout Block to Layout Block
    
    func test_Equal() {
        let constraint = view1.left == view2.right
        XCTAssertEqual(constraint.firstItem as! View, view1)
        XCTAssertEqual(constraint.secondItem as! View, view2)
        XCTAssertEqual(constraint.relation, NSLayoutConstraint.Relation.equal)
    }
    
    func test_GreaterThanOrEqual() {
        let constraint = view1.left >= view2.right
        XCTAssertEqual(constraint.firstItem as? View, view1)
        XCTAssertEqual(constraint.secondItem as? View, view2)
        XCTAssertEqual(constraint.relation, NSLayoutConstraint.Relation.greaterThanOrEqual)
    }
    
    func test_LessThanOrEqual() {
        let constraint = view1.left <= view2.right
        XCTAssertEqual(constraint.firstItem as? View, view1)
        XCTAssertEqual(constraint.secondItem as? View, view2)
        XCTAssertEqual(constraint.relation, NSLayoutConstraint.Relation.lessThanOrEqual)
    }
    
    //MARK: - Layout Block to Fixed Dimension
    
    func test_Equal_FixedDimension() {
        let constraint = view1.width == 200
        XCTAssertEqual(constraint.firstItem as! View, view1)
        XCTAssertEqual(constraint.relation, NSLayoutConstraint.Relation.equal)
    }
    
    func test_GreaterThanOrEqual_FixedDimension() {
        let constraint = view1.width >= 200
        XCTAssertEqual(constraint.firstItem as? View, view1)
        XCTAssertEqual(constraint.relation, NSLayoutConstraint.Relation.greaterThanOrEqual)
    }
    
    func test_LessThanOrEqual_FixedDimension() {
        let constraint = view1.width <= 200
        XCTAssertEqual(constraint.firstItem as? View, view1)
        XCTAssertEqual(constraint.relation, NSLayoutConstraint.Relation.lessThanOrEqual)
    }
    
    //MARK: - Combined Anchors
    
    
    func test_SizeEqual() {
        let constraints = view1.size == view2.size
        XCTAssertEqual(constraints.count, 2)
        XCTAssertEqual(constraints[0].firstItem as? View, constraints[1].firstItem as? View)
        XCTAssertEqual(constraints[0].secondItem as? View, constraints[1].secondItem as? View)
        XCTAssertEqual(constraints[0].firstAttribute, .height)
        XCTAssertEqual(constraints[1].firstAttribute, .width)
        XCTAssertTrue(constraints.allSatisfy { $0.relation == .equal})
        
    }
    
    func test_SizeGreaterThanOrEqual() {
        let constraints = view1.size >= view2.size
        XCTAssertEqual(constraints.count, 2)
        XCTAssertEqual(constraints[0].firstItem as? View, constraints[1].firstItem as? View)
        XCTAssertEqual(constraints[0].secondItem as? View, constraints[1].secondItem as? View)
        XCTAssertEqual(constraints[0].firstAttribute, .height)
        XCTAssertEqual(constraints[1].firstAttribute, .width)
        XCTAssertTrue(constraints.allSatisfy { $0.relation == .greaterThanOrEqual})
        
    }
    
    func test_SizeLessThanOrEqual() {
        let constraints = view1.size <= view2.size
        XCTAssertEqual(constraints.count, 2)
        XCTAssertEqual(constraints[0].firstItem as? View, constraints[1].firstItem as? View)
        XCTAssertEqual(constraints[0].secondItem as? View, constraints[1].secondItem as? View)
        XCTAssertEqual(constraints[0].firstAttribute, .height)
        XCTAssertEqual(constraints[1].firstAttribute, .width)
        XCTAssertTrue(constraints.allSatisfy { $0.relation == .lessThanOrEqual})
        
    }
    
    func test_CenterEqual() {
        let constraints = view1.centerXY == view2.centerXY
        XCTAssertEqual(constraints.count, 2)
        XCTAssertEqual(constraints[0].firstItem as? View, constraints[1].firstItem as? View)
        XCTAssertEqual(constraints[0].secondItem as? View, constraints[1].secondItem as? View)
        XCTAssertEqual(constraints[0].firstAttribute, .centerY)
        XCTAssertEqual(constraints[1].firstAttribute, .centerX)
        XCTAssertTrue(constraints.allSatisfy { $0.relation == .equal})
        
    }
    
    func test_CenterGreaterThanOrEqual() {
        let constraints = view1.centerXY >= view2.centerXY
        XCTAssertEqual(constraints.count, 2)
        XCTAssertEqual(constraints[0].firstItem as? View, constraints[1].firstItem as? View)
        XCTAssertEqual(constraints[0].secondItem as? View, constraints[1].secondItem as? View)
        XCTAssertEqual(constraints[0].firstAttribute, .centerY)
        XCTAssertEqual(constraints[1].firstAttribute, .centerX)
        XCTAssertTrue(constraints.allSatisfy { $0.relation == .greaterThanOrEqual})
        
    }
    
    func test_CenterThanOrEqual() {
        let constraints = view1.centerXY <= view2.centerXY
        XCTAssertEqual(constraints.count, 2)
        XCTAssertEqual(constraints[0].firstItem as? View, constraints[1].firstItem as? View)
        XCTAssertEqual(constraints[0].secondItem as? View, constraints[1].secondItem as? View)
        XCTAssertEqual(constraints[0].firstAttribute, .centerY)
        XCTAssertEqual(constraints[1].firstAttribute, .centerX)
        XCTAssertTrue(constraints.allSatisfy { $0.relation == .lessThanOrEqual})
    }
    
    func test_HorizontalAnchors_Equal() {
        let constraints = view1.horizontalEdges == view2.horizontalEdges
        XCTAssertEqual(constraints.count, 2)
        XCTAssertEqual(constraints[0].firstItem as? View, constraints[1].firstItem as? View)
        XCTAssertEqual(constraints[0].secondItem as? View, constraints[1].secondItem as? View)
        XCTAssertEqual(constraints[0].firstAttribute, .trailing)
        XCTAssertEqual(constraints[1].firstAttribute, .leading)
        XCTAssertTrue(constraints.allSatisfy { $0.relation == .equal})
    }
    
    func test_HorizontalAnchors_GreaterThanOrEqual() {
        let constraints = view1.horizontalEdges >= view2.horizontalEdges
        XCTAssertEqual(constraints.count, 2)
        XCTAssertEqual(constraints[0].firstItem as? View, constraints[1].firstItem as? View)
        XCTAssertEqual(constraints[0].secondItem as? View, constraints[1].secondItem as? View)
        XCTAssertEqual(constraints[0].firstAttribute, .trailing)
        XCTAssertEqual(constraints[1].firstAttribute, .leading)
        XCTAssertTrue(constraints.allSatisfy { $0.relation == .greaterThanOrEqual})
    }
    
    func test_HorizontalAnchors_LessThanOrEqual() {
        let constraints = view1.horizontalEdges <= view2.horizontalEdges
        XCTAssertEqual(constraints.count, 2)
        XCTAssertEqual(constraints[0].firstItem as? View, constraints[1].firstItem as? View)
        XCTAssertEqual(constraints[0].secondItem as? View, constraints[1].secondItem as? View)
        XCTAssertEqual(constraints[0].firstAttribute, .trailing)
        XCTAssertEqual(constraints[1].firstAttribute, .leading)
        XCTAssertTrue(constraints.allSatisfy { $0.relation == .lessThanOrEqual})
    }
    
    func test_VerticalAnchors_Equal() {
        let constraints = view1.verticalEdges == view2.verticalEdges
        XCTAssertEqual(constraints.count, 2)
        XCTAssertEqual(constraints[0].firstItem as? View, constraints[1].firstItem as? View)
        XCTAssertEqual(constraints[0].secondItem as? View, constraints[1].secondItem as? View)
        XCTAssertEqual(constraints[0].firstAttribute, .top)
        XCTAssertEqual(constraints[1].firstAttribute, .bottom)
        XCTAssertTrue(constraints.allSatisfy { $0.relation == .equal})
    }
    
    func test_VerticalAnchors_GreaterThanOrEqual() {
        let constraints = view1.verticalEdges >= view2.verticalEdges
        XCTAssertEqual(constraints.count, 2)
        XCTAssertEqual(constraints[0].firstItem as? View, constraints[1].firstItem as? View)
        XCTAssertEqual(constraints[0].secondItem as? View, constraints[1].secondItem as? View)
        XCTAssertEqual(constraints[0].firstAttribute, .top)
        XCTAssertEqual(constraints[1].firstAttribute, .bottom)
        XCTAssertTrue(constraints.allSatisfy { $0.relation == .greaterThanOrEqual})
    }
    
    func test_VerticalAnchors_LessThanOrEqual() {
        let constraints = view1.verticalEdges <= view2.verticalEdges
        XCTAssertEqual(constraints.count, 2)
        XCTAssertEqual(constraints[0].firstItem as? View, constraints[1].firstItem as? View)
        XCTAssertEqual(constraints[0].secondItem as? View, constraints[1].secondItem as? View)
        XCTAssertEqual(constraints[0].firstAttribute, .top)
        XCTAssertEqual(constraints[1].firstAttribute, .bottom)
        XCTAssertTrue(constraints.allSatisfy { $0.relation == .lessThanOrEqual})
    }
    
    //MARK: - Combined Anchors with Fixed Dimension

    
    func test_SizeEqual_FixedDimension_Square() {
        let constraints = view1.size == 200
        XCTAssertEqual(constraints.count, 2)
        XCTAssertEqual(constraints[0].firstItem as? View, constraints[1].firstItem as? View)
        XCTAssertEqual(constraints[0].constant, 200)
        XCTAssertEqual(constraints[1].constant, 200)
        XCTAssertEqual(constraints[0].firstAttribute, .width)
        XCTAssertEqual(constraints[1].firstAttribute, .height)
        XCTAssertTrue(constraints.allSatisfy { $0.relation == .equal})
        
    }
    
    func test_SizeLessThanOrEqual_FixedDimension_Square() {
        let constraints = view1.size <= 200
        XCTAssertEqual(constraints.count, 2)
        XCTAssertEqual(constraints[0].firstItem as? View, constraints[1].firstItem as? View)
        XCTAssertEqual(constraints[0].constant, 200)
        XCTAssertEqual(constraints[1].constant, 200)
        XCTAssertEqual(constraints[0].firstAttribute, .width)
        XCTAssertEqual(constraints[1].firstAttribute, .height)
        XCTAssertTrue(constraints.allSatisfy { $0.relation == .lessThanOrEqual})
        
    }
    
    func test_SizeGreaterThanOrEqual_FixedDimension_Square() {
        let constraints = view1.size >= 200
        XCTAssertEqual(constraints.count, 2)
        XCTAssertEqual(constraints[0].firstItem as? View, constraints[1].firstItem as? View)
        XCTAssertEqual(constraints[0].constant, 200)
        XCTAssertEqual(constraints[1].constant, 200)
        XCTAssertEqual(constraints[0].firstAttribute, .width)
        XCTAssertEqual(constraints[1].firstAttribute, .height)
        XCTAssertTrue(constraints.allSatisfy { $0.relation == .greaterThanOrEqual})
        
    }
    
    func test_SizeEqual_FixedDimension_Rect() {
        let constraints = view1.size == CGSize(width: 200, height: 100)
        XCTAssertEqual(constraints.count, 2)
        XCTAssertEqual(constraints[0].firstItem as? View, constraints[1].firstItem as? View)
        XCTAssertEqual(constraints[0].constant, 200)
        XCTAssertEqual(constraints[1].constant, 100)
        XCTAssertEqual(constraints[0].firstAttribute, .width)
        XCTAssertEqual(constraints[1].firstAttribute, .height)
        XCTAssertTrue(constraints.allSatisfy { $0.relation == .equal})
    }
    
    func test_SizeLessThanOrEqual_FixedDimension_Rect() {
        let constraints = view1.size <= CGSize(width: 200, height: 100)
        XCTAssertEqual(constraints.count, 2)
        XCTAssertEqual(constraints[0].firstItem as? View, constraints[1].firstItem as? View)
        XCTAssertEqual(constraints[0].constant, 200)
        XCTAssertEqual(constraints[1].constant, 100)
        XCTAssertEqual(constraints[0].firstAttribute, .width)
        XCTAssertEqual(constraints[1].firstAttribute, .height)
        XCTAssertTrue(constraints.allSatisfy { $0.relation == .lessThanOrEqual})
        
    }
    
    func test_SizeGreaterThanOrEqual_FixedDimension_Rect() {
        let constraints = view1.size >= CGSize(width: 200, height: 100)
        XCTAssertEqual(constraints.count, 2)
        XCTAssertEqual(constraints[0].firstItem as? View, constraints[1].firstItem as? View)
        XCTAssertEqual(constraints[0].constant, 200)
        XCTAssertEqual(constraints[1].constant, 100)
        XCTAssertEqual(constraints[0].firstAttribute, .width)
        XCTAssertEqual(constraints[1].firstAttribute, .height)
        XCTAssertTrue(constraints.allSatisfy { $0.relation == .greaterThanOrEqual})
    }
        
    //MARK: - 4D Anchors - Edge
    
    func test_Equal_EdgeAnchor() {
        let constraints = view1.edges == view2.edges
        
        XCTAssertEqual(constraints.count, 4)
        XCTAssertTrue(constraints.allSatisfy { $0.relation == NSLayoutConstraint.Relation.equal })
        XCTAssertTrue(constraints.allSatisfy { $0.firstItem as? View == view1 })
        XCTAssertTrue(constraints.allSatisfy { $0.secondItem as? View == view2 })
    }
    
    
    func test_GreaterThanOrEqual_EdgeAnchors() {
        let constraints = view1.edges >= view2.edges
        
        XCTAssertEqual(constraints.count, 4)
        XCTAssertTrue(constraints.allSatisfy { $0.relation == NSLayoutConstraint.Relation.greaterThanOrEqual })
        XCTAssertTrue(constraints.allSatisfy { $0.firstItem as? View == view1 })
        XCTAssertTrue(constraints.allSatisfy { $0.secondItem as? View == view2 })
    }
    
    func test_LessThanOrEqual_EdgeAnchors() {
        let constraints = view1.edges <= view2.edges
        
        XCTAssertEqual(constraints.count, 4)
        XCTAssertTrue(constraints.allSatisfy { $0.relation == NSLayoutConstraint.Relation.lessThanOrEqual })
        XCTAssertTrue(constraints.allSatisfy { $0.firstItem as? View == view1 })
        XCTAssertTrue(constraints.allSatisfy { $0.secondItem as? View == view2 })
    }
        
    //MARK: - Add + Sub
    
    func test_AdditionRHS() {
        let constraint = view1.left == view2.right + 10.0
        XCTAssertEqual(constraint.constant, 10.0)
    }
    
    func test_AdditionLHS() {
        let constraint = view1.left + 10 == view2.right
        XCTAssertEqual(constraint.constant, -10.0)
    }
    
    func test_SubtractionRHS() {
        let constraint = view1.left == view2.right - 10.0
        XCTAssertEqual(constraint.constant, -10.0)
    }
    
    func test_SubtractionLHS() {
        let constraint = view1.left - 10 == view2.right
        XCTAssertEqual(constraint.constant, 10.0)
    }
    
    func test_MultipleAdditionRHS() {
        let constraint = view1.left == view2.right + 10.0 + 10.0
        XCTAssertEqual(constraint.constant, 20.0)
    }
    
    func test_MultipleAdditionLHS() {
        let constraint = view1.left + 10.0 + 10.0 == view2.right
        XCTAssertEqual(constraint.constant, -20.0)
    }
    
    func test_MultipleSubtractionRHS() {
        let constraint = view1.left == view2.right - 10.0 - 10.0
        XCTAssertEqual(constraint.constant, -20.0)
    }
    
    func test_MultipleSubtractionLHS() {
        let constraint = view1.left - 10.0 - 10.0 == view2.right
        XCTAssertEqual(constraint.constant, 20.0)
    }
    
    // Reverse Arguments
    
    func test_AdditionRHS_Reverse() {
        let constraint = view1.left == 10.0 + view2.right
        XCTAssertEqual(constraint.constant, 10.0)
    }
    
    func test_AdditionLHS_Reverse() {
        let constraint = 10 + view1.left == view2.right
        XCTAssertEqual(constraint.constant, -10.0)
    }
    
    func test_SubtractionRHS_Reverse() {
        let constraint = view1.left == -10.0 + view2.right
        XCTAssertEqual(constraint.constant, -10.0)
    }
    
    func test_SubtractionLHS_Reverse() {
        let constraint = -10 + view1.left == view2.right
        XCTAssertEqual(constraint.constant, 10.0)
    }
    
    func test_MultipleAdditionRHS_Reverse() {
        let constraint = view1.left == 10.0 + 10.0 + view2.right
        XCTAssertEqual(constraint.constant, 20.0)
    }
    
    func test_MultipleAdditionLHS_Reverse() {
        let constraint = view1.left + 10.0 + 10.0 == view2.right
        XCTAssertEqual(constraint.constant, -20.0)
    }
    
    func test_MultipleSubtractionRHS_Reverse() {
        let constraint = view1.left == -10.0 - 10.0 + view2.right
        XCTAssertEqual(constraint.constant, -20.0)
    }
    
    func test_MultipleSubtractionLHS_Reverse() {
        let constraint = -10.0 - 10.0  + view1.left == view2.right
        XCTAssertEqual(constraint.constant, 20.0)
    }
    
    //MARK: - Multiplication + Division
    
    func test_MultiplicationRHS() {
        let constraint = view1.width == view2.width * 2.0
        XCTAssertEqual(constraint.multiplier, 2.0)
    }
    
    func test_MultiplicationLHS() {
        let constraint = view1.width * 2.0 == view2.width
        XCTAssertEqual(constraint.multiplier, 1/2.0)
    }
    
    func test_DivisionRHS() {
        let constraint = view1.height == view2.height / 2.0
        XCTAssertEqual(constraint.multiplier, 0.5)
    }
    
    func test_DivisionLHS() {
        let constraint = view1.width / 2.0 == view2.width
        XCTAssertEqual(constraint.multiplier, 2.0)
    }
    
    func test_Multiple_MultiplicationRHS() {
        let constraint = view1.width == view2.width * 2.0 * 2.0
        XCTAssertEqual(constraint.multiplier, 4.0)
    }
    
    func test_Multiple_MultiplicationLHS() {
        let constraint = view1.width * 2.0 * 2.0 == view2.width
        XCTAssertEqual(constraint.multiplier, 1/4.0)
    }
    
    func test_Multiple_DivisionRHS() {
        let constraint = view1.height == view2.height / 2.0 / 2.0
        XCTAssertEqual(constraint.multiplier, 0.25)
    }
    
    func test_Multiple_DivisionLHS() {
        let constraint = view1.width / 2.0 / 2.0 == view2.width
        XCTAssertEqual(constraint.multiplier, 4.0)
    }
    
    // Reverse Arguments
    
    func test_MultiplicationRHS_Reverse() {
        let constraint = view1.width ==  2.0 * view2.width
        XCTAssertEqual(constraint.multiplier, 2.0)
    }
    
    func test_MultiplicationLHS_Reverse() {
        let constraint = 2.0 * view1.width == view2.width
        XCTAssertEqual(constraint.multiplier, 1/2.0)
    }
    
    // unlike multiplication, addition or subtraction,  reversing division actually makes a difference
    
    func test_DivisionRHS_Reverse() {
        let constraint = view1.height == 2.0 / view2.height
        XCTAssertEqual(constraint.multiplier, 2.0)
    }
    func test_DivisionRHS_Reverse_Complex() {
        let constraint = view1.height == 2.0 / view2.height * 2
        XCTAssertEqual(constraint.multiplier, 4.0)
    }
    
    func test_DivisionLHS_Reverse() {
        let constraint = 2.0 / view1.leading == view2.trailing
        XCTAssertEqual(constraint.multiplier, 0.5)
    }
    
    func test_Multiple_MultiplicationRHS_Reverse() {
        let constraint = view1.width == 2.0 * 2.0 * view2.width
        XCTAssertEqual(constraint.multiplier, 4.0)
    }
    
    func test_Multiple_MultiplicationLHS_Reverse() {
        let constraint = 2.0 * 2.0 * view1.top == view2.bottom
        XCTAssertEqual(constraint.multiplier, 1/4.0)
    }
    
    func test_Multiple_DivisionRHS_Reverse() {
        let constraint = view1.height == 2.0 / 2.0 / view2.height
        XCTAssertEqual(constraint.multiplier, 1)
    }
    
    func test_Multiple_DivisionLHS_Reverse() {
        let constraint = 2.0 / 2.0 / view1.width == view2.width
        XCTAssertEqual(constraint.multiplier, 1)
    }
    
    //MARK: - Test Complex Expressions
    
    // order of operations with brackets is not honoured
    func test_divisionWithBrackets() {
        let constraint = view2.width == (view1.width + 150) / 2
        XCTAssertEqual(constraint.constant, 150)
        XCTAssertEqual(constraint.multiplier, 0.5)
    }
    
    //MARK: - Combined Anchors with Insets
    
    func test_VerticalEdgeAnchors_constant() {
        let constraints = view1.verticalEdges == view2.verticalEdges + 10
        XCTAssertTrue(constraints.allSatisfy { $0.constant == 10 })
    }
    
    func test_VerticalEdgeAnchors_equalPositiveInsets() {
        let constraints = view1.verticalEdges == view2.verticalEdges + UIEdgeInsets(top: 10, bottom: 10)
        XCTAssertTrue(constraints[0].constant == -10)
        XCTAssertTrue(constraints[1].constant == 10)
    }
    
    func test_VerticalEdgeAnchors_equalNegativeInsets() {
        let constraints = view1.verticalEdges == view2.verticalEdges - UIEdgeInsets(top: 10, bottom: 10)
        XCTAssertTrue(constraints[0].constant == 10)
        XCTAssertTrue(constraints[1].constant == -10)
    }
    
    func test_VerticalEdgeAnchors_differentInsets() {
        let constraints = view1.verticalEdges == view2.verticalEdges + UIEdgeInsets(top: 100, bottom: 10)
        XCTAssertEqual(constraints[0].firstAttribute, .top)
        XCTAssertEqual(constraints[0].constant, -100)
        XCTAssertEqual(constraints[1].firstAttribute, .bottom)
        XCTAssertEqual(constraints[1].constant, 10)
    }
    
    func test_VerticalEdgeAnchors_differentInsets_inccorectInsetLabel() {
        let constraints = view1.verticalEdges == view2.verticalEdges + UIEdgeInsets(left: 200, right: 10)
        XCTAssertEqual(constraints[0].firstAttribute, .top)
        XCTAssertEqual(constraints[0].constant, 0)
        XCTAssertEqual(constraints[1].firstAttribute, .bottom)
        XCTAssertEqual(constraints[1].constant, 0)
    }
    
    func test_HorizontalEdgeAnchors_constant() {
        let constraints = view1.horizontalEdges == view2.horizontalEdges + 10
        XCTAssertTrue(constraints.allSatisfy { $0.constant == 10 })
    }
    
    func test_HorizontallEdgeAnchors_insets() {
        let constraints = view1.horizontalEdges == view2.horizontalEdges + UIEdgeInsets(left: 10, right: 10)
        XCTAssertTrue(constraints[0].constant == 10)
        XCTAssertTrue(constraints[1].constant == -10)
    }
    
    func test_HorizontalEdgeAnchors_equalNegativeInsets() {
        let constraints = view1.horizontalEdges == view2.horizontalEdges - UIEdgeInsets(left: 10, right: 10)
        XCTAssertTrue(constraints[0].constant == -10)
        XCTAssertTrue(constraints[1].constant == 10)
    }
    
    func test_HorizontalEdgeAnchors_differentInsets() {
        let constraints = view1.horizontalEdges == view2.horizontalEdges + UIEdgeInsets(left: 100, right: 10)
        XCTAssertEqual(constraints[0].firstAttribute, .trailing)
        XCTAssertEqual(constraints[0].constant, 10)
        XCTAssertEqual(constraints[1].firstAttribute, .leading)
        XCTAssertEqual(constraints[1].constant, -100)
    }
    
    func test_HorizontalEdgeAnchors_differentInsets_inccorectInsetLabel() {
        let constraints = view1.horizontalEdges == view2.horizontalEdges + UIEdgeInsets(top: 100, bottom: 10)
        XCTAssertEqual(constraints[0].firstAttribute, .trailing)
        XCTAssertEqual(constraints[0].constant, 0)
        XCTAssertEqual(constraints[1].firstAttribute, .leading)
        XCTAssertEqual(constraints[1].constant, 0)
    }
    
    func test_EdgeAnchors_constant() {
        let constraints = view1.edges == view2.edges + 10
        XCTAssertTrue(constraints.allSatisfy { $0.constant == 10 })
    }
    
    
    func test_EdgeAnchors_Addition_equalInsets() {
        let constraints = view1.edges == view2.edges + UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        XCTAssertTrue(constraints[0].constant == 10)
        XCTAssertTrue(constraints[1].constant == -10)
        XCTAssertTrue(constraints[2].constant == -10)
        XCTAssertTrue(constraints[3].constant == 10)
    }
    
    func test_EdgeAnchors_Subtraction_equalInsets() {
        let constraints = view1.edges == view2.edges - UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        XCTAssertTrue(constraints[0].constant == -10)
        XCTAssertTrue(constraints[1].constant == 10)
        XCTAssertTrue(constraints[2].constant == 10)
        XCTAssertTrue(constraints[3].constant == -10)
    }
    
    func test_EdgeAnchors_Addition_differentInsets() {
        let constraints = view1.edges == view2.edges + UIEdgeInsets(top: 5, left: 10, bottom: 20, right: 30)
        XCTAssertTrue(constraints[0].firstAttribute == .trailing)
        XCTAssertTrue(constraints[1].firstAttribute == .leading)
        XCTAssertTrue(constraints[2].firstAttribute == .top)
        XCTAssertTrue(constraints[3].firstAttribute == .bottom)
        
        XCTAssertTrue(constraints[0].constant == 30)
        XCTAssertTrue(constraints[1].constant == -10)
        XCTAssertTrue(constraints[2].constant == -5)
        XCTAssertTrue(constraints[3].constant == 20)
    }
  
    func test_EdgeAnchors_Subtraction_differentInsets() {
        let constraints = view1.edges == view2.edges - UIEdgeInsets(top: 5, left: 10, bottom: 20, right: 30)
        XCTAssertTrue(constraints[0].firstAttribute == .trailing)
        XCTAssertTrue(constraints[1].firstAttribute == .leading)
        XCTAssertTrue(constraints[2].firstAttribute == .top)
        XCTAssertTrue(constraints[3].firstAttribute == .bottom)
        
        XCTAssertTrue(constraints[0].constant == -30)
        XCTAssertTrue(constraints[1].constant == 10)
        XCTAssertTrue(constraints[2].constant == 5)
        XCTAssertTrue(constraints[3].constant == -20)
    }

    
    //MARK: - Priority Operator
    
    func test_prorityOperator_required() {
        let constraint = 2.0 / 2.0 / view1.width == view2.width  ~ .required
        XCTAssertEqual(constraint.priority, .required)
    }
    
    func test_prorityOperator_custom() {
        let constraint = 2.0 / 2.0 / view1.width == view2.width  ~ .priority(404)
        XCTAssertEqual(constraint.priority.rawValue, 404)
    }
    
    func test_priority_array() {
        let constraints = Constraints {
            view1.top == view2.top + 20
            view1.bottom == view2.bottom + 20
            view1.leading == view2.leading + 20
            view1.trailing == view2.trailing + 20
        } ~ .almostRequired
        
        XCTAssertTrue(constraints.allSatisfy { $0.priority == .almostRequired })
    }
    

    
    //MARK: - Full Constraints Tests
    
    func test_FillSuperview() {
        let constraints = Constraints {
            view1.top == view2.top + 20 ~ .required
            view1.bottom == view2.bottom + 20 ~ .priority(500)
            view1.leading == view2.leading + 20 ~ .priority(100)
            view1.trailing == view2.trailing + 20 ~ .almostRequired
        }
        
        let constraints_matched = [
            view1.topAnchor.constraint(equalTo: view2.topAnchor, constant: 20).priority(.required),
            view1.bottomAnchor.constraint(equalTo: view2.bottomAnchor, constant: 20).priority(500),
            view1.leadingAnchor.constraint(equalTo: view2.leadingAnchor, constant: 20).priority(100),
            view1.trailingAnchor.constraint(equalTo: view2.trailingAnchor, constant: 20).priority(.almostRequired),
        ]
        
        for (constraint, constraint2) in zip(constraints, constraints_matched) {
            XCTAssertEqual(constraint.relation, constraint2.relation)
            XCTAssertEqual(constraint.constant, constraint2.constant)
            XCTAssertEqual(constraint.multiplier, constraint2.multiplier)
            XCTAssertEqual(constraint.firstItem as? View, constraint2.firstItem as? View)
            XCTAssertEqual(constraint.secondItem as? View, constraint2.secondItem as? View)
            XCTAssertEqual(constraint.priority.rawValue, constraint2.priority.rawValue)
        }
    }
    
    func test_ScaleSize() {
        let constraints = Constraints {
            view1.height <= view2.height * 2
            view1.width <= view2.width * 2
            view1.height >= view2.height * 2
            view1.width >= view2.width * 2
        }
        
        let constraints_matched = [
            view1.heightAnchor.constraint(lessThanOrEqualTo: view2.heightAnchor, multiplier: 2),
            view1.widthAnchor.constraint(lessThanOrEqualTo: view2.widthAnchor, multiplier: 2),
            view1.heightAnchor.constraint(greaterThanOrEqualTo: view2.heightAnchor, multiplier: 2),
            view1.widthAnchor.constraint(greaterThanOrEqualTo: view2.widthAnchor, multiplier: 2),
        ]
        
        for (constraint, constraint2) in zip(constraints, constraints_matched) {
            XCTAssertEqual(constraint.relation, constraint2.relation)
            XCTAssertEqual(constraint.constant, constraint2.constant)
            XCTAssertEqual(constraint.multiplier, constraint2.multiplier)
            XCTAssertEqual(constraint.firstItem as? View, constraint2.firstItem as? View)
            XCTAssertEqual(constraint.secondItem as? View, constraint2.secondItem as? View)
        }
    }



}


