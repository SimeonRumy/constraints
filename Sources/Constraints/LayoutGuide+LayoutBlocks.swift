//
//  LayoutGuide+LayoutBlocks.swift
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

internal typealias LayoutGuide = NSLayoutGuide

#else
import UIKit

internal typealias LayoutGuide = UILayoutGuide

#endif


public extension LayoutGuide {
    
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
    // Combined Anchors
    var size: LayoutBlock<LayoutAnchorPair<Dimension, Dimension>> { LayoutBlock(anchor: LayoutAnchorPair(anchor1: width.anchor, anchor2: height.anchor))}
    var centerXY: LayoutBlock<LayoutAnchorPair<XAxis, YAxis>> { LayoutBlock(anchor: LayoutAnchorPair(anchor1: centerX.anchor, anchor2: centerY.anchor))}
    var horizontalEdges: LayoutBlock<XAxisAnchorPair> {  LayoutBlock(anchor: LayoutAnchorPair(anchor1: leading.anchor,anchor2: trailing.anchor)) }
    var verticalEdges: LayoutBlock<YAxisAnchorPair> {  LayoutBlock(anchor: LayoutAnchorPair(anchor1: top.anchor, anchor2: bottom.anchor)) }
    var edges: LayoutBlock<EdgeAnchors> { LayoutBlock(anchor: EdgeAnchors( xAxis: horizontalEdges.anchor, yAxis: verticalEdges.anchor)) }
    
}

