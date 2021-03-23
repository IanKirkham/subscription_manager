import 'package:flutter/material.dart';

import 'app.dart';

void main() {
  runApp(Main());
}

class Main extends StatefulWidget {
  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: App(),
      theme: _theme(),
    );
  }
}

ThemeData _theme() {
  return ThemeData(
      // primarySwatch: Colors.blue,
      // visualDensity: VisualDensity.adaptivePlatformDensity,
      // scaffoldBackgroundColor: Color(0xFF1F2C34),
      // bottomNavigationBarTheme: BottomNavigationBarThemeData(
      //   backgroundColor: Color(0xFF2F3D46),
      //   selectedItemColor: Colors.white,
      //   unselectedItemColor: Color(0xFF788388),
      //   showUnselectedLabels: true,
      //   type: BottomNavigationBarType.fixed,
      //   elevation: 10,
      // ),
      );
}
