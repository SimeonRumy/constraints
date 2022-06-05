import XCTest
@testable import Constraints

#if canImport(UIKit)
import UIKit

final class ConstraintsTests: XCTestCase {
    
    
    func test_zero_constraints_count_equals_zero() throws {
        let constraints = Constraints {
            
        }
        
        XCTAssertEqual(constraints.count, 0)
    }
    
    func test_one_constraints_equals_one() throws {
        
        let view = UIView()
        let view2 = UIView()
        
        let constraints = Constraints {
            view.heightAnchor.constraint(equalTo: view2.heightAnchor, multiplier: 1)
        }
        
        XCTAssertEqual(constraints.count, 1)
    }
    
    func test_almostRequired_equals_to_999() throws {
        XCTAssertEqual(UILayoutPriority.almostRequired, UILayoutPriority(rawValue: 999))
    }
    
    func test_priority_almostRequired() throws {
        let view = UIView()
        let view2 = UIView()
        
        let constraints = Constraints {
            view.heightAnchor.constraint(equalTo: view2.heightAnchor, multiplier: 1)
        }.setPriority(.almostRequired)
        
        XCTAssertEqual(constraints.first?.priority ?? .defaultLow, .almostRequired)
    }
    
}

#endif
