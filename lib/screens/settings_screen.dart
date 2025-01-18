import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  final Function(bool) onToggleTheme;
  final bool isDarkMode;

  SettingsScreen({required this.onToggleTheme, required this.isDarkMode});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/dashboard');
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Dark Mode'),
            Switch(
              value: isDarkMode,
              onChanged: (value) {
                onToggleTheme(value);
              },
            ),
          ],
        ),
      ),
    );
  }
}
