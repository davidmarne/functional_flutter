[![Pub](https://img.shields.io/pub/v/functional_flutter.svg)](https://pub.dartlang.org/packages/functional_flutter)
[![codecov.io](http://codecov.io/github/davidmarne/functional_flutter/coverage.svg?branch=master)](http://codecov.io/github/davidmarne/functional_flutter?branch=master)

# functional_flutter

Tools for composing flutter widget trees in a functional manner. Inspired by [recompose](https://github.com/acdlite/recompose).

# Why

Your widget tree should be a function of your applications state, so why would you write widgets as classes and not functions?

functional_flutter encourages you to separate your state and properties from your widget definition. Rather than have a class that has properties and a build function implemented, you can lift the properties into a class and write `FunctionalWidgets` that take a properties class and return a widget.

Following this pattern helps make your application easier to reason about and it decreases the amount of widgets in the tree.

Properties should always be a value type. I suggest you leverage built_value or meta's @immutable annotation for your prop classes.

# If everything is a pure functional widget how can my widgets have state

The withState widget enhancer lets you lift state into a functional wrapper. See the [example](/example/example.dart).

The withBuiltReduxStore enhancer also lets you subscribe to state
from your built_redux store if you are using built_redux as a 
state management solution.
