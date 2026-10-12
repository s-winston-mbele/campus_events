import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:campus_events/main.dart';

void main() {
  testWidgets('Home renders at narrow width and search filters events', (tester) async {
    tester.view.physicalSize = const Size(360, 800);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(const CampusEventsApp());
    await tester.pumpAndSettle();
    expect(find.text('Hi, Winston'), findsOneWidget);
    expect(tester.takeException(), isNull);
    await tester.enterText(find.byType(TextFormField), 'AWS');
    await tester.pumpAndSettle();
    expect(find.text('AWS SGB Event'), findsOneWidget);
    expect(find.text('Innovation Day'), findsNothing);
    await tester.tap(find.text('View QR'));
    await tester.pumpAndSettle();
    expect(find.text('QR preview — not a valid entry code'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
