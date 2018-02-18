import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../widgets/with_state_widget.dart';

void main() {
  group('withState: ', () {
    testWidgets('renders default state correctly', (WidgetTester tester) async {
      final app = counterApp('counter test');

      await tester.pumpWidget(app);

      Text countTextWidget = tester.firstWidget(
        find.byKey(counterKey),
      );

      expect(countTextWidget.data, 'Count: 0');
    });

    testWidgets('rerenders after increment & decrement',
        (WidgetTester tester) async {
      final app = counterApp('counter test');

      await tester.pumpWidget(app);

      Text counterWidget = tester.firstWidget(
        find.byKey(counterKey),
      );

      expect(counterWidget.data, 'Count: 0');

      await tester.tap(find.byKey(incrementButtonKey));
      await tester.pump();

      counterWidget = tester.firstWidget(
        find.byKey(counterKey),
      );

      expect(counterWidget.data, 'Count: 1');

      await tester.tap(find.byKey(decrementButtonKey));
      await tester.pump();

      counterWidget = tester.firstWidget(
        find.byKey(counterKey),
      );

      expect(counterWidget.data, 'Count: 0');
    });
  });
}
