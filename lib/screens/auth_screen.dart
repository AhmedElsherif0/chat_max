import 'dart:io';

import 'file:///C:/Users/ahmed/AndroidStudioProjects/chat_max/lib/widgets/auth/auth_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;
  var _isLoading = false;

  void _submitAuthForm(String email, String name, String password, File image,
      bool isLogin, BuildContext ctx) async {
    try {
      _isLoadingMounted(true);
      UserCredential userCredential;
      if (isLogin) {
        userCredential = await _auth.signInWithEmailAndPassword(
            email: email.toString().trim(), password: password.toString().trim());
      } else {
        userCredential = await _auth.createUserWithEmailAndPassword(
            email: email.trim(), password: password.trim());
      }

      final ref = FirebaseStorage.instance
          .ref()
          .child('user_image')
          .child('${userCredential.user?.uid} .jpg');

      await ref.putFile(image);

      final url = await ref.getDownloadURL();

      _setDataToFireBase(userCredential.user?.uid, email, name, url);

    } on PlatformException catch (error) {
      var message = 'An error occurred';
      if (error.message != null) {
        message = error.message??'an error occurred';
      }
      customSnackBar(ctx, message.toString(), message.toString());
      print(message.toString());
    } catch (error) {
      customSnackBar(ctx, error.toString(), error.toString());
      print(error.toString());
    }
    _isLoadingMounted(false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: AuthForm(
        submit: _submitAuthForm,
        isLoading: _isLoading,
      ),
    );
  }

  bool _isLoadingMounted(value) {
    if (this.mounted) {
      setState(() {
        _isLoading = value;
      });
    }
    return false;
  }

  void customSnackBar(BuildContext ctx, String content, String logError) {
    ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
        backgroundColor: Colors.pink[300],
        content: Text(
          content,
          textAlign: TextAlign.center,
        ),
        duration: const Duration(seconds: 3)));
    print(logError);
  }

  Future<void> _setDataToFireBase(userCredential, email, name, url) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userCredential)
        .set({'email': email, 'name': name, 'userImage': url});
  }
}
