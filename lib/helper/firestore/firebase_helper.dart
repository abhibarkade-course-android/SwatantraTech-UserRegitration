import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:swatantratech/helper/firestore/user_details.dart';

class AddUsersDetails {
  static addUser(BuildContext context, UserDetails userDetails,String name) async {
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(name)
        .set(userDetails.toJson());
  }
}
