import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:swatantratech/screens/home/home.dart';

import '../widgets/dialogs.dart';

class SignInHelper {
  static signIn(BuildContext context, String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password)
          .whenComplete(() {
        if (FirebaseAuth.instance.currentUser != null) {
          showToast('Login Successful',
              position: ToastPosition.bottom, backgroundColor: Colors.black54);
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (ctx) => Home()), (route) => false);
        } else {
          showToast('',
              position: ToastPosition.bottom, backgroundColor: Colors.black54);
        }
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        CustomDialogs.showErrorDialogWithButtons(
            context,
            "Would you like to create a new account",
            'No User Found',
            'Create Account',
            'invalid_anim',
            'Cancel',
            'OK');
      } else if (e.code == 'wrong-password') {
        CustomDialogs.showErrorDialog(
            context,
            "Please check you password and try again",
            'Incorrect Password',
            'Try Again',
            'invalid_anim',
            false,
            null);
      }
    }
  }
}
