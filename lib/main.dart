import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:groceryapp/model/cart_model2.dart';
import 'package:groceryapp/pages/cart_page.dart';
import 'package:groceryapp/pages/home_page.dart';
import 'package:groceryapp/pages/login_page.dart';
import 'package:groceryapp/pages/payment.dart';
import 'package:groceryapp/pages/sign_up_page.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'pages/intro_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    ChangeNotifierProvider(
      create: (BuildContext context) => CartItems(),
      child:  MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        "/loginpage": (context) => LoginPage(),
        "/signup": (context) => SignUpPage(),
        "/cartpage": (context) => CartPage(),
        "/homepage": (context) => HomePage(),
        "/paymentpage":(context) => PaymentPage()

      },
      home: IntroScreen(),
    );
  }
}