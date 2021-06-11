import 'dart:io';
import 'package:chat_max/data/remote/firebase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

abstract class AuthRepo {
  Future<void> userLogin(String email, String password);

  Future<void> userRegister(
      String email, String name, String password, File image);

}

class AuthRepository extends AuthRepo {
  late UserCredential userCredential;

  @override
  Future userLogin(String email, String password) async {
    try {
      userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email.toString().trim(), password: password.toString().trim());
    } catch (error) {
      print(error.toString());
    }
  }

  @override
  Future userRegister(
      String email, String name, String password, File image) async {
    try {
      userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: email.trim(), password: password.trim());
      final ref = FirebaseStorage.instance
          .ref()
          .child('user_image')
          .child('${userCredential.user?.uid} .jpg');

      await ref.putFile(image);

      final url = await ref.getDownloadURL();
      FireBaseHelper()
          .setDataToFireBase(userCredential.user?.uid, email, name, url);
    } catch (error) {
      print(error.toString());
    }
  }
}

class NetworkError extends Error {}
