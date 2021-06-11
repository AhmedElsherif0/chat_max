import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FireBaseHelper {
  Future<void> setDataToFireBase(userCredential, email, name, url) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userCredential)
        .set({'email': email, 'name': name, 'userImage': url});
  }

  Future<UserCredential> signInFireBase(String email, String password) async {
    final userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    return userCredential;
  }

  Future<UserCredential> signUpFireBase(String email, String password) async {
    final userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    return userCredential;
  }

  Future storeImageFireBase(UserCredential userCredential)async{
    FirebaseStorage.instance
        .ref()
        .child('user_image')
        .child('${userCredential.user?.uid} .jpg');
  }


  Future getUserName(String user)async{
   await FirebaseFirestore.instance.collection('users').doc(user).get();
  }
  Future addUserData(String enteredMessage,String userUID,name,userImage)async{
   await FirebaseFirestore.instance.collection('chat').add({
      'text': enteredMessage,
      'createdAt': Timestamp.now(),
      'userId': userUID,
      'username': name,
      'userImage': userImage
    });
  }


}
