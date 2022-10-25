import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:oktoast/oktoast.dart';
import 'package:swatantratech/app_constants.dart';
import 'package:swatantratech/screens/auth/sign_in.dart';
import 'package:swatantratech/screens/home/add_user_data.dart';

import '../../utilities/dimensions.dart';

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
    var ref = FirebaseFirestore.instance.collection('Users');
    ScrollController _controller = new ScrollController();
    final TextEditingController _searchController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text("User's Details"),
        actions: [
          IconButton(
            icon: const Icon(Icons.sort_by_alpha),
            onPressed: () {
              setState(() {
                AppConstants.currentFilter = 'name';
                AppConstants.sortAZ = !AppConstants.sortAZ;
                print(AppConstants.sortAZ);
              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.access_time_rounded),
            onPressed: () {
              setState(() {
                AppConstants.currentFilter = 'createdAt';
                AppConstants.sortByCreation = !AppConstants.sortByCreation;
                print(AppConstants.sortByCreation);
              });
            },
          ),
          popUpMenuItems(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (ctx) => const AddUserData()));
        },
      ),
      body: Container(
        constraints: BoxConstraints(maxWidth: Dimensions.w360),
        margin: EdgeInsets.all(Dimensions.h16),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(
                  vertical: Dimensions.h8, horizontal: Dimensions.h16),
              child: TextFormField(
                maxLines: 1,
                controller: _searchController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Search',
                    hintText: 'Username or Pincode ....',
                    prefixIcon: Icon(Icons.search)),
              ),
            ),
            Expanded(
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('Users')
                      .orderBy(AppConstants.currentFilter,
                          descending: AppConstants.currentFilter == 'name'
                              ? AppConstants.sortAZ
                              : AppConstants.sortByCreation)
                      .snapshots(),
                  builder: (context, snapshot) {
                    return !snapshot.hasData
                        ? const Center(child: Text('Please Wait'))
                        : ListView.builder(
                            controller: _controller,
                            physics: const AlwaysScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              DocumentSnapshot snap =
                                  snapshot.data!.docs[index];
                              return Container(
                                height: Dimensions.h120,
                                margin: EdgeInsets.symmetric(
                                    vertical: Dimensions.h8,
                                    horizontal: Dimensions.h16),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.shade100,
                                      spreadRadius: 5,
                                      blurRadius: 7,
                                      offset: Offset(
                                          0, 3), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(
                                          Dimensions.h120),
                                      child: Container(
                                        margin: EdgeInsets.all(Dimensions.h16),
                                        child: CachedNetworkImage(
                                          imageUrl: '${snap.get('url')}',
                                          placeholder: (context, url) =>
                                              CircularProgressIndicator(),
                                          errorWidget: (context, url, error) =>
                                              Icon(Icons.error),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.symmetric(
                                          vertical: Dimensions.h16),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Name : ${snap.get('name')}',
                                            style: TextStyle(fontSize: 16),
                                          ),
                                          Text(
                                            'Date of Birth : ${snap.get('bod')}',
                                            style: TextStyle(fontSize: 16),
                                          ),
                                          Text(
                                            'Gender : ${snap.get('gender')}',
                                            style: TextStyle(fontSize: 16),
                                          ),
                                          Text(
                                            'Pincode : ${snap.get('pinCode')}',
                                            style: TextStyle(fontSize: 16),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            });
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
