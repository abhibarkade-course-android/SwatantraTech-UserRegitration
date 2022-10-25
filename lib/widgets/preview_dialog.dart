import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:oktoast/oktoast.dart';
import 'package:swatantratech/utilities/dimensions.dart';

import '../helper/firestore/firebase_helper.dart';
import '../helper/firestore/user_details.dart';

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
              Text('Preview'),
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
            textStyle: const TextStyle(color: Colors.white),
            iconData: Icons.edit,
            iconColor: Colors.white,
          ),
          IconsButton(
            onPressed: () {
              addUserDataToDB(context, userDetails);
            },
            text: ok,
            textStyle: const TextStyle(color: Colors.white),
            iconData: Icons.check,
            iconColor: Colors.white,
            color: Colors.blue,
          ),
        ]);
  }

  static addUserDataToDB(BuildContext context, UserDetails userDetails) async {
    AlertDialog dialog = AlertDialog(
      actions: [
        CircularProgressIndicator(),
        Text(
          'Loading...',
          style: TextStyle(fontSize: Dimensions.h16),
        )
      ],
      actionsAlignment: MainAxisAlignment.spaceEvenly,
      actionsPadding: EdgeInsets.all(Dimensions.h16),
    );

    showDialog(context: context, builder: (ctx) => dialog);

    final storageRef = FirebaseStorage.instance.ref();
    String fileName = 'USER-${DateTime.now().millisecondsSinceEpoch}';

    final uploadTask = storageRef
        .child('ProfilePictures')
        .child(fileName)
        .putFile(File(userDetails.url));

    uploadTask.snapshotEvents.listen((snap) async {
      switch (snap.state) {
        case TaskState.running:
          break;
        case TaskState.success:
          var tmp = FirebaseStorage.instance
              .ref()
              .child('ProfilePictures')
              .child(fileName);

          String url = (await tmp.getDownloadURL()).toString();
          userDetails.url = (await tmp.getDownloadURL()).toString();
          print(url);

          AddUsersDetails.addUser(context, userDetails, fileName);
          Navigator.of(context).pop();
          Navigator.of(context).pop();
          showToast('User Added', position: ToastPosition.bottom);
          break;
        case TaskState.error:
          Navigator.of(context).pop();
          Navigator.of(context).pop();
          break;
        case TaskState.paused:
          Navigator.of(context).pop();
          Navigator.of(context).pop();
          break;
        case TaskState.canceled:
          Navigator.of(context).pop();
          Navigator.of(context).pop();
          break;
      }
    });
  }
}
