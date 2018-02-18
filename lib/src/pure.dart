import 'package:flutter/widgets.dart';

import 'typedefs.dart';

/// [pure] lets you short-circuit a build operation
/// by returning the last build result if props did not change
/// since the last time build was called.
FunctionalWidget<P> pure<P>(FunctionalWidget<P> child) =>
    (P props) => new _Pure<P>(props, child);

class _Pure<P> extends StatefulWidget {
  _Pure(
    this.props,
    this.child, {
    Key key,
  })
      : super(key: key);

  final FunctionalWidget<P> child;

  final P props;

  _PureState<P> createState() => new _PureState<P>();
}

class _PureState<P> extends State<_Pure<P>> {
  Widget childCache;

  P propCache;

  @override
  Widget build(BuildContext context) {
    if (propCache == widget.props) return childCache;
    propCache = widget.props;
    childCache = widget.child(widget.props);
    return childCache;
  }
}
