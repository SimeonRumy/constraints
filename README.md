# Sim Constraints


[![Contributors][contributors-shield]][contributors-url]
[![Forks][forks-shield]][forks-url]
[![Stargazers][stars-shield]][stars-url]
[![Issues][issues-shield]][issues-url]
[![MIT License][license-shield]][license-url]
[![License](https://img.shields.io/badge/license-MIT-green)](https://img.shields.io/badge/license-MIT-green)
[![Swift 5.7](https://img.shields.io/badge/Swift-5.4%20+%205.7-orange.svg)](https://swift.org)
[![Code Coverage](https://img.shields.io/badge/coverage-97.4%25-green?style=flat)](https://img.shields.io/badge/coverage-97.4%25-green?style=flat)



<!-- PROJECT LOGO -->
<br />
<div align="center">
  <a href="https://github.com/github_username/repo_name">
    <img src="images/logo.png" alt="Logo" width="80" height="80">
  </a>

<h3 align="center">project_title</h3>

  <p align="center">
    project_description
    <br />
    <a href="https://github.com/github_username/repo_name"><strong>Explore the docs »</strong></a>
    <br />
    <br />
    <a href="https://github.com/github_username/repo_name">View Demo</a>
    ·
    <a href="https://github.com/github_username/repo_name/issues">Report Bug</a>
    ·
    <a href="https://github.com/github_username/repo_name/issues">Request Feature</a>
  </p>
</div>


<!-- TABLE OF CONTENTS -->
<details>
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#prerequisites">Prerequisites</a></li>
        <li><a href="#installation">Installation</a></li>
      </ul>
    </li>
    <li><a href="#usage">Usage</a></li>
    <li><a href="#license">License</a></li>
    <li><a href="#contact">Contact</a></li>
    <li><a href="#acknowledgments">Acknowledgments</a></li>
  </ol>
</details>


## About The Project

This DSL aims to make writing and reading constraints more intuative by making intent clear and removing boilerplate code. Result builders are used to make constraint batching and activation easier and more efficient.

A single constraint can be defined like so:

```swift
view.bottom == 4 * button.top + 10 
```


 This is similar to the internal <strong>linear</strong> representation as discussed by Apple. From the [Apple documentation](https://developer.apple.com/library/mac/documentation/AppKit/Reference/NSLayoutConstraint_Class/NSLayoutConstraint/NSLayoutConstraint.html):

> Each constraint is a linear equation with the following format:
>
> `item1.attribute1 = multiplier × item2.attribute2 + constant`


![dd](/Resources/images/example_1.png)



## Usage 

### Basic Anchors

SimConstraints provides a wrapper over the LayoutAnchor API. Basic anchors consist off:

* top
* bottom 
* leading
* trailing
* centerX
* centerY
* height 
* width
* left
* right
* firstBaseline
* lastBaseline

### Composite Anchors

Composite Anchors combine together basic anchors, enabling setting multiple constraints at once.

| Composite     | Basic Anchors |
| ------------- |---------------|
size            | width, height
centerXY        | centerX, centerY
horizontalEdges | leading, trailing
verticalEdges   | top, bottom
edges           | leading, trailing, top, bottom


### Relations

Relations are expresed using swift operators:

```swift
== // NSLayoutConstraint.Relation.equal
=> // NSLayoutConstraint.Relation.greaterThanOrEqual
<= //NSLayoutConstraint.Relation.lessThanOrEqual   
```
 
### Aligment

```swift
button.leading == button2.trailing + 10   
// which is equivlant to both:
button.leading - 10 == button2.trailing 
button.leading == 10 + button2.trailing
```

The same mathematical rules apply to multipliers which allow us to express relative aligment:

```swift
button.leading == 2 * button2.trailing / 3 
```

#### Centering Views

```swift
view.centerY == superview.centerY
view.centerX == superview.centerX
// or using the composite anchor - centerXY:
view.centerXY == superview.centerXY
```

#### Fill superview

```swift
view.top == superview.top
view.bottom == superview.bottom
view.leading == superview.leading
view.trailing == superview.trailing

// or using composite anchors - edges:
view.horizontalEdges == superview.horizontalEdges
view.verticalEdges == superview.verticalEdges

// in one go:
view.edges == superview.edges
```

#### Insets with composite anchors

Composite Anchors also support setting insets.

```swift
view1.edges == view2.edges + UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
view1.horizontalEdges == 10
view1.horizontalEdges == view2.horizontalEdges + UIEdgeInsets(left: 10, right: 10)
```

### Size

Constrain views to be the same size:

```swift
button.height == button2.height
button.width == button2.width

// or using composite anchor - size:
button.size == button2.size 
button.size == button2.size * 2 // make button1 twice the size of button2
```

Set fixed size:

```swift
button.height == 100
button.width == 200

// or  with composite anchor - size:
button.size == CGSize(width: 200, height: 100)
button.size == 100 // square
```

### Batching and Activating Constraints

SimConstraints uses Results Builders to provide a simple way to batch together individual constraints with arrays of constraints returned my composite anchors.

### Constraint Activation

Unlike other similar libraries, constraints are not activated individually by default, because that is not efficient and can slow down view rendering.

You can activate an individual or an array of constraints using the ```.activate()``` method. When you call this method SimConstraints uses ```NSLayoutConstraint.activate([])``` under the hood. This is the recomended way. You should aim to activate all constraints in one go.


```swift
Constraints {
    mapView.size == 200 ~ .required
    mapView.centerXY == view.centerXY
    view.centerX == view2.centerX
    mapView.bottom == view2.top - 10
    view2.size == mapView.size / 2
}.activate()
```

Result builders also allow us to include additional control flow within the closure, which would not be possible with an array. 

```swift
Constraints {
    if somethingIsTrue {
        mapView.size == 200 ~ .required
        mapView.centerXY == view.centerXY
    } else {
        view.centerX == view2.centerX
    } 
    Constraints {
        mapView.bottom == view2.top - 10
        view2.size == mapView.size / 2
    }.priority(.required)

}.activate()
```

Note, that all constraints are activated in one go and we did not have to store any of them just to activate them later as part of one call to ```NSLayoutConstraint.activate([])```. Result builders handle and simplify all of that.

### Priority

Set priority on individual constraints using ~ operator
```swift
view1.top == view2.top + 20 ~ .required
view1.bottom == view2.bottom + 20 ~ .priority(500) // set custom priority
view1.trailing == view2.trailing + 20 ~ .almostRequired
```

Furthermore ```.priority()``` method can be called on  arrays and individual constraints.

## Installation

Install using [Swift Package Manager](https://github.com/apple/swift-package-manager)

## Contact

Simeon Rumyannikov
* [Linked-in](https://www.linkedin.com/in/simeon-rumyannikov/)
* Email: simeonrumyannikov@gmail.com

## License

This project is shiped under the MIT lices



## Acknowledgments

* [Swift by Sundell: Building DSLs in Swift](https://www.swiftbysundell.com/articles/building-dsls-in-swift/)
* [SwiftAutoLayout Package](https://github.com/indragiek/SwiftAutoLayout)
* [Anchorage Package](https://github.com/Rightpoint/Anchorage)
* [Cartography Package](https://github.com/robb/Cartography)


<p align="right">(<a href="#readme-top">back to top</a>)</p>





## Notes


Introduced in Swift 5.4 result builders (also known as function builders) allow you to build up a result using 'build blocks'.

This package uses result builders to create a 'Constraints Builder' which takes multiple NSLayoutConstraint and outputs an array of NSLayoutConstraints.

```swift

Constraints {
    view.heightAnchor.constraint(equalTo: view2.heightAnchor, multiplier: 1)
    view.widthAnchor.constraint(equalToConstant: 200)
    view.centerXAnchor.constraint(equalTo: view2.centerXAnchor)
    view.centerYAnchor.constraint(equalTo: view2.centerYAnchor)
}

```



Using included extensions on NSLayoutConstraint we can activate constraints all at once and add priority.

```swift

Constraints {
    view.heightAnchor.constraint(equalTo: view2.heightAnchor, multiplier: 1)
    view.widthAnchor.constraint(equalToConstant: 200)
    view2.centerXAnchor.constraint(equalTo: view.centerXAnchor).setPriority(999)
    
}.activate()


```

An alternative way is to create an array of constraints instead.

```swift

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


I have built a fully functional and tested Auto Layout with some of Swifts newest features, documenting the process. 
