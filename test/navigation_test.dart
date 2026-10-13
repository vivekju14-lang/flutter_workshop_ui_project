import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_workshop_ui_project/main.dart';

void main() {
  testWidgets('password reset flow validates fields and returns to login', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(430, 932);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(const OrangeApp());
    await tester.tap(find.text('Explore Now'));
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('Forgot Password ?'));
    await tester.tap(find.text('Forgot Password ?'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextFormField), 'student@example.com');
    await tester.tap(find.text('Send code'));
    await tester.pumpAndSettle();
    expect(find.text('OTP Verification'), findsOneWidget);
    final fields = find.byType(TextField);
    for (var i = 0; i < 4; i++) {
      await tester.enterText(fields.at(i), '${i + 1}');
    }
    await tester.ensureVisible(find.text('Verify'));
    await tester.tap(find.text('Verify'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextFormField).at(0), 'password123');
    await tester.enterText(find.byType(TextFormField).at(1), 'different123');
    await tester.tap(find.text('Submit'));
    await tester.pump();
    expect(find.text('Passwords do not match'), findsOneWidget);
    await tester.enterText(find.byType(TextFormField).at(1), 'password123');
    await tester.tap(find.text('Submit'));
    await tester.pumpAndSettle();
    expect(find.text('Welcome back'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
