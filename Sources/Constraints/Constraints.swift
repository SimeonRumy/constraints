//
//  Constraints.swift
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

@resultBuilder
public struct ConstraintsBuilder {
    
    public typealias Expression = NSLayoutConstraint
    public typealias Component = [NSLayoutConstraint]
    
    
    // Given an expression result, "lift" it into a Component.
    static func buildExpression(_ expression: Expression?) -> Component {
        if let expression {
            return [expression]
        }
        return []
    }
    
    static func buildExpression(_ expression: Component) -> Component {
        return expression
    }
    
    // Build a combined result from a list of partial results by concatenating.
    static func buildBlock(_ children: Component...) -> Component {
        return children.flatMap { $0 }
    }
    
    // We can provide this overload as a micro-optimization for the common case
    // where there's only one partial result in a block.  This shows the flexibility
    // of using an ad-hoc builder pattern.
    static func buildBlock(_ component: Component) -> Component {
        return component
    }
    
    // Handle optionality by turning nil into the empty list.
    static func buildOptional(_ children: Component?) -> Component {
        return children ?? []
    }
    
    // Handle optionally-executed blocks.
    static func buildEither(first child: Component) -> Component {
        return child
    }
    
    // Handle optionally-executed blocks.
    static func buildEither(second child: Component) -> Component {
        return child
    }
    
}

public func Constraints(@ConstraintsBuilder _ content: () -> ConstraintsBuilder.Component) -> ConstraintsBuilder.Component {
    content()
}

