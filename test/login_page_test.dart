import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:your_app/login_page.dart';  // Replace with your actual LoginPage path

void main() {
  testWidgets('Login button should be present and work', (WidgetTester tester) async {
    // Build the LoginPage widget
    await tester.pumpWidget(MaterialApp(home: LoginPage()));

    // Find the login button by its type (ElevatedButton)
    final loginButton = find.byType(ElevatedButton);

    // Ensure that the login button is found
    expect(loginButton, findsOneWidget);

    // Tap the login button and perform a mock login
    await tester.tap(loginButton);
    await tester.pump();

    // Verify that login was successful (e.g., a snack bar or new page appears)
    expect(find.text('Login successful!'), findsOneWidget);  // Example check for successful login
  });
}
