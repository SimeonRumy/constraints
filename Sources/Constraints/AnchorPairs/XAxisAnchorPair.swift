//
//  XAxisAnchorPair.swift
//  
//
//  Created by Simeon Rumyannikov on 16/11/2022.
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


public struct XAxisAnchorPair: LayoutAnchorPair {
    
    public typealias Insets = HorizontalInsetPair
    
    public struct HorizontalInsetPair: EdgeInsetPair {
        
        let right: CGFloat
        let left: CGFloat
        
        public var constant1: CGFloat {
            return right
        }
        
        public var constant2: CGFloat {
            return -left
        }
        
    }
    
    public var anchor1: XAxis {
        self.trailing
    }
    
    public var anchor2: XAxis {
        self.leading
    }
    
    var leading: XAxis
    var trailing: XAxis
    
    init(leading: XAxis, trailing: XAxis) {
        self.leading = leading
        self.trailing = trailing
    }
}
