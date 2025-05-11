import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_driver/flutter_driver.dart';
import 'package:your_app/main.dart';  // Replace with your actual main entry file

void main() {
  group('Authentication Flow Tests', () {
    FlutterDriver driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });

    test('Sign Up and Login', () async {
      // Navigate to the sign-up page
      final signUpButton = find.byValueKey('sign_up_button');
      await driver.tap(signUpButton);
      await driver.waitFor(find.byValueKey('signup_page'));

      // Fill in the sign-up form
      final usernameField = find.byValueKey('signup_username');
      final emailField = find.byValueKey('signup_email');
      final passwordField = find.byValueKey('signup_password');
      await driver.tap(usernameField);
      await driver.enterText('testuser');
      await driver.tap(emailField);
      await driver.enterText('testuser@example.com');
      await driver.tap(passwordField);
      await driver.enterText('password123');
      
      // Submit the sign-up form
      final submitButton = find.byValueKey('signup_submit_button');
      await driver.tap(submitButton);
      await driver.waitFor(find.text('Sign Up successful!'));

      // Now go to login
      final loginButton = find.byValueKey('login_button');
      await driver.tap(loginButton);
      await driver.waitFor(find.byValueKey('login_page'));

      // Fill in login credentials
      final loginUsernameField = find.byValueKey('login_username');
      final loginPasswordField = find.byValueKey('login_password');
      await driver.tap(loginUsernameField);
      await driver.enterText('testuser');
      await driver.tap(loginPasswordField);
      await driver.enterText('password123');

      // Submit the login form
      final loginSubmitButton = find.byValueKey('login_submit_button');
      await driver.tap(loginSubmitButton);
      await driver.waitFor(find.byValueKey('home_page'));

      // Verify if the home page appears
      expect(await driver.getText(find.byValueKey('home_page')), 'Welcome to Home!');
    });
  });
}
