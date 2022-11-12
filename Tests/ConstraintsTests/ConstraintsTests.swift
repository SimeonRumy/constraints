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
@testable import Constraints

final class ConstraintsTests: XCTestCase {
    
    let view1 = View(frame: CGRect.zero)
    let view2 = View(frame: CGRect.zero)
    
    //MARK: - Test Constraints Builder
    func test_zero_constraints_count_equals_zero() throws {
        let constraints = Constraints {
            
        }
        
        XCTAssertEqual(constraints.count, 0)
    }
    
    func test_nested_constraints() throws {
        let constraints = Constraints {
            Constraints {
                view1.heightAnchor.constraint(equalTo: view2.heightAnchor, multiplier: 1)
            }
            view1.heightAnchor.constraint(equalTo: view2.heightAnchor, multiplier: 1)
        }
        
        XCTAssertEqual(constraints.count, 2)
    }
    
    
    func test_one_constraints_equals_one() throws {
        
        let constraints = Constraints {
            view1.heightAnchor.constraint(equalTo: view2.heightAnchor, multiplier: 1)
        }
        
        XCTAssertEqual(constraints.count, 1)
    }
    
    func test_if_True() throws {
        let isDummy = true
        let constraints = Constraints {
            if isDummy {
                view1.heightAnchor.constraint(equalTo: view2.heightAnchor, multiplier: 1)
            }
        }
        
        XCTAssertEqual(constraints.count, 1)
    }
    
    func test_if_False() throws {
        let isDummy = false
        let constraints = Constraints {
            if isDummy {
                view1.heightAnchor.constraint(equalTo: view2.heightAnchor, multiplier: 1)
            }
        }
        
        XCTAssertEqual(constraints.count, 0)
    }
    
    func test_If_Else() throws {
        let isDummy = true
        let constraints = Constraints {
            if isDummy {
                Constraints {
                    view1.heightAnchor.constraint(equalTo: view2.heightAnchor, multiplier: 1)
                }
            } else {
                Constraints {
                    view1.heightAnchor.constraint(equalTo: view2.heightAnchor, multiplier: 1)
                }
            }
        }
        
        XCTAssertEqual(constraints.count, 1)
    }
    
    func test_If_IfElse_Else() throws {
        let count = 1
        let constraints = Constraints {
            if count == 100 {
                Constraints {
                    view1.heightAnchor.constraint(equalTo: view2.heightAnchor, multiplier: 1)
                }
            } else if count == 1{
                Constraints {
                    view1.heightAnchor.constraint(equalTo: view2.heightAnchor, multiplier: 1)
                }
            } else {
                Constraints {
                    view1.heightAnchor.constraint(equalTo: view2.heightAnchor, multiplier: 1)
                }
            }
        }
        
        XCTAssertEqual(constraints.count, 1)
    }
    
    func test_functionWitchOptionalReturn() throws {
        
        func dummy() -> NSLayoutConstraint? {
            return nil
        }
        
        let constraints = Constraints {
           dummy()
        }

        XCTAssertEqual(constraints.count, 0)
    }


}
