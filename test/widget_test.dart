import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:your_app_name/main.dart';

void main() {
  testWidgets('App loads and shows login', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());

    expect(find.text('Login'), findsOneWidget);
  });
}
