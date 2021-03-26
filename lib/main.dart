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
      //theme: ThemeData.dark(),
    );
  }
}

ThemeData _theme() {
  return ThemeData(
    colorScheme: ColorScheme.dark(),
    accentColor: Color(0xFFBB86FC),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      foregroundColor: Colors.white,
      backgroundColor: Color(0xFFBB86FC),
    ),
    // primarySwatch: Colors.blue,
    // visualDensity: VisualDensity.adaptivePlatformDensity,
    // scaffoldBackgroundColor: Color(0xFF1F2C34),
    // bottomNavigationBarTheme: BottomNavigationBarThemeData(
    //   selectedItemColor: Colors.white,
    //   showUnselectedLabels: true,
    //   elevation: 10,
    // ),
  );
}
