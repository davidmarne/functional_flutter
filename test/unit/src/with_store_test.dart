import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../widgets/built_redux_widget.dart';

void main() {
  group('withStore: ', () {
    testWidgets('renders default state correctly', (WidgetTester tester) async {
      final title = 'counter test';
      final app = counterApp(title);

      await tester.pumpWidget(app);

      Text countTextWidget = tester.firstWidget(
        find.byKey(counterKey),
      );

      expect(countTextWidget.data, '$title: 0');
    });

    testWidgets('rerenders after increment & decrement',
        (WidgetTester tester) async {
      final title = 'counter test';
      final app = counterApp(title);

      await tester.pumpWidget(app);

      Text counterWidget = tester.firstWidget(
        find.byKey(counterKey),
      );

      expect(counterWidget.data, '$title: 0');

      await tester.tap(find.byKey(incrementButtonKey));
      await tester.pump();

      counterWidget = tester.firstWidget(
        find.byKey(counterKey),
      );

      expect(counterWidget.data, '$title: 1');

      await tester.tap(find.byKey(decrementButtonKey));
      await tester.pump();

      counterWidget = tester.firstWidget(
        find.byKey(counterKey),
      );

      expect(counterWidget.data, '$title: 0');
    });
  });
}
