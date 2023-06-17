import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class CartModel extends ChangeNotifier {

  /*
  final _firestore = FirebaseFirestore.instance;
  late CollectionReference damacanaRef = _firestore.collection("damacana");
  late var kaylaRef = damacanaRef.doc("KaylaSu");
  */

  // list of items on sale

  final List _shopItems = const [
    // [ itemName, itemPrice, imagePath, color ]
    ["Kayla Su", "40", "lib/images/kayla.png", Colors.green],
    ["Elmacık Su", "45", "lib/images/elmacik.png", Colors.green],
    ["Aqua Koçbey Su", "35", "lib/images/kocbey.png", Colors.green],
    ["Kovanpınar Su", "35", "lib/images/kovanpinar.png", Colors.green],
    ["Kovanpınar Su", "35", "lib/images/kovanpinar.png", Colors.green]

  ];

  // list of cart items
  List _cartItems = [];

  get cartItems => _cartItems;

  get shopItems => _shopItems;

  // add item to cart
  void addItemToCart(int index) {
    _cartItems.add(_shopItems[index]);
    notifyListeners();
  }

  // remove item from cart
  void removeItemFromCart(int index) {
    _cartItems.removeAt(index);
    notifyListeners();
  }

  // calculate total price
  String calculateTotal() {
    double totalPrice = 0;
    for (int i = 0; i < cartItems.length; i++) {
      totalPrice += double.parse(cartItems[i][1]);
    }
    return totalPrice.toStringAsFixed(2);
  }
}




/*
class CartModel extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late CollectionReference _itemsCollection = _firestore.collection("damacana");
  late List<Map<String, dynamic>> _shopItems = [];

  List<Map<String, dynamic>> get shopItems => _shopItems;
  List selectedItems = [];
  Future<void> fetchItemsFromDatabase() async {
    try {
      QuerySnapshot querySnapshot = await _itemsCollection.get();
      List<Map<String, dynamic>> items = [];
      querySnapshot.docs.forEach((doc) {
        items.add(doc.data() as Map<String, dynamic>);
      });
      _shopItems = items;
      notifyListeners();
    } catch (error) {
      // Handle error
    }
  }
}
*/
