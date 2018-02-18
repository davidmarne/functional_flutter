import 'package:functional_flutter/functional_flutter.dart';
import 'package:flutter/material.dart';

final messageKey = new Key('messageKey');

class MappedExampleProps {
  String message;
}

FunctionalWidget<String> propMappedComponent = withProps(
        (String props) => new MappedExampleProps()..message = 'Mapped: $props')(
    _innerPropMappedComponent);

Widget _innerPropMappedComponent(MappedExampleProps props) => new MaterialApp(
      title: props.message,
      home: new Scaffold(
        body: new Row(
          children: <Widget>[
            new Text(
              props.message,
              key: messageKey,
            ),
          ],
        ),
      ),
    );
