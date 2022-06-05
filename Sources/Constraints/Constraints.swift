

#if canImport(UIKit)

import UIKit



@resultBuilder
public struct ConstraintsBuilder {
    static public func buildBlock() -> [NSLayoutConstraint] { [] }
    
}

extension ConstraintsBuilder {
    static public func buildBlock(_ constraints: NSLayoutConstraint...) -> [NSLayoutConstraint] {
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
