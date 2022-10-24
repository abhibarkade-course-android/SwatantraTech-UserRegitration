import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:swatantratech/screens/auth/sign_in.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Menu Items - actions
  popUpMenuItems() {
    return PopupMenuButton(
      icon: const Icon(Icons.more_vert),
      onSelected: (res) {
        if (res == 0) {
          FirebaseAuth.instance.signOut();
          showToast('User Logged Out',
              position: ToastPosition.bottom, backgroundColor: Colors.black54);

          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => SignIn()),
              (Route<dynamic> route) => false);
        }
      },
      itemBuilder: (ctx) {
        return [
          const PopupMenuItem<int>(
            value: 0,
            child: Text("Logout"),
          ),
        ];
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users Data'),
        actions: [popUpMenuItems()],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {},
      ),
    );
  }
}
