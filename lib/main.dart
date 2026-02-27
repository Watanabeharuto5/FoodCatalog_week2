import 'package:flutter/material.dart';

void main() {
  runApp(
    //membungkus aplikasi dengan ChangeNotifier agar state bisa di akses di mana saja
    ChangeNotifierProvider(
    create: (context) => CartModel(),
    child: MyApp(),
  ));


  
}


