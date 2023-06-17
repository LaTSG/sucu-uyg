import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../components/grocery_item_tile.dart';
import '../../model/cart_model2.dart';

class ThirdPage extends StatelessWidget {
  ThirdPage({Key? key}) : super(key: key);
  final _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    CollectionReference digerCesRef = _firestore.collection("Diger");
    return StreamBuilder<QuerySnapshot>(
      stream: digerCesRef.snapshots(),
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
                      stream: _firestore.collection('Diger').snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Center(
                              child: Text("Hata: ${snapshot.error}"));
                        } else if (snapshot.hasData) {
                          List<Widget> widgets = [];
                          snapshot.data!.docs.forEach((doc) {
                            print("hata" + doc.data().toString());
                            String name = doc['name'];
                            String price = doc['price'];
                            String size = doc['size'];
                            String sinif = doc["sinif"];

                            Reference mesrubatReference = FirebaseStorage.instance.ref().child('${doc['resim']}');

                            widgets.add(FutureBuilder<String>(
                              future: mesrubatReference.getDownloadURL(),
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


