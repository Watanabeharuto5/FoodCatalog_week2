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


}
