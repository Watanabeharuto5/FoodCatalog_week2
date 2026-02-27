import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => CartModel(),
    child: MyApp(),
  ));
}

class CartModel extends ChangeNotifier {
  final List<String> _items = [];
  
  List<String> get items => _items;

  void add(String itemName){
    items.add(itemName);
    notifyListeners();
  }

  void removeAll(){
    items.clear();
    notifyListeners();
  }
}


