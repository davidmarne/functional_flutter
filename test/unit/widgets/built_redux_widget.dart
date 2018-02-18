library built_redux_widget;

import 'package:functional_flutter/functional_flutter.dart';
import 'package:built_value/built_value.dart';
import 'package:built_redux/built_redux.dart';
import 'package:flutter_built_redux/flutter_built_redux.dart';
import 'package:flutter/material.dart' hide Builder;

part 'built_redux_widget.g.dart';

final counterKey = new Key('counterKey');
final incrementButtonKey = new Key('incrementButtonKey');
final decrementButtonKey = new Key('decrementButtonKey');

abstract class CounterActions extends ReduxActions {
  CounterActions._();
  factory CounterActions() = _$CounterActions;

  ActionDispatcher<Null> get increment;

  ActionDispatcher<Null> get decrement;
}

abstract class Counter implements Built<Counter, CounterBuilder> {
  Counter._();
  factory Counter(void updates(CounterBuilder b)) = _$Counter;

  int get count;
}

class AppProps {
  final int count;
  final String title;
  final CounterActions actions;
  AppProps(this.count, this.actions, this.title);
}

final store = new Store<Counter, CounterBuilder, CounterActions>(
  (s, a, b) {
    if (a.name == CounterActionsNames.increment.name)
      b.count++;
    else
      b.count--;
  },
  new Counter((b) => b..count = 0),
  new CounterActions(),
);

Widget counterApp(String title) => new MaterialApp(
      title: 'flutter_built_redux_test',
      home: new ReduxProvider(
        store: store,
        child: _connected(title),
      ),
    );

FunctionalWidget<String> _connected = withBuiltReduxStore(
  (Counter c) => c.count,
  (int count, CounterActions actions, String title) =>
      new AppProps(count, actions, title),
)(_counterAppContent);

Widget _counterAppContent(AppProps props) => new Scaffold(
      body: new Row(
        children: <Widget>[
          new RaisedButton(
            onPressed: () => props.actions.increment(),
            child: new Row(
              children: <Widget>[
                new Text('Increment'),
              ],
            ),
            key: incrementButtonKey,
          ),
          new RaisedButton(
            onPressed: () => props.actions.decrement(),
            child: new Row(
              children: <Widget>[
                new Text('Decrement'),
              ],
            ),
            key: decrementButtonKey,
          ),
          new Text(
            '${props.title}: ${props.count}',
            key: counterKey,
          ),
        ],
      ),
    );
