import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../services/auth_service.dart';

class SignUpPage extends StatefulWidget {
  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _firestore = FirebaseFirestore.instance;
  TextEditingController nameController = TextEditingController();
  TextEditingController sifreController = TextEditingController();
  TextEditingController adresController = TextEditingController();
  late String kadi, sifre, adres;
  final formkey = GlobalKey<FormState>();
  final fireBaseAuth = FirebaseAuth.instance;
  AuthService authService = AuthService();
  late CollectionReference kullaniciRef = _firestore.collection("kullanicilar");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 91, 198, 89),
      body: SingleChildScrollView(
        child: Form(
          key: formkey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 210),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    const Text(
                      "Kayıt Ol",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 36,
                          color: Colors.white),
                    ),
                    SizedBox(height: 30),
                    hotmailTextField(),
                    SizedBox(height: 30),
                    sifreTextField(),
                    SizedBox(height: 30),
                    adresTextField(),
                    SizedBox(height: 40),
                    Row(
                      children: [
                        geriDonButon(context),
                        SizedBox(width: 70),
                        kayitButon(context),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  TextFormField hotmailTextField() {
    return TextFormField(
      controller: nameController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Bilgileri Eksiksiz Doldurunuz";
        } else {}
        return null;
      },
      onSaved: (value) {
        kadi = value!;
      },
      textAlign: TextAlign.center,
      decoration: varsayilanGiris("@hotmail.com"),
    );
  }

  TextFormField sifreTextField() {
    return TextFormField(
      controller: sifreController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Bilgileri Eksiksiz Doldurunuz";
        } else {}
        return null;
      },
      onSaved: (value) {
        sifre = value!;
      },
      textAlign: TextAlign.center,
      decoration: varsayilanGiris("Şifre"),
      obscureText: true,
    );
  }

  TextFormField adresTextField() {
    return TextFormField(
      controller: adresController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Bilgileri Eksiksiz Doldurunuz";
        } else {}
        return null;
      },
      onSaved: (value) {
        adres = value!;
      },
      textAlign: TextAlign.center,
      decoration: varsayilanGiris("Adres Bilginizi Giriniz"),
      obscureText: false,
    );
  }

  TextButton geriDonButon(BuildContext context) {
    return TextButton(
      onPressed: () async {
        Navigator.pop(context);
      },
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: const Color.fromARGB(255, 83, 188, 83),
        ),
        child: const Text(
          "Geri Dön",
          style: TextStyle(
            color: Colors.white,
            // fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
    );
  }

  TextButton kayitButon(BuildContext context) {
    return TextButton(
      onPressed: () async {
        AuthService().registerUser(kadi: nameController.text, sifre: sifreController.text, adres: adresController.text);
        Map<String, dynamic> userData = {
          "name": nameController.text,
          "sifre": sifreController.text,
          "adres": adresController.text
        };
        await kullaniciRef.doc(nameController.text).set(userData);
        if (formkey.currentState!.validate()) {
          formkey.currentState!.save();
          try {
            await fireBaseAuth.createUserWithEmailAndPassword(
              email: kadi,
              password: sifre,
            );
            formkey.currentState!.reset();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Kayıt İşlemi Başarılı"),
              ),
            );

            Navigator.pushReplacementNamed(context, "/loginpage");
          } catch (e) {
            print(e.toString());
          }
        }
      },
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: const Color.fromARGB(255, 83, 188, 83),
        ),
        child: const Text(
          "Kayıt Ol",
          style: TextStyle(
            color: Colors.white,
            // fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
    );
  }

  InputDecoration varsayilanGiris(String gizliMetin) {
    return InputDecoration(
        hintText: gizliMetin,
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)));
  }
}
