import 'package:flutter/material.dart';
import '../services/api_service.dart';

class ManageProductsScreen extends StatefulWidget {
  @override
  _ManageProductsScreenState createState() => _ManageProductsScreenState();
}

class _ManageProductsScreenState extends State<ManageProductsScreen> {
  List products = [];

  @override
  void initState() {
    super.initState();
    _fetchProducts();
  }

  Future<void> _fetchProducts() async {
    final data = await ApiService().fetchProducts();
    setState(() {
      products = data;
    });
  }

  Future<void> _showProductForm({Map? product}) async {
    final idController = TextEditingController(text: product?['id'] ?? '');
    final nameController = TextEditingController(text: product?['name'] ?? '');
    final priceController = TextEditingController(text: product?['price'] ?? '');
    final stockController = TextEditingController(text: product?['stock'] ?? '');

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(product == null ? 'Tambah Produk' : 'Edit Produk'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: idController, decoration: InputDecoration(labelText: 'ID Produk')),
            TextField(controller: nameController, decoration: InputDecoration(labelText: 'Nama')),
            TextField(controller: priceController, decoration: InputDecoration(labelText: 'Harga')),
            TextField(controller: stockController, decoration: InputDecoration(labelText: 'Stok')),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text('Batal')),
          TextButton(
            onPressed: () async {
              final id = idController.text;
              final name = nameController.text;
              final price = double.tryParse(priceController.text) ?? 0;
              final stock = int.tryParse(stockController.text) ?? 0;

              if (product == null) {
                await ApiService().addProduct(id, name, price, stock);
              } else {
                await ApiService().updateProduct(id, name, price, stock);
              }
              Navigator.pop(context);
              _fetchProducts();
            },
            child: Text('Simpan'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Products'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/dashboard');
          },
        ),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () => _showProductForm(),
            child: Text('Tambah Produk'),
          ),
          Expanded(
            child: products.isEmpty
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return ListTile(
                  title: Text(product['name']),
                  subtitle: Text('Harga: Rp ${product['price']} - Stok: ${product['stock']}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () => _showProductForm(product: product),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () async {
                          await ApiService().deleteProduct(product['id']);
                          _fetchProducts();
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
