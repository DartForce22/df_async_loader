import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test/main.dart';

void main() {
  testWidgets('Example shows a loader and reports the callback result', (
    tester,
  ) async {
    await tester.pumpWidget(const MyApp());
    await tester.tap(find.text('Call Int Function'));
    await tester.pump();
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    await tester.pump(const Duration(seconds: 2));
    await tester.pumpAndSettle();
    expect(find.byType(CircularProgressIndicator), findsNothing);
    expect(find.text('CALLED INT FUNCTION result = 5'), findsOneWidget);
  });
}
