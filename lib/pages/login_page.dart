import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  late String kadi, sifre;
  final formkey = GlobalKey<FormState>();
  final fireBaseAuth = FirebaseAuth.instance;
  final authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 100, 198, 89),
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
                      "Giriş Yap",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 36,
                          color: Colors.white),
                    ),
                    SizedBox(height: 30),
                    emailTextField(),
                    SizedBox(height: 30),
                    sifreTextField(),
                    SizedBox(height: 30),
                    Row(
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(context, "/signup");
                          },
                          child: Container(
                            padding: const EdgeInsets.only(left: 0),
                            child: const Text(
                              "Hesap Oluştur",
                              style: TextStyle(
                                color: Colors.white,
                                // fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(context, "/signup");
                          },
                          child: Container(
                            padding: const EdgeInsets.only(left: 0),
                            child: const Text(
                              "Şifremi Unuttum",
                              style: TextStyle(
                                color: Colors.white,
                                // fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        anonyGiris(context),
                        girisButon(context),
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

  TextButton anonyGiris(BuildContext context) {
    return TextButton(
      onPressed: () async {
        final result = await authService.signInAnony();
        if (result != null) {
          Navigator.pushReplacementNamed(context, "/homepage");
        } else {
          print("HATA İLE KARŞILAŞILDI");
        }
      },
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: const Color.fromARGB(255, 83, 188, 83),
        ),
        child: const Text(
          "Misafir Girişi",
          style: TextStyle(
            color: Colors.white,
            // fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
    );
  }

  TextButton girisButon(BuildContext context) {
    return TextButton(
      onPressed: () async {
        if (formkey.currentState!.validate()) {
          formkey.currentState!.save();
          try{
            await fireBaseAuth.signInWithEmailAndPassword(email: kadi, password: sifre);
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => HomePage()),
                    (route) => false);
          }catch(e){
            print(e.toString());
          }
          ///final result = await authService.girisHataKontrol(kadi, sifre);
          ///if (result == "succes") {

          ///}
          ///else {
          //             showDialog(
          //                 context: context,
          //                 builder: (context) {
          //                   return  AlertDialog(
          //                     title:  Text("Hata"),
          //                     content: Text(result!),
          //                     actions: [
          //                       TextButton(
          //                           onPressed: () => Navigator.pop(context),
          //                           child: Text("Geri Dön"))
          //                     ],
          //                   );
          //                 });
          //           }
        }
      },
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: const Color.fromARGB(255, 83, 188, 83),
        ),
        child: const Text(
          "   Giriş Yap   ",
          style: TextStyle(
            color: Colors.white,
            // fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
    );
  }

  TextFormField sifreTextField() {
    return TextFormField(
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

  TextFormField emailTextField() {
    return TextFormField(
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

  InputDecoration varsayilanGiris(String gizliMetin) {
    return InputDecoration(
        hintText: gizliMetin,
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white)));
  }
}
