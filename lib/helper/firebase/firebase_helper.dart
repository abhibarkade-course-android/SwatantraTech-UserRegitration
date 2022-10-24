import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:swatantratech/helper/firebase/user_details.dart';


class AddUsersDetails {
  static addUser(BuildContext context, UserDetails userDetails) async {
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(userDetails.name)
        .set(userDetails.toJson());
  }
}
