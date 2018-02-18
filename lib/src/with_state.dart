import 'package:flutter/widgets.dart';

import 'typedefs.dart';

/// [withState] lets you compose a FunctionalWidget that is stateful
///
/// @immutable
///   class AppProps {
///   final String title;
///   final int count;
///   final VoidCallback increment;
///   final VoidCallback decrement;
///   AppProps({this.title, this.count, this.increment, this.decrement});
/// }
///
/// FunctionalWidget<String> counterApp = withState(
///   0,
///   (String props, int state, SetState<int> setState) => new AppProps(
///      title: props,
///      count: state,
///      increment: () => setState((s) => s + 1),
///      decrement: () => setState((s) => s - 1),
///     ),
///   )(_appContent);
///
/// Widget _appContent(AppProps props) => new MaterialApp(
///   title: props.title,
///     home: new Scaffold(
///       body: new Row(
///         children: <Widget>[
///           new RaisedButton(
///             onPressed: props.increment,
///             child: new Row(
///                children: <Widget>[
///                  new Text('Increment'),
///                ],
///              ),
///             key: incrementButtonKey,
///           ),
///           new RaisedButton(
///             onPressed: props.decrement,
///             child: new Row(
///                children: <Widget>[
///                  new Text('Decrement'),
///                ],
///              ),
///             key: decrementButtonKey,
///           ),
///           new Text(
///             'Count: ${props.count}',
///             key: counterKey,
///           ),
///         ],
///       ),
///     ),
///   );
///
WidgetEnhancer<InnerP, OutterP> withState<InnerP, OutterP, S>(
  S defaultState,
  StateMapper<InnerP, OutterP, S> mapper,
) =>
    (FunctionalWidget<InnerP> baseWidget) => (OutterP props) =>
        new _WithState<InnerP, OutterP, S>(
            props, defaultState, baseWidget, mapper);

/// [SetState] is a functional that given a [stateSetter]
/// will call setState with the result of the [stateSetter]
typedef void SetState<S>(S stateSetter(S previousState));

/// [StateMapper] is a mapper function that given the outter props,
/// the state of the stateful widget, and the setState function
/// returns the inner props.
typedef InnerP StateMapper<InnerP, OutterP, S>(
    OutterP props, S state, SetState<S> setState);

class _WithState<InnerP, OutterP, S> extends StatefulWidget {
  _WithState(
    this.props,
    this.defaultState,
    this.child,
    this.mapper, {
    Key key,
  })
      : super(key: key);

  final FunctionalWidget<InnerP> child;

  final S defaultState;

  final OutterP props;

  final StateMapper<InnerP, OutterP, S> mapper;

  _WithStateState createState() =>
      new _WithStateState<InnerP, OutterP, S>(defaultState);
}

class _WithStateState<InnerP, OutterP, S>
    extends State<_WithState<InnerP, OutterP, S>> {
  S state;

  _WithStateState(S defaultState) {
    state = defaultState;
  }

  void stateSetter(Mapper<S, S> setter) {
    setState(() {
      state = setter(state);
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.child(widget.mapper(widget.props, state, stateSetter));
  }
}
