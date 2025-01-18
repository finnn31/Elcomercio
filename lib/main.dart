import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/dashboard_screen.dart';
import 'screens/manage_products_screen.dart';
import 'screens/settings_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Elcomercio Admin',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginScreen(),
        '/dashboard': (context) => DashboardScreen(),
        '/manage-products': (context) => ManageProductsScreen(),
        '/settings': (context) => SettingsScreen(
          onToggleTheme: (bool value) {
            setState(() {
              isDarkMode = value;
            });
          },
          isDarkMode: isDarkMode,
        ),
      },
    );
  }
}
