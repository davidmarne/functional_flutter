import 'package:flutter/widgets.dart';
import 'package:built_redux/built_redux.dart' hide Mapper;
import 'package:flutter_built_redux/flutter_built_redux.dart';

import 'typedefs.dart';

/// [withBuiltReduxStore] creates a flutter_built_redux widget
/// with the [connect] function provided, then maps its props and the local
/// store state to the child props type by invoking the [mapper] function.
WidgetEnhancer<InnerP, OutterP> withBuiltReduxStore<StoreState,
        Actions extends ReduxActions, LocalState, InnerP, OutterP>(
  Connect<StoreState, LocalState> connect,
  StoreMapper<LocalState, Actions, InnerP, OutterP> mapper,
) =>
    (FunctionalWidget<InnerP> baseWidget) => (OutterP props) =>
        new _WithStore<StoreState, Actions, LocalState, InnerP, OutterP>(
            props, baseWidget, mapper, connect);

typedef LocalState Connect<StoreState, LocalState>(StoreState storeState);

typedef InnerP StoreMapper<LocalState, Actions, InnerP, OutterP>(
    LocalState state, Actions actions, OutterP props);

class _WithStore<StoreState, Actions extends ReduxActions, LocalState, InnerP,
    OutterP> extends StoreConnector<StoreState, Actions, LocalState> {
  _WithStore(
    this.props,
    this.child,
    this.mapper,
    this._connect, {
    Key key,
  })
      : super(key: key);

  final FunctionalWidget child;

  final OutterP props;

  final Connect<StoreState, LocalState> _connect;

  final StoreMapper<LocalState, Actions, InnerP, OutterP> mapper;

  @override
  LocalState connect(StoreState storeState) => _connect(storeState);

  @override
  Widget build(BuildContext context, LocalState local, Actions actions) =>
      child(mapper(local, actions, props));
}
