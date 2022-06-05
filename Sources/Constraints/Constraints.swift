

#if canImport(UIKit)

import UIKit



@resultBuilder
struct ConstraintsBuilder {
    static func buildBlock() -> [NSLayoutConstraint] { [] }
    
}

extension ConstraintsBuilder {
    static func buildBlock(_ constraints: NSLayoutConstraint...) -> [NSLayoutConstraint] {
        constraints
    }
}

public func Constraints(@ConstraintsBuilder _ content: () -> [NSLayoutConstraint]) -> [NSLayoutConstraint] {
    content()
}

#else

public func Constraints() {
    
}

#endif
