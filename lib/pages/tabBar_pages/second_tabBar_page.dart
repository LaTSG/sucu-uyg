import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../components/grocery_item_tile.dart';
import '../../model/cart_model2.dart';

class SecondPage extends StatelessWidget {
  SecondPage({Key? key}) : super(key: key);
  final _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    CollectionReference petRef = _firestore.collection("PetSu");
    return StreamBuilder<QuerySnapshot>(
      stream: petRef.snapshots(),
      builder: (BuildContext contex, AsyncSnapshot asyncSnapshot) {
        ///   List<DocumentSnapshot> listOfDocSnap = asyncSnapshot.data.docs;
        ///   List<DocumentSnapshot> listOfDocSnap = asyncSnapshot.data!.docs.map((doc) => doc as DocumentSnapshot).toList();
        if (asyncSnapshot.hasError) {
          return Center(child: Text("Error: ${asyncSnapshot.error}"));
        } else {
          if (asyncSnapshot.hasData) {
            //List<DocumentSnapshot> listOfDocSnap = asyncSnapshot.data.docs;
            return Scaffold(
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: StreamBuilder<QuerySnapshot>(
                      stream: _firestore.collection('PetSu').snapshots(),
                      builder: (context, snapshot) {
                        if (asyncSnapshot.hasError) {
                          // Hata durumunu burada işleyin
                          return Center(
                              child: Text("Hata: ${asyncSnapshot.error}"));
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
