import 'package:flutter/material.dart';

class DrawerMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Text('Elcomercio Admin'),
            decoration: BoxDecoration(color: Colors.blue),
          ),
          ListTile(
            title: Text('Dashboard'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/dashboard');
            },
          ),
          ListTile(
            title: Text('Manage Products'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/manage-products');
            },
          ),
          ListTile(
            title: Text('Settings'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/settings');
            },
          ),
        ],
      ),
    );
  }
}
