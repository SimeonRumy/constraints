//
//  LayoutAnchorTests.swift
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
@testable import Constraints


final class LayoutAnchorTests: XCTestCase {
    
    let view1 = View(frame: CGRect.zero)
    let view2 = View(frame: CGRect.zero)
    
    func test_ViewAnchorValues() {
        XCTAssertEqual(view1.left.anchor, view1.leftAnchor)
        XCTAssertEqual(view1.right.anchor, view1.rightAnchor)
        XCTAssertEqual(view1.top.anchor, view1.topAnchor)
        XCTAssertEqual(view1.bottom.anchor, view1.bottomAnchor)
        XCTAssertEqual(view1.leading.anchor, view1.leadingAnchor)
        XCTAssertEqual(view1.trailing.anchor, view1.trailingAnchor)
        XCTAssertEqual(view1.width.anchor, view1.widthAnchor)
        XCTAssertEqual(view1.height.anchor, view1.heightAnchor)
        XCTAssertEqual(view1.centerX.anchor, view1.centerXAnchor)
        XCTAssertEqual(view1.centerY.anchor, view1.centerYAnchor)
        XCTAssertEqual(view1.firstBaseline.anchor, view1.firstBaselineAnchor)
        XCTAssertEqual(view1.lastBaseline.anchor, view1.lastBaselineAnchor)
        XCTAssertEqual(view1.size.anchor.anchor1, view1.widthAnchor)
        XCTAssertEqual(view1.size.anchor.anchor2, view1.heightAnchor)
        XCTAssertEqual(view1.centerXY.anchor.anchor1, view1.centerXAnchor)
        XCTAssertEqual(view1.centerXY.anchor.anchor2, view1.centerYAnchor)
        XCTAssertEqual(view1.horizontalEdges.anchor.anchor1, view1.leadingAnchor)
        XCTAssertEqual(view1.horizontalEdges.anchor.anchor2, view1.trailingAnchor)
        XCTAssertEqual(view1.verticalEdges.anchor.anchor1, view1.topAnchor)
        XCTAssertEqual(view1.verticalEdges.anchor.anchor2, view1.bottomAnchor)
        XCTAssertEqual(view1.edges.anchor.xAxis.anchor1, view1.leadingAnchor)
        XCTAssertEqual(view1.edges.anchor.xAxis.anchor2, view1.trailingAnchor)
        XCTAssertEqual(view1.edges.anchor.yAxis.anchor1, view1.topAnchor)
        XCTAssertEqual(view1.edges.anchor.yAxis.anchor2, view1.bottomAnchor)
    }
    
    
    func test_LayoutGuideAnchorValues() {
        XCTAssertEqual(view1.layoutMarginsGuide.left.anchor, view1.layoutMarginsGuide.leftAnchor)
        XCTAssertEqual(view1.layoutMarginsGuide.right.anchor, view1.layoutMarginsGuide.rightAnchor)
        XCTAssertEqual(view1.layoutMarginsGuide.top.anchor, view1.layoutMarginsGuide.topAnchor)
        XCTAssertEqual(view1.layoutMarginsGuide.bottom.anchor, view1.layoutMarginsGuide.bottomAnchor)
        XCTAssertEqual(view1.layoutMarginsGuide.leading.anchor, view1.layoutMarginsGuide.leadingAnchor)
        XCTAssertEqual(view1.layoutMarginsGuide.trailing.anchor, view1.layoutMarginsGuide.trailingAnchor)
        XCTAssertEqual(view1.layoutMarginsGuide.width.anchor, view1.layoutMarginsGuide.widthAnchor)
        XCTAssertEqual(view1.layoutMarginsGuide.height.anchor, view1.layoutMarginsGuide.heightAnchor)
        XCTAssertEqual(view1.layoutMarginsGuide.centerX.anchor, view1.layoutMarginsGuide.centerXAnchor)
        XCTAssertEqual(view1.layoutMarginsGuide.centerY.anchor, view1.layoutMarginsGuide.centerYAnchor)
        XCTAssertEqual(view1.layoutMarginsGuide.size.anchor.anchor1, view1.layoutMarginsGuide.widthAnchor)
        XCTAssertEqual(view1.layoutMarginsGuide.size.anchor.anchor2, view1.layoutMarginsGuide.heightAnchor)
        XCTAssertEqual(view1.layoutMarginsGuide.centerXY.anchor.anchor1, view1.layoutMarginsGuide.centerXAnchor)
        XCTAssertEqual(view1.layoutMarginsGuide.centerXY.anchor.anchor2, view1.layoutMarginsGuide.centerYAnchor)
        XCTAssertEqual(view1.layoutMarginsGuide.horizontalEdges.anchor.anchor1, view1.layoutMarginsGuide.leadingAnchor)
        XCTAssertEqual(view1.layoutMarginsGuide.horizontalEdges.anchor.anchor2, view1.layoutMarginsGuide.trailingAnchor)
        XCTAssertEqual(view1.layoutMarginsGuide.verticalEdges.anchor.anchor1, view1.layoutMarginsGuide.topAnchor)
        XCTAssertEqual(view1.layoutMarginsGuide.verticalEdges.anchor.anchor2, view1.layoutMarginsGuide.bottomAnchor)
        XCTAssertEqual(view1.layoutMarginsGuide.edges.anchor.xAxis.anchor1, view1.layoutMarginsGuide.leadingAnchor)
        XCTAssertEqual(view1.layoutMarginsGuide.edges.anchor.xAxis.anchor2, view1.layoutMarginsGuide.trailingAnchor)
        XCTAssertEqual(view1.layoutMarginsGuide.edges.anchor.yAxis.anchor1, view1.layoutMarginsGuide.topAnchor)
        XCTAssertEqual(view1.layoutMarginsGuide.edges.anchor.yAxis.anchor2, view1.layoutMarginsGuide.bottomAnchor)
    }
    
    func test_SafeAreaLayoutGuideAnchorValues() {
        XCTAssertEqual(view1.safeAreaLayoutGuide.left.anchor, view1.safeAreaLayoutGuide.leftAnchor)
        XCTAssertEqual(view1.safeAreaLayoutGuide.right.anchor, view1.safeAreaLayoutGuide.rightAnchor)
        XCTAssertEqual(view1.safeAreaLayoutGuide.top.anchor, view1.safeAreaLayoutGuide.topAnchor)
        XCTAssertEqual(view1.safeAreaLayoutGuide.bottom.anchor, view1.safeAreaLayoutGuide.bottomAnchor)
        XCTAssertEqual(view1.safeAreaLayoutGuide.leading.anchor, view1.safeAreaLayoutGuide.leadingAnchor)
        XCTAssertEqual(view1.safeAreaLayoutGuide.trailing.anchor, view1.safeAreaLayoutGuide.trailingAnchor)
        XCTAssertEqual(view1.safeAreaLayoutGuide.width.anchor, view1.safeAreaLayoutGuide.widthAnchor)
        XCTAssertEqual(view1.safeAreaLayoutGuide.height.anchor, view1.safeAreaLayoutGuide.heightAnchor)
        XCTAssertEqual(view1.safeAreaLayoutGuide.centerX.anchor, view1.safeAreaLayoutGuide.centerXAnchor)
        XCTAssertEqual(view1.safeAreaLayoutGuide.centerY.anchor, view1.safeAreaLayoutGuide.centerYAnchor)
        XCTAssertEqual(view1.safeAreaLayoutGuide.size.anchor.anchor1, view1.safeAreaLayoutGuide.widthAnchor)
        XCTAssertEqual(view1.safeAreaLayoutGuide.size.anchor.anchor2, view1.safeAreaLayoutGuide.heightAnchor)
        XCTAssertEqual(view1.safeAreaLayoutGuide.centerXY.anchor.anchor1, view1.safeAreaLayoutGuide.centerXAnchor)
        XCTAssertEqual(view1.safeAreaLayoutGuide.centerXY.anchor.anchor2, view1.safeAreaLayoutGuide.centerYAnchor)
        XCTAssertEqual(view1.safeAreaLayoutGuide.horizontalEdges.anchor.anchor1, view1.safeAreaLayoutGuide.leadingAnchor)
        XCTAssertEqual(view1.safeAreaLayoutGuide.horizontalEdges.anchor.anchor2, view1.safeAreaLayoutGuide.trailingAnchor)
        XCTAssertEqual(view1.safeAreaLayoutGuide.verticalEdges.anchor.anchor1, view1.safeAreaLayoutGuide.topAnchor)
        XCTAssertEqual(view1.safeAreaLayoutGuide.verticalEdges.anchor.anchor2, view1.safeAreaLayoutGuide.bottomAnchor)
        XCTAssertEqual(view1.safeAreaLayoutGuide.edges.anchor.xAxis.anchor1, view1.safeAreaLayoutGuide.leadingAnchor)
        XCTAssertEqual(view1.safeAreaLayoutGuide.edges.anchor.xAxis.anchor2, view1.safeAreaLayoutGuide.trailingAnchor)
        XCTAssertEqual(view1.safeAreaLayoutGuide.edges.anchor.yAxis.anchor1, view1.safeAreaLayoutGuide.topAnchor)
        XCTAssertEqual(view1.safeAreaLayoutGuide.edges.anchor.yAxis.anchor2, view1.safeAreaLayoutGuide.bottomAnchor)
    }
    


}
