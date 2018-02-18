import 'package:functional_flutter/functional_flutter.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

final counterKey = new Key('counterKey');
final incrementButtonKey = new Key('incrementButtonKey');
final nonIncrementingButtonKey = new Key('nonIncrementingButtonKey');
Key counterKeyPerf(int i) => new Key('counterKey-$i');

@immutable
class AppProps {
  final String title;
  final int count;
  final VoidCallback increment;
  final VoidCallback nonIncrementingSetState;
  AppProps(
      {this.title, this.count, this.increment, this.nonIncrementingSetState});

  @override
  bool operator ==(dynamic other) {
    if (identical(other, this)) return true;
    if (other is! AppProps) return false;
    return count == other.count && title == other.title;
  }

  @override
  int get hashCode {
    return title.hashCode + count;
  }
}

FunctionalWidget<String> counterApp = withState(
  0,
  (String props, int state, SetState<int> setState) => new AppProps(
        title: props,
        count: state,
        increment: () => setState((s) => s + 1),
        nonIncrementingSetState: () => setState((s) => s),
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
              onPressed: props.nonIncrementingSetState,
              child: new Row(
                children: <Widget>[
                  new Text('Non-Incrementing Set State'),
                ],
              ),
              key: nonIncrementingButtonKey,
            ),
            pure(textContent)(props.count),
          ],
        ),
      ),
    );

var buildCount = 0;
void resetBuildCount() {
  buildCount = 0;
}

final perfElementCount = 100;

Widget textContent(int props) {
  buildCount++;
  return new Text(
    'Count: ${props}',
    key: counterKey,
  );
}
