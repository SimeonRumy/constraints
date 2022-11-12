//
//  NSLayoutExtensions.swift
//  
//
//  Created by Simeon Rumyannikov on 11/11/2022.
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


final class NSLayoutExtensions: XCTestCase {
    
    var view = UIView()
    var view2 = UIView()
    var parentView = UIView()
    

    override func setUpWithError() throws {
        view = UIView()
        view2 = UIView()
        parentView = UIView()
        parentView.addSubview(view2)
        parentView.addSubview(view)
        
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    
    func test_enableAutoLayout() throws {
        view.enableAutoLayout()
        XCTAssertFalse(view.translatesAutoresizingMaskIntoConstraints)
    }
    
    func test_disableAutoLayout() throws {
        view.enableAutoLayout()
        view.disableAutoLayout()
        XCTAssertTrue(view.translatesAutoresizingMaskIntoConstraints)
    }
    
    func test_multiply() throws {
        let constraint = view.topAnchor.constraint(equalTo: view2.topAnchor, constant: 0).multiply(10)
        XCTAssertTrue(constraint.multiplier == 10)
    }
    
    func test_multiply_array() throws {
        let constraints = Constraints {
            view.heightAnchor.constraint(equalTo: view2.heightAnchor, multiplier: 1)
            view.widthAnchor.constraint(equalTo: view2.widthAnchor, multiplier: 1)
        }.multiplyEach(10)
        XCTAssertTrue(constraints.allSatisfy { $0.multiplier == 10})
    }
    
    func test_activate() throws {
        let constraint = view.heightAnchor.constraint(equalTo: view2.heightAnchor, multiplier: 1)
        constraint.activate()
        XCTAssertTrue(constraint.isActive)
    }
    
    func test_activate_array() throws {
        let constraints = Constraints {
            view.heightAnchor.constraint(equalTo: view2.heightAnchor, multiplier: 1)
            view.widthAnchor.constraint(equalTo: view2.widthAnchor, multiplier: 1)
        }
        constraints.activate()
        XCTAssertTrue(constraints.allSatisfy(\.isActive))
    }
    
    func test_priority() throws {
        let constraint = view.heightAnchor.constraint(equalTo: view2.heightAnchor, multiplier: 1).priority(888)
        XCTAssertTrue(constraint.priority.rawValue == 888)
    }

    func test_priority_array() throws {
        let constraints = Constraints {
            view.heightAnchor.constraint(equalTo: view2.heightAnchor, multiplier: 1)
            view.widthAnchor.constraint(equalTo: view2.widthAnchor, multiplier: 1)
        }.priority(888)
        
        XCTAssertTrue(constraints.allSatisfy({$0.priority.rawValue == 888}))
    }


    func test_almostRequired_equals_to_999() throws {
        XCTAssertEqual(UILayoutPriority.almostRequired, UILayoutPriority(rawValue: 999))
    }
    
    func test_priority_almostRequired() throws {

        let constraints = Constraints {
            view.heightAnchor.constraint(equalTo: view2.heightAnchor, multiplier: 1)
        }.priority(.almostRequired)
        
        XCTAssertEqual(constraints.first?.priority ?? .defaultLow, .almostRequired)
    }
    
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
