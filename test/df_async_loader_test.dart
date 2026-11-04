import 'dart:async';

import 'package:df_async_loader/df_async_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets(
    'A failed callback dismisses the loader and propagates the error',
    (tester) async {
      late BuildContext context;
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (value) {
              context = value;
              return const Scaffold(body: Text('Home'));
            },
          ),
        ),
      );
      final task = Completer<int>();
      var finished = false;
      final result = DfAsyncLoader.showLoader<int>(
        context: context,
        callback: () => task.future,
        onFinished: (_) => finished = true,
      );
      await tester.pump();
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      final error = StateError('Task failed');
      final expectation = expectLater(result, throwsA(same(error)));
      task.completeError(error);
      await expectation;
      await tester.pumpAndSettle();
      expect(find.byType(CircularProgressIndicator), findsNothing);
      expect(finished, isFalse);
      expect(find.text('Home'), findsOneWidget);
    },
  );
}
