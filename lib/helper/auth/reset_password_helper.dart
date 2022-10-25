import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../widgets/dialogs.dart';

class ResetPasswordHelper {
  static resetPassword(BuildContext context, String email, String newPass,
      TextEditingController emailController) async {
    await FirebaseAuth.instance
        .sendPasswordResetEmail(email: email)
        .whenComplete(() {
      CustomDialogs.showErrorDialog(
          context,
          "Password reset link has sent to \n$email",
          '',
          'OK',
          'msg_sent_anim',
          false,
          null);
      emailController.clear();
    });
  }
}
