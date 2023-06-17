import 'package:flutter/material.dart';

class CartItems extends ChangeNotifier{

   List<Map<String, dynamic>> cartItems = [];

   void cartListeEkle(Map<String, dynamic> snapshot) {
    cartItems.add(snapshot);
    notifyListeners();
  }

   void cartListeSil(int index) {
     cartItems.removeAt(index);
    notifyListeners();
  }

  String ToplamHesapla(){
    double toplamHesap = 0;
    for (int i = 0; i< cartItems.length; i++){
      toplamHesap += double.parse(cartItems[i]["price"]);
    }
    return toplamHesap.toStringAsFixed(2);
  }
/*
  String calculateTotal() {
    double totalPrice = 0;
    for (int i = 0; i < cartItems.length; i++) {
      totalPrice += double.parse(cartItems[i][1]);
    }
    return totalPrice.toStringAsFixed(2);
  }
*/
// Diğer fonksiyonlar veya sınıflar
}


