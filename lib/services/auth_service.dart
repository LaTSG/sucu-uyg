import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final firebaseAuth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  final userCollection = FirebaseFirestore.instance.collection("users");

  Future<void> registerUser(
      {required String kadi, required String sifre, required String adres}) async {
    await userCollection.doc().set({"kadi": kadi, "sifre": sifre, "adres": adres});
  }

  Future signInAnony() async {
    try {
      final result = await firebaseAuth.signInAnonymously();
      print(result.user!.uid);
      return result.user;
    } catch (e) {
      print("Anon error $e");
      return null;
    }
  }

  Future<String?> girisHataKontrol(String kadi, String sifre) async {
    String? res;
    try {
      final result = await firebaseAuth.signInWithEmailAndPassword(
          email: kadi, password: sifre);
      res = "succes";
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        res = "Kullanıcı Bulunamadı";
      } else if (e.code == "wrong-password") {
        res = "Şifre Yanlış";
      } else if (e.code == "user-disabled") {
        res = "Kullanıcı Bloke Edlimiş";
      }
    }
  }

  void kullaniciBilgileriniKaydet(String kadi, String sifre) async {
    await _firestore.collection('kullanicilar').add({
      'kadi': kadi,
      'sifre': sifre,
    });
  }
}
