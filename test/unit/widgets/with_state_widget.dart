import 'package:functional_flutter/functional_flutter.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

final counterKey = new Key('counterKey');
final incrementButtonKey = new Key('incrementButtonKey');
final decrementButtonKey = new Key('decrementButtonKey');

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
  (String props, int state, SetState<int> setState) => new AppProps(
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
