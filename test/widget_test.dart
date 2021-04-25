import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:cube_timer/main.dart';

void main() {
  testWidgets('Time some period of time so it shows non 0.00',
      (WidgetTester tester) async {
    await tester.pumpWidget(CubeTimerApp());

    expect(find.text('0.00'), findsOneWidget);

    await tester.tap(find.byType(GestureDetector));
    await tester.pump(Duration(seconds: 3));
    await tester.tap(find.byType(GestureDetector));
    await tester.pump();

    expect(find.text('0.00'), findsNothing);
  });
}
