import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:groceryapp/pages/tabBar_pages/first_tabBar_page.dart';
import 'package:groceryapp/pages/tabBar_pages/second_tabBar_page.dart';
import 'package:groceryapp/pages/tabBar_pages/third_tabBar_page.dart';
import 'package:provider/provider.dart';
import '../components/grocery_item_tile.dart';
import '../model/cart_model2.dart';
import 'cart_page.dart';
import 'package:firebase_storage/firebase_storage.dart';

FirebaseStorage storage = FirebaseStorage.instance;

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  final _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    //CollectionReference damacanaRef = _firestore.collection("damacana");
    return DefaultTabController(
      length: 3, // Toplam sekme sayısı
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: Padding(
            padding: const EdgeInsets.only(left: 24.0),
            child: Icon(
              Icons.location_on,
              color: Colors.grey[700],
            ),
          ),
          title: Text(
            'Istanbul, Cekmekoy ',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[700],
            ),
          ),
          toolbarHeight: 100,
          centerTitle: false,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 24.0),
              child: Container(
                padding: EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.person,
                  color: Colors.grey,
                ),
              ),
            ),
          ],
          bottom: TabBar(labelColor: Colors.black,
            tabs: [
              Tab(text: "${_firestore.collection("damacana").id}",icon: Icon(Icons.add_circle) ),
              Tab(text: '${_firestore.collection("PetSu").id}',icon: Icon(Icons.add_circle)),
              Tab(text: '${_firestore.collection("Diğer Çeşitler").id}',icon: Icon(Icons.add_circle)),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            FirstPage(),
            SecondPage(),
            ThirdPage(),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          backgroundColor: Colors.black,
          onPressed: () => Navigator.pushNamed(context, "/cartpage"),
          child: const Column(
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(Icons.shopping_bag),
              ),
              Text("Sepet"),
            ],
          ),
        ),
      ),
    );
  }
}
