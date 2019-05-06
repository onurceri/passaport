import 'package:flutter/material.dart';
import 'package:passaport/screens/authentication.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Passaport',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AuthenticationPage(),
    );
  }
}