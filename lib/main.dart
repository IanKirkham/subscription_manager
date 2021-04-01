import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:subscription_manager/data.dart';

import 'app.dart';
import 'widgets/subscriptionsNotifier.dart';

final subscriptionsProvider = StateNotifierProvider<SubscriptionsList>(
    (ref) => SubscriptionsList(subscriptions));

void main() {
  runApp(ProviderScope(child: Main()));
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
      debugShowCheckedModeBanner: false,
      theme: _theme(),
      //theme: ThemeData.dark(),
    );
  }
}

ThemeData _theme() {
  return ThemeData(
    colorScheme: ColorScheme.highContrastDark(),
    accentColor: Color(0xFFBB86FC),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      foregroundColor: Colors.white,
      backgroundColor: Color(0xFFBB86FC),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.grey[900],
      selectedItemColor: Colors.white,
    ),
    fontFamily: GoogleFonts.montserrat().fontFamily,
    textTheme: TextTheme(
        headline6: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
        button: TextStyle(fontSize: 16)),
  );
}
