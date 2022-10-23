import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Menu Items - actions
  popUpMenuItems() {
    return PopupMenuButton(
      icon: Icon(Icons.more_vert),
      itemBuilder: (ctx) {
        return [
          PopupMenuItem<int>(
            value: 0,
            child: const Text("Logout"),
            onTap: () {
              setState(() {
                FirebaseAuth.instance.signOut();
                showToast('User Logged Out',
                    position: ToastPosition.bottom,
                    backgroundColor: Colors.black54);
              });
            },
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
