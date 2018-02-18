import 'package:functional_flutter/functional_flutter.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

void main() {
  // The following app has two views, one that shows countA and one that shows
  // countB. Depeding on which view is selected countA or countB is rendered.
  // If countA is incremented when countB is showing then the pure wrapper
  // will not rebuild the countAView widget.
  runApp(counterApp('functional flutter example'));
}

@immutable
class AppState {
  final bool showingA;
  final int countA;
  final int countB;
  AppState({
    this.showingA: true,
    this.countA: 0,
    this.countB: 0,
  });

  AppState clone({
    bool showingA,
    int countA,
    int countB,
  }) =>
      new AppState(
        showingA: showingA ?? this.showingA,
        countA: countA ?? this.countA,
        countB: countB ?? this.countB,
      );
}

@immutable
class AppProps {
  final String title;
  final AppState state;
  final VoidCallback incrementA;
  final VoidCallback incrementB;
  final VoidCallback changView;
  AppProps({
    this.title,
    this.state,
    this.incrementA,
    this.incrementB,
    this.changView,
  });
}

// counterApp is a functional component that wraps appContent
// in a statefult widget.
FunctionalWidget<String> counterApp = withState(
  // default state
  new AppState(),
  // maps the incoming props, the state from the stateful widget
  // and the setState function from the stateful widget to AppProps,
  // the result of this function is passed to appContent when counterApp
  // is invoked.
  (String props, AppState state, SetState<AppState> setState) => new AppProps(
        title: props,
        state: state,
        incrementA: () => setState((s) => s.clone(countA: s.countA + 1)),
        incrementB: () => setState((s) => s.clone(countB: s.countB + 1)),
        changView: () => setState((s) => s.clone(showingA: !s.showingA)),
      ),
)(appContent);

// appContent is a functional widget that takes AppProps
// and renders the content of the application, which is
// 3 buttons that update the app state and the current view
Widget appContent(AppProps props) => new MaterialApp(
      title: props.title,
      home: new Scaffold(
        body: new ListView(children: <Widget>[
          new RaisedButton(
            onPressed: props.changView,
            child: new Row(
              children: <Widget>[
                new Text('Change View'),
              ],
            ),
          ),
          new RaisedButton(
            onPressed: props.incrementA,
            child: new Row(
              children: <Widget>[
                new Text('Increment A'),
              ],
            ),
          ),
          new RaisedButton(
            onPressed: props.incrementB,
            child: new Row(
              children: <Widget>[
                new Text('Increment B'),
              ],
            ),
          ),
          viewBranch(props),
        ]),
      ),
    );

// viewBranch is a functional widget that gen AppProps returns
// a view that displays either counterA or counterB's value.
// Both counterView widgets are 'pure' meaning they won't rebuild
// if their props do not change. For example, if increment B is clicked
// in the parent widget and showingA is true, the build function for
// the Text widget will not be run again since the value of countA didn't change
FunctionalWidget<AppProps> viewBranch = branch(
  (props) => props.state.showingA,
  withProps<int, AppProps>((props) => props.state.countA)(
    pure(
      counterView,
    ),
  ),
  withProps<int, AppProps>((props) => props.state.countB)(
    pure(
      counterView,
    ),
  ),
);

Widget counterView(int count) => new Text('Count $count');
