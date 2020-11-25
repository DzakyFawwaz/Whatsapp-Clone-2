import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/foundation.dart';

class DBService {
  static CollectionReference user =
      FirebaseFirestore.instance.collection("user");

  static Future<void> createOrDeleteUser(String id,
      {String name, String ava, String email, String password}) async {
    await user
        .doc()
        .set({'nama': name, 'ava': ava, 'email': email, 'password': password});
  }

  static Future<DocumentSnapshot> getUser(String id) async {
    return await user.doc(id).get();
  }

  static Future<void> deleteUser(String id) async {
    await user.doc(id).delete();
  }

  static Future getByUsername(String name) async {
    return await FirebaseFirestore.instance
        .collection("user")
        .where("nama", isEqualTo: name)
        .get();
  }

  static Future createChatRoom(String chatRoomID, chatRoomMap) async {
    return await FirebaseFirestore.instance.collection("ChatRoom").doc(chatRoomID).set(chatRoomMap).catchError((e){
      print(e.toString());
    });

  }
}
