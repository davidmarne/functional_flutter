import 'typedefs.dart';

/// [mapProps] will transform the props with the [mapper] funtion provider before invokeing [baseWidget]
///
/// Example
///  ```dart
///   class MappedExampleProps {
///     String message;
///   }
///
///   FunctionalWidget<String> propMappedComponent = withProps(
///       (String props) => new MappedExampleProps()..message = 'Mapped: $props')(
///     _innerPropMappedComponent);
///
///   Widget _innerPropMappedComponent(MappedExampleProps props) => new MaterialApp(
///     title: props.message,
///       home: new Scaffold(
///        body: new Row(
///         children: <Widget>[
///           new Text(
///             props.message,
///             key: messageKey,
///           ),
///         ],
///       ),
///     ),
///   );
///   ```
WidgetEnhancer<InnerP, OutterP> withProps<InnerP, OutterP>(
        Mapper<OutterP, InnerP> mapper) =>
    (FunctionalWidget<InnerP> baseWidget) =>
        (OutterP props) => baseWidget(mapper(props));
