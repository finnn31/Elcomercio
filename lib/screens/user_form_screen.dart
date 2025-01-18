import 'package:flutter/material.dart';
import '../services/api_service.dart';

class UserFormScreen extends StatefulWidget {
  final Map<String, dynamic>? user;

  UserFormScreen({this.user});

  @override
  _UserFormScreenState createState() => _UserFormScreenState();
}

class _UserFormScreenState extends State<UserFormScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.user != null) {
      nameController.text = widget.user!['name'];
      emailController.text = widget.user!['email'];
      passwordController.text = ''; // Kosongkan password untuk alasan keamanan
    }
  }

  void _saveUser() async {
    final name = nameController.text;
    final email = emailController.text;
    final password = passwordController.text;

    if (name.isEmpty || email.isEmpty || (widget.user == null && password.isEmpty)) {
      _showDialog('Semua kolom harus diisi!');
      return;
    }

    try {
      if (widget.user == null) {
        await ApiService().addUser(name, email, password);
      } else {
        await ApiService().updateUser(widget.user!['id'], name, email, password);
      }
      Navigator.pop(context, true); // Kembali dan refresh data
    } catch (e) {
      _showDialog('Gagal menyimpan pengguna: $e');
    }
  }

  void _showDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Info'),
        content: Text(message),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text('OK')),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.user == null ? 'Tambah Pengguna' : 'Edit Pengguna')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: nameController, decoration: InputDecoration(labelText: 'Nama')),
            TextField(controller: emailController, decoration: InputDecoration(labelText: 'Email')),
            TextField(controller: passwordController, decoration: InputDecoration(labelText: 'Password'), obscureText: true),
            SizedBox(height: 20),
            ElevatedButton(onPressed: _saveUser, child: Text('Simpan')),
          ],
        ),
      ),
    );
  }
}
