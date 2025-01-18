import 'package:flutter/material.dart';
import '../widgets/drawer_menu.dart';
import '../services/api_service.dart';  // Untuk pengambilan data pengguna
import 'user_form_screen.dart';  // Form untuk tambah dan edit pengguna

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List users = [];

  @override
  void initState() {
    super.initState();
    _fetchUsers();
  }

  Future<void> _fetchUsers() async {
    try {
      final data = await ApiService().fetchUsers();  // Ambil data user dari API
      setState(() {
        users = data;
      });
    } catch (e) {
      print('Failed to load users: $e');
    }
  }

  void _deleteUser(String id) async {
    try {
      await ApiService().deleteUser(id);  // Hapus user dari API
      _fetchUsers();  // Refresh data setelah penghapusan
    } catch (e) {
      print('Failed to delete user: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
      drawer: DrawerMenu(),
      body: users.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          return Card(
            margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: ListTile(
              title: Text(user['name']),
              subtitle: Text('Email: ${user['email']}'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UserFormScreen(user: user),
                        ),
                      ).then((_) => _fetchUsers());
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => _deleteUser(user['id']),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
