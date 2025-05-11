import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  const appId = 'vaQVDI4NC94mwogu6ERDoxEJoRJKQFKTd3MWh06p';
  const clientKey = 'nkIzLv8D2UW0uRA2YwkzZ3CkrXPY9F51N5kZ1hj2';
  const serverUrl = 'https://parseapi.back4app.com';

  await Parse().initialize(appId, serverUrl, clientKey: clientKey, autoSendSessionId: true, debug: true);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Back4App Auth Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: LoginPage(),
    );
  }
}
