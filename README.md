# Constraints Package

Introduced in Swift 5.4 result builders (also known as function builders) allow you to build up a result using 'build blocks'.

This package uses result builders to create a 'Constraints Builder' which takes multiple NSLayoutConstraint and outputs an array of NSLayoutConstraints.

```

Constraints {
    view.heightAnchor.constraint(equalTo: view2.heightAnchor, multiplier: 1)
    view.widthAnchor.constraint(equalToConstant: 200)
    view2.centerXAnchor.constraint(equalTo: view.centerXAnchor)
}

```



Using included extensions on NSLayoutConstraint we can activate constraints all at once and add priority.

```

Constraints {
    view.heightAnchor.constraint(equalTo: view2.heightAnchor, multiplier: 1)
    view.widthAnchor.constraint(equalToConstant: 200)
    view2.centerXAnchor.constraint(equalTo: view.centerXAnchor).setPriority(999)
    
}.activate()


```

An alternative way is to create an array of constraints instead.

```

[
    view.heightAnchor.constraint(equalTo: view2.heightAnchor, multiplier: 1),
    view.widthAnchor.constraint(equalToConstant: 200),
    view2.centerXAnchor.constraint(equalTo: view.centerXAnchor).setPriority(999),
    
].activate()


```

Using function builders offers 3 minor advantages.

1. No need to keep track of commas. Can be annoying when adding a lot of constraints.
2. The keyword 'Constraints' allows us to quickly find the constraints using Cmd+F.
3. Opens up further potential for improving the way constraints configured.
