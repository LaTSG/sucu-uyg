import 'package:flutter/material.dart';
import 'package:groceryapp/pages/home_page.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({Key? key}) : super(key: key);

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  List<String> paymentLabels = ["Paypal", "MasterCard","Kapıda Ödeme(Nakit)","Kapıda Ödeme(Kredi Kartı)"];
  int value = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 90,
        forceMaterialTransparency: true,
        centerTitle: true,
        title: Text("ÖDEME YÖNTEMİ", style: TextStyle(color: Color(0xFF53BC53))),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xFF53BC53)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              itemCount: paymentLabels.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Radio(
                    onChanged: (i) => setState(() => value = i!),
                    activeColor: Color(0xFF53BC53),
                    value: index,
                    groupValue: value,

                    ///  onChanged: (i) => setState(() => value = i),
                  ),
                  title: Text(
                    paymentLabels[index],
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),

                  /// trailing: Icon(paymentIcons[index], color: kPrimaryColor),
                );
              },
              separatorBuilder: (context, index) {
                return Divider();
              },
            ),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => HomePage(),
              ),
            ),
            child: Container(
              width: 350,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: const Color.fromARGB(255, 83, 188, 83),
              ),
              child: const Center(
                child: Text(
                  "ÖDEME YAP",
                  style: TextStyle(
                    color: Colors.white,
                    // fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
