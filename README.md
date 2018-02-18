[![Pub](https://img.shields.io/pub/v/functional_flutter.svg)](https://pub.dartlang.org/packages/functional_flutter)
[![codecov.io](http://codecov.io/github/davidmarne/functional_flutter/coverage.svg?branch=master)](http://codecov.io/github/davidmarne/functional_flutter?branch=master)

# functional_flutter

Tools for composing flutter widget trees in a functional manner.

# Why

Your widget tree should be a function of your applications state, so why would you write widgets as classes and not functions?

functional_flutter encourages you to separate your state and properties from your widget definition. Rather than have a class that has properties and a build function implemented, you can lift the properties into a class and write `FunctionalWidgets` that take a properties class and return a widget.

Properties should always be a value type. I suggest you leverage built_value or meta's @immutable annotation for your prop classes.

# If everything is a pure functional widget how can my widgets have state

The withState widget enhancer lets you lift state into a functional wrapper. For example:

```dart

@immutable
class AppProps {
  final String title;
  final int count;
  final VoidCallback increment;
  final VoidCallback decrement;
  AppProps({this.title, this.count, this.increment, this.decrement});
}

FunctionalWidget<String> counterApp = withState(
  0,
  (String props, int state, SetState<int> setState) =>
      new AppProps(
        title: props,
        count: state,
        increment: () => setState((s) => s + 1),
        decrement: () => setState((s) => s - 1),
      ),
)(_appContent);

Widget _appContent(AppProps props) => new MaterialApp(
      title: props.title,
      home: new Scaffold(
        body: new Row(
          children: <Widget>[
            new RaisedButton(
              onPressed: props.increment,
              child: new Row(
                children: <Widget>[
                  new Text('Increment'),
                ],
              ),
              key: incrementButtonKey,
            ),
            new RaisedButton(
              onPressed: props.decrement,
              child: new Row(
                children: <Widget>[
                  new Text('Decrement'),
                ],
              ),
              key: decrementButtonKey,
            ),
            new Text(
              'Count: ${props.count}',
              key: counterKey,
            ),
          ],
        ),
      ),
    );
```

the withBuiltReduxStore enhancer also lets you subscribe to state
from your built_redux store, if you are using built_redux as a 
state management solution.