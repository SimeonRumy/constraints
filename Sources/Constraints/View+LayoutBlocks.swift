//
//  View+LayoutBlocks.swift
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


#if os(macOS)
import Cocoa

internal typealias View = NSView

#else
import UIKit

internal typealias View = UIView

#endif


public extension View {
    
    var leading: LayoutBlock<XAxis> { LayoutBlock(anchor: self.leadingAnchor) }
    var trailing: LayoutBlock<XAxis> { LayoutBlock(anchor: self.trailingAnchor) }
    var left: LayoutBlock<XAxis> { LayoutBlock(anchor: self.leftAnchor) }
    var right: LayoutBlock<XAxis> { LayoutBlock(anchor: self.rightAnchor) }
    var top: LayoutBlock<YAxis> { LayoutBlock(anchor: self.topAnchor) }
    var bottom: LayoutBlock<YAxis> { LayoutBlock(anchor: self.bottomAnchor) }
    var width: LayoutBlock<Dimension> { LayoutBlock(anchor: self.widthAnchor) }
    var height: LayoutBlock<Dimension> { LayoutBlock(anchor: self.heightAnchor) }
    var centerX: LayoutBlock<XAxis> { LayoutBlock(anchor: self.centerXAnchor) }
    var centerY: LayoutBlock<YAxis> { LayoutBlock(anchor: self.centerYAnchor) }
    var baseline: LayoutBlock<YAxis> { LayoutBlock(anchor: self.lastBaselineAnchor) }
    var size: LayoutBlock<AnchorPair<Dimension, Dimension>> { LayoutBlock(anchor: AnchorPair(anchor1: self.widthAnchor, anchor2: self.heightAnchor))}
    var centerXY: LayoutBlock<AnchorPair<XAxis, YAxis>> { LayoutBlock(anchor: AnchorPair(anchor1: self.centerXAnchor, anchor2: self.centerYAnchor))}
    
    @available(iOS 8.0, OSX 10.11, *)
    var firstBaseline: LayoutBlock<YAxis> { LayoutBlock(anchor: self.firstBaselineAnchor) }
    var lastBaseline: LayoutBlock<YAxis> { LayoutBlock(anchor: self.lastBaselineAnchor) }
}



