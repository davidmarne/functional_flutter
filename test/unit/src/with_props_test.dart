import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../widgets/with_props_widget.dart';

void main() {
  group('withProps: ', () {
    testWidgets('maps props correctly', (WidgetTester tester) async {
      final title = 'counter test';
      final app = propMappedComponent(title);

      await tester.pumpWidget(app);

      Text countTextWidget = tester.firstWidget(
        find.byKey(messageKey),
      );

      expect(countTextWidget.data, 'Mapped: $title');
    });
  });
}
