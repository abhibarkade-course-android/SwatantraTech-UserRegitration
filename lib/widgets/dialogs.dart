import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:swatantratech/screens/auth/sign_up.dart';

class CustomDialogs {
  // Message Dialog for Error
  static showErrorDialog(
      BuildContext context,
      String msg,
      String title,
      String buttonText,
      String lottie,
      bool isToOpen,
      MaterialPageRoute? route) {
    Dialogs.materialDialog(
      color: Colors.white,
      msg: msg,
      title: title,
      lottieBuilder: Lottie.asset(
        'assets/lottie/$lottie.json',
        fit: BoxFit.contain,
      ),
      dialogWidth: 0.3,
      context: context,
      actions: [
        IconsButton(
          onPressed: () {
            if (isToOpen) {
              Navigator.push(context, route!);
            } else {
              Navigator.of(context).pop();
            }
          },
          text: buttonText,
          iconData: Icons.done,
          color: Colors.blue,
          textStyle: TextStyle(color: Colors.white),
          iconColor: Colors.white,
        ),
      ],
    );
  }

  static showErrorDialogWithButtons(
      BuildContext context,
      String msg,
      String title,
      String buttonText,
      String lottie,
      String cancel,
      String ok) {
    Dialogs.materialDialog(
        msg: msg,
        title: title,
        color: Colors.white,
        context: context,
        dialogWidth: kIsWeb ? 0.3 : null,
        lottieBuilder: Lottie.asset(
          'assets/lottie/$lottie.json',
          fit: BoxFit.contain,
        ),
        onClose: (value) {},
        actions: [
          IconsButton(
            onPressed: () {
              Navigator.of(context).pop(['Test', 'List']);
            },
            text: cancel,
            color: Colors.blue,
            textStyle: TextStyle(color: Colors.white),
            iconData: Icons.cancel,
            iconColor: Colors.white,
          ),
          IconsButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (ctx) => SignUp()));
            },
            text: ok,
            textStyle: TextStyle(color: Colors.white),
            iconData: Icons.check,
            iconColor: Colors.white,
            color: Colors.blue,
          ),
        ]);
  }
}
