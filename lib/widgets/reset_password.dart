import 'package:flutter/material.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:swatantratech/helper/auth/reset_password_helper.dart';

import 'dialogs.dart';

class ResetPassword {
  static TextEditingController _emailController = TextEditingController();

  static reset(BuildContext context) {
    Dialogs.bottomMaterialDialog(
      msg: 'Enter your registered email above to reset the password',
      color: Colors.white,
      context: context,
      customView: Container(
        margin: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
        child: TextField(
          keyboardType: TextInputType.emailAddress,
          maxLines: 1,
          controller: _emailController,
          decoration: InputDecoration(
            hintText: 'Reset Password',
            prefixIcon: Icon(Icons.mail),
          ),
        ),
      ),
      actions: [
        IconsButton(
          onPressed: () {
            if (_emailController.text.isNotEmpty) {
              ResetPasswordHelper.resetPassword(
                  context, _emailController.text, 'abc',_emailController);
              _emailController.clear();
            } else {
              CustomDialogs.showErrorDialog(
                  context,
                  "Please enter a valid email address",
                  'Invalid Email',
                  'OK',
                  'invalid_anim',
                  false,
                  null);
            }
          },
          text: 'Send Link',
          iconData: Icons.done,
          color: Colors.blue,
          textStyle: TextStyle(color: Colors.white),
          iconColor: Colors.white,
        ),
      ],
    );
  }
}
