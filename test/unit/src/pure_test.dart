import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../widgets/pure_widget.dart';

void main() {
  group('pure: ', () {
    setUp(() {
      resetBuildCount();
      expect(buildCount, 0);
    });

    testWidgets('renders default state correctly', (WidgetTester tester) async {
      final app = counterApp('pure');

      await tester.pumpWidget(app);

      Text countTextWidget = tester.firstWidget(
        find.byKey(counterKey),
      );

      expect(countTextWidget.data, 'Count: 0');
      expect(buildCount, 1);
    });

    testWidgets(
        'rerenders after increment & not after non incrementing state change',
        (WidgetTester tester) async {
      final title = 'counter test';
      final app = counterApp(title);

      await tester.pumpWidget(app);

      Text counterWidget = tester.firstWidget(
        find.byKey(counterKey),
      );

      expect(counterWidget.data, 'Count: 0');
      expect(buildCount, 1);

      await tester.tap(find.byKey(incrementButtonKey));
      await tester.pump();

      counterWidget = tester.firstWidget(
        find.byKey(counterKey),
      );

      expect(counterWidget.data, 'Count: 1');
      expect(buildCount, 2);

      await tester.tap(find.byKey(nonIncrementingButtonKey));
      await tester.pump();

      counterWidget = tester.firstWidget(
        find.byKey(counterKey),
      );

      expect(counterWidget.data, 'Count: 1');
      expect(buildCount, 2);
    });
  });
}
