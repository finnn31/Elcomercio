import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = 'http://192.168.18.216/api';

  // Fungsi untuk login admin dan user
  Future<Map<String, dynamic>> login(String email, String password, String role) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login.php'),
      body: {
        'email': email,
        'password': password,
        'role': role, // Mengirimkan role untuk membedakan login
      },
    );
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['success']) {
        return data['user']; // Menggunakan 'user' sebagai respons untuk role user/admin
      } else {
        throw Exception(data['message']);
      }
    } else {
      throw Exception('Failed to login');
    }
  }
  //fungsi untuk mengambil data user
  Future<List<dynamic>> fetchUsers() async {
    final response = await http.get(Uri.parse('$baseUrl/users/get_user.php'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load users');
    }
  }
  //fungsi untuk delete user
  Future<void> deleteUser(String id) async {
    final response = await http.post(Uri.parse('$baseUrl/users/delete_user.php'), body: {'id': id});
    if (response.statusCode != 200) {
      throw Exception('Failed to delete user');
    }
  }
  //fungsi untuk tambah user
  Future<void> addUser(String name, String email, String password) async {
    final response = await http.post(Uri.parse('$baseUrl/users/add_user.php'), body: {
      'name': name,
      'email': email,
      'password': password,
    });
    if (response.statusCode != 200) {
      throw Exception('Failed to add user');
    }
  }
  //fungsi untuk edit user
  Future<void> updateUser(String id, String name, String email, String password) async {
    final response = await http.post(Uri.parse('$baseUrl/users/update_user.php'), body: {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
    });
    if (response.statusCode != 200) {
      throw Exception('Failed to update user');
    }
  }

  // Fungsi untuk mengambil data produk
  Future<List<dynamic>> fetchProducts() async {
    final response = await http.get(Uri.parse('$baseUrl/products/get_products.php'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load products');
    }
  }

  // Fungsi untuk menambah produk
  Future<void> addProduct(String id, String name, double price, int stock) async {
    final response = await http.post(
      Uri.parse('$baseUrl/products/add_product.php'),
      body: {
        'id': id,
        'name': name,
        'price': price.toString(),
        'stock': stock.toString(),
      },
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to add product');
    }
  }

  // Fungsi untuk memperbarui produk
  Future<void> updateProduct(String id, String name, double price, int stock) async {
    final response = await http.post(
      Uri.parse('$baseUrl/products/update_product.php'),
      body: {
        'id': id,
        'name': name,
        'price': price.toString(),
        'stock': stock.toString(),
      },
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to update product');
    }
  }

  // Fungsi untuk menghapus produk
  Future<void> deleteProduct(String id) async {
    final response = await http.post(
      Uri.parse('$baseUrl/products/delete_product.php'),
      body: {'id': id},
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to delete product');
    }
  }
}
