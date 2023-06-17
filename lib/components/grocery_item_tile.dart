import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//ignore: must_be_immutable
class urun_info extends StatelessWidget {
  final String name;
  final String price;
  final String sinif;
  final String size;
  final Image resim;
  void Function()? onPressed;

  urun_info({
    super.key,
    required this.name,
    required this.price,
    required this.sinif,
    required this.size,
    required this.resim,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // item image
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 1.0),
              child: resim
            ),

            // item name
            Text(
              name + " " + sinif,
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
            Text(
              size,
              style: const TextStyle(
                fontSize: 18,
              ),
            ),

            MaterialButton(
              onPressed: onPressed,
              color: Colors.green,
              child: Text(
                price + '₺',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
