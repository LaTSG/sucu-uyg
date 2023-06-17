import 'package:flutter/material.dart';
import 'package:groceryapp/model/cart_model2.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
void addToFirebase(List<Map<String, dynamic>> cartItems) {
  CollectionReference ordersRef = FirebaseFirestore.instance.collection('orders');

  cartItems.forEach((item) {
    ordersRef.add(item)
        .then((value) => print('Ürün eklendi: $value'))
        .catchError((error) => print('Ürün eklenirken hata oluştu: $error'));
  });
}
class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.grey[800],
        ),
      ),
      body: Consumer<CartItems>(
        builder: (context, dataProvider, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Let's order fresh items for you
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.0),
                child: Text(
                  "Ödeme",
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              // list view of cart
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: ListView.builder(
                    itemCount: dataProvider.cartItems.length,
                    padding: EdgeInsets.all(12),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(8)),
                          child: ListTile(
                            title: Text(
                              dataProvider.cartItems[index]["name"] +" "+dataProvider.cartItems[index]["sinif"]+" "+dataProvider.cartItems[index]["size"],
                              style: const TextStyle(fontSize: 20),
                            ),
                            subtitle: Text(
                              dataProvider.cartItems[index]["price"] + '₺' ,
                              style: const TextStyle(fontSize: 18),
                            ),
                            trailing: IconButton(
                                icon: const Icon(Icons.cancel),
                                onPressed: () =>
                                    Provider.of<CartItems>(context, listen: false)
                                    .cartListeSil(index),
                          ),
                        ),
                      ),
                      );
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(36.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.green,
                  ),
                  padding: const EdgeInsets.all(24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Ödenecek Tutar',
                            style: TextStyle(color: Colors.green[200]),
                          ),

                          const SizedBox(height: 8),
                          // total price
                          Text(
                            '\₺${dataProvider.ToplamHesapla()}',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),

                      // pay now
                      TextButton(
                        onPressed: () {
                            addToFirebase(dataProvider.cartItems);
                            // Diğer işlemler

                          /*Navigator.pushNamed(
                              context, "/paymentpage");*/
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.green.shade200),
                            borderRadius: BorderRadius.circular(28),
                          ),
                          padding: const EdgeInsets.all(12),
                          child: const Row(
                            children: [
                              Text(
                                'Ödeme',
                                style: TextStyle(color: Colors.white),
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: 16,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
