import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cscevsev/models/user.dart';

class FirestoreDBService  {

  final String uid;
  FirestoreDBService({ this.uid });

  final CollectionReference cevCollection = Firestore.instance.collection("users");


  Future<void> UserData(String text,String email,String password,String profilURL) async {
    return await cevCollection.document(uid).setData({
      'text': text ?? '',
      'email': email,
      'password': password,
      'profilURL' : profilURL ?? 'https://www.centralchristian.edu/wp-content/uploads/2019/07/person-placeholder.png',
    });
  }

}