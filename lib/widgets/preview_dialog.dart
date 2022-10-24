import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:swatantratech/helper/firebase/user_details.dart';
import 'package:swatantratech/utilities/dimensions.dart';

class PreviewDialog {
  static showErrorDialogWithButtons(
      BuildContext context,
      UserDetails userDetails,
      String msg,
      String buttonText,
      String cancel,
      String ok,
      bool isRoute,
      MaterialPageRoute? route) {
    Dialogs.materialDialog(
        msg: msg,
        color: Colors.white,
        context: context,
        dialogWidth: 0.3,
        onClose: (value) {},
        customView: Container(
          margin: EdgeInsets.only(
              left: Dimensions.h16, right: Dimensions.h16, top: Dimensions.h16),
          width: double.maxFinite,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: SizedBox(
                  width: Dimensions.h120,
                  height: Dimensions.h120,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(Dimensions.r150),
                    child: Image.file(
                      File(userDetails.url),
                    ),
                  ),
                ),
              ),
              SizedBox(height: Dimensions.h8),
              Text(
                'Name : ${userDetails.name}',
                style: TextStyle(fontSize: 16),
              ),
              Text(
                'Birth Date : ${userDetails.bod}',
                style: TextStyle(fontSize: 16),
              ),
              Text(
                'Gender : ${userDetails.gender}',
                style: TextStyle(fontSize: 16),
              ),
              Text(
                'Pincode : ${userDetails.pinCode}',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
        actions: [
          IconsButton(
            onPressed: () {
              Navigator.of(context).pop(['Test', 'List']);
            },
            text: cancel,
            color: Colors.blue,
            textStyle: TextStyle(color: Colors.white),
            iconData: Icons.edit,
            iconColor: Colors.white,
          ),
          IconsButton(
            onPressed: () {},
            text: ok,
            textStyle: TextStyle(color: Colors.white),
            iconData: Icons.check,
            iconColor: Colors.white,
            color: Colors.blue,
          ),
        ]);
  }
}
