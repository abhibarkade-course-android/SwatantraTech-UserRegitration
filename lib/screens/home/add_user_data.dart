import 'dart:io';

import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:gender_picker/source/enums.dart';
import 'package:gender_picker/source/gender_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:swatantratech/helper/firebase/user_details.dart';
import 'package:swatantratech/widgets/preview_dialog.dart';

import '../../utilities/dimensions.dart';
import '../../widgets/dialogs.dart';

class AddUserData extends StatefulWidget {
  const AddUserData({Key? key}) : super(key: key);

  @override
  State<AddUserData> createState() => _AddUserDataState();
}

class _AddUserDataState extends State<AddUserData> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _pinCodeController = TextEditingController();
  String bod = '';
  Gender _gender = Gender.Male;
  File? _image;

  selectProfilePic() {
    showMaterialModalBottomSheet(
        expand: false,
        context: context,
        builder: (ctx) => Container(
              margin: EdgeInsets.symmetric(
                  horizontal: Dimensions.h48, vertical: Dimensions.h16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                          icon: Icon(Icons.camera_alt_rounded),
                          onPressed: () {
                            setState(() {
                              _pickImage(ImageSource.camera);
                            });
                          }),
                      Text('Use a Camera')
                    ],
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                          icon: Icon(Icons.upload),
                          onPressed: () {
                            setState(() {
                              _pickImage(ImageSource.gallery);
                            });
                          }),
                      Text('Browse Gallery')
                    ],
                  )
                ],
              ),
            ));
  }

  Future _pickImage(ImageSource source) async {
    try {
      final img = await ImagePicker().pickImage(source: source);
      if (img == null) return;
      File? tmpFile = File(img.path);
      tmpFile = await _cropImage(imageFile: tmpFile);
      setState(() {
        _image = tmpFile;
        Navigator.of(context).pop();
      });
    } catch (e) {
      print(e);
      Navigator.of(context).pop();
    }
  }

  Future _cropImage({required File imageFile}) async {
    CroppedFile? croppedFile =
        await ImageCropper().cropImage(sourcePath: imageFile.path);
    if (croppedFile == null) return null;
    return File(croppedFile.path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add User'),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(
            left: Dimensions.h48,
            right: Dimensions.h48,
            bottom: Dimensions.h20),
        child: ElevatedButton(
            child: const Text('SUBMIT'),
            onPressed: () {
              setState(() {
                showPreview();
              });
            }),
      ),
      body: Container(
        constraints: BoxConstraints(maxWidth: Dimensions.w360),
        margin: EdgeInsets.all(Dimensions.h48),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Avatar
              SizedBox(height: Dimensions.h30 / 2),
              Align(
                alignment: Alignment.center,
                child: GestureDetector(
                  child: SizedBox(
                    height: Dimensions.r150,
                    width: Dimensions.r150,
                    child: _image == null
                        ? ClipRRect(
                            child: CircleAvatar(
                                backgroundColor: Colors.black54,
                                radius: Dimensions.r150 / 2,
                                child: const Text('No Image Selected')),
                          )
                        : ClipRRect(
                            borderRadius:
                                BorderRadius.circular(Dimensions.r150 / 2),
                            child: Image.file(_image!),
                          ),
                  ),
                  onTap: () {
                    selectProfilePic();
                  },
                ),
              ),
              SizedBox(height: Dimensions.h8),
              const Align(
                alignment: Alignment.center,
                child: Text('Click to upload image'),
              ),
              SizedBox(height: Dimensions.h30),

              // Name
              TextField(
                maxLines: 1,
                controller: _nameController,
                keyboardType: TextInputType.name,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Name',
                  hintText: 'Name',
                ),
              ),
              SizedBox(height: Dimensions.h30),

              // Birth Date
              DateTimePicker(
                initialValue: '',
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
                dateLabelText: 'Date',
                onChanged: (val) => bod = val,
                validator: (val) {
                  print(val);
                  return null;
                },
                onSaved: (val) => print(val),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Birth Date',
                  hintText: 'Birth Date',
                ),
              ),
              SizedBox(height: Dimensions.h30),

              // Pincode
              TextField(
                maxLines: 1,
                controller: _pinCodeController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Pincode',
                  hintText: 'Pincode',
                ),
              ),
              SizedBox(height: Dimensions.h30),
              const Text('Gender'),
              SizedBox(height: Dimensions.h8 * 2),
              GenderPickerWithImage(
                showOtherGender: true,
                verticalAlignedText: false,
                selectedGender: Gender.Male,
                selectedGenderTextStyle: const TextStyle(
                    color: Color(0xFF8b32a8), fontWeight: FontWeight.bold),
                unSelectedGenderTextStyle: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.normal),
                onChanged: (Gender? gender) {
                  _gender = _gender;
                },
                equallyAligned: true,
                animationDuration: Duration(milliseconds: 300),
                isCircular: true,
                // default : true,
                opacityOfGradient: 0.4,
                padding: const EdgeInsets.all(3),
                size: 50, //default : 40
              ),
            ],
          ),
        ),
      ),
    );
  }

  showPreview() {
    if (_nameController.text.isNotEmpty &&
        bod.isNotEmpty &&
        _pinCodeController.text.isNotEmpty) {
      PreviewDialog.showErrorDialogWithButtons(
          context,
          UserDetails(
              name: _nameController.text,
              gender: _gender.name,
              bod: bod,
              pinCode: _pinCodeController.text,
              url: _image!.path),
          'If something wrong, you can still make changes by simply editing it.',
          'buttonText',
          'Edit',
          'Submit',
          false,
          null);
    } else {
      CustomDialogs.showErrorDialog(context, 'All field are required !!',
          'Invalid Data', 'OK', 'invalid_anim', false, null);
    }
  }
}
