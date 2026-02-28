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

  // Widget Tombol Tambah (Menggunakan Provider)
  class AddButton extends StatelessWidget {
  final String item;
  const AddButton({required this.item, super.key});

  @override
  Widget build(BuildContext context) {
    // context.select memantau apakah item ini sudah ada di keranjang
    final isInCart = context.select<CartModel, bool>((cart) => cart.items.contains(item));

    return TextButton(
      onPressed: isInCart ? null : () {
        //context.read digunakan untuk memanggil fungsi tanpa mendengarkan perubahan
        context.read<CartModel>().add(item);
        },
    child: isInCart ? Icon(Icons.check, color: Colors.green,) : Text('Tambah'),
      );
    }
  }

  // Halaman Keranjang
  class MyCart extends StatelessWidget {
  const MyCart({super.key});


  @override
  Widget build(BuildContext context) {
  var cart = context.watch<CartModel>();

    return Scaffold(
            appBar: AppBar(
              title: const Text("Cart"),
              actions: const [],
            ),
            body: Container(
              padding: EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: cart.items.length,
                      itemBuilder: (context, index) => 
                        ListTile(
                          leading: Icon(Icons.fastfood), title: Text(cart.items[index]),
                      )
                    )
                  ),
                  Divider(),
                  Padding(
                    padding: EdgeInsets.all(20.0),
                    child: ElevatedButton(
                      onPressed: () => cart.removeAll(), 
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                      ),
                      child: Text('Delete Cart', style: TextStyle(color: Colors.white),)
                    )
                  )
                ],
              ),
            ),
          );
        }
      }
}
