import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../../components/grocery_item_tile.dart';
import '../../model/cart_model2.dart';

class FirstPage extends StatelessWidget {
  FirstPage({Key? key}) : super(key: key);
  final _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    CollectionReference damacanaRef = _firestore.collection("damacana");
    return StreamBuilder<QuerySnapshot>(
      stream: damacanaRef.snapshots(),
      builder: (BuildContext contex, AsyncSnapshot asyncSnapshot) {
        if (asyncSnapshot.hasError) {
          return Center(child: Text("Error: ${asyncSnapshot.error}"));
        } else {
          if (asyncSnapshot.hasData) {
            return Scaffold(
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: StreamBuilder<QuerySnapshot>(
                      stream: _firestore.collection('damacana').snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Center(
                              child: Text("Hata: ${snapshot.error}"));
                        } else if (snapshot.hasData) {
                          List<Widget> widgets = [];
                          snapshot.data!.docs.forEach((doc) {
                            String name = doc['name'];
                            String price = doc['price'];
                            String size = doc['size'];
                            String sinif = doc["sinif"];

                            Reference storageReference = FirebaseStorage.instance.ref().child('${doc['resim']}');

                            widgets.add(FutureBuilder<String>(
                              future: storageReference.getDownloadURL(),
                              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                                if (snapshot.connectionState == ConnectionState.waiting) {
                                  return CircularProgressIndicator();
                                } else if (snapshot.hasError) {
                                  return Text('Error: ${snapshot.error}');
                                } else {
                                  return urun_info(
                                    name: name,
                                    price: price,
                                    size: size,
                                    sinif: sinif,
                                    resim: Image.network(snapshot.data!),
                                    onPressed: () {
                                      Provider.of<CartItems>(context, listen: false)
                                          .cartListeEkle({
                                        "name": name,
                                        "price": price,
                                        "size": size,
                                        "sinif": sinif
                                      });
                                      print(CartItems().cartItems);
                                    },
                                  );
                                }
                              },
                            ));
                          });

                          return GridView.count(
                            crossAxisCount: 2,
                            childAspectRatio: 1 / 1.5,
                            children: widgets,
                          );
                        } else {
                          return CircularProgressIndicator();
                        }
                      },
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        }
      },
    );
  }
}




