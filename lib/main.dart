import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    // Membungkus aplikasi dengan ChangeNotifier agar State bisa di akses dimana saja
    ChangeNotifierProvider(
    create: (context) => CartModel(),
    child: MyApp(),
  ));
}

// 1. State Model (business logic)---
class CartModel extends ChangeNotifier {
  final List<String> _items = [];
  
  List<String> get items => _items;

  void add(String itemName){
    items.add(itemName);
    //perhatikan code ini memberitahu UI untuk update!
    notifyListeners();
  }

  void removeAll(){
    items.clear();
    notifyListeners();
  }
}

// 2. UI Layer
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/' : (context) => const MyCatalog(),
        '/cart' : (context) => const MyCart(),
      },
    );
  }

  //Halaman Catalog
  class MyCatalog extends StatelessWidget {
  const MyCatalog({super.key});

  @override
  Widget build(BuildContext context) {
    final products = ['Nasi Goreng', 'Sate Ayam', 'Ayam Bakar', 'kopi'];

    return Scaffold(
      appBar: AppBar(
        title: Text('Menu'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/cart');
            },
            icon: const Icon(Icons.shopping_cart),
          )
        ],
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(products[index]),
            trailing: AddButton(item: products[index],),
          );
        },
      ),
    );
  }
}
}
