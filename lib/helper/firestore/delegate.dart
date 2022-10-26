import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../utilities/dimensions.dart';
import 'user_details.dart';

class CustomSearchDelegate extends SearchDelegate {
  List<UserDetails> searchTerms = [];

  CustomSearchDelegate() {
    loadData();
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    List<UserDetails> matchQuery = [];
    for (var user in searchTerms) {
      if (user.name.toLowerCase().contains(query.toLowerCase()) ||
          user.bod.toLowerCase().contains(query.toLowerCase()) ||
          user.gender.toLowerCase().contains(query.toLowerCase()) ||
          user.pinCode.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(user);
      }
    }

    if (query.isEmpty) {
      return ListView.builder(
          physics: const AlwaysScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: matchQuery.length,
          itemBuilder: (context, index) {
            UserDetails user = matchQuery[index];
            return Container(
              height: Dimensions.h120,
              margin: EdgeInsets.symmetric(
                  vertical: Dimensions.h8, horizontal: Dimensions.h16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(Dimensions.h12)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade100,
                    spreadRadius: Dimensions.h5,
                    blurRadius: Dimensions.h7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(Dimensions.h120),
                    child: Container(
                      margin: EdgeInsets.all(Dimensions.h16),
                      child: CachedNetworkImage(
                        imageUrl: '${user.url}',
                        placeholder: (context, url) =>
                            CircularProgressIndicator(),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: Dimensions.h16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Name : ${user.name}',
                          style: TextStyle(fontSize: Dimensions.h16),
                        ),
                        Text(
                          'Date of Birth : ${user.bod}',
                          style: TextStyle(fontSize: Dimensions.h16),
                        ),
                        Text(
                          'Gender : ${user.gender}',
                          style: TextStyle(fontSize: Dimensions.h16),
                        ),
                        Text(
                          'Pincode : ${user.pinCode}',
                          style: TextStyle(fontSize: Dimensions.h16),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          });
    } else
      return ListView.builder(
          physics: const AlwaysScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: matchQuery.length,
          itemBuilder: (context, index) {
            UserDetails user = matchQuery[index];
            return Container(
              height: Dimensions.h120,
              margin: EdgeInsets.symmetric(
                  vertical: Dimensions.h8, horizontal: Dimensions.h16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(Dimensions.h12)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade100,
                    spreadRadius: Dimensions.h5,
                    blurRadius: Dimensions.h7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(Dimensions.h120),
                    child: Container(
                      margin: EdgeInsets.all(Dimensions.h16),
                      child: CachedNetworkImage(
                        imageUrl: '${user.url}',
                        placeholder: (context, url) =>
                            CircularProgressIndicator(),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: Dimensions.h16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Name : ${user.name}',
                          style: TextStyle(fontSize: Dimensions.h16),
                        ),
                        Text(
                          'Date of Birth : ${user.bod}',
                          style: TextStyle(fontSize: Dimensions.h16),
                        ),
                        Text(
                          'Gender : ${user.gender}',
                          style: TextStyle(fontSize: Dimensions.h16),
                        ),
                        Text(
                          'Pincode : ${user.pinCode}',
                          style: TextStyle(fontSize: Dimensions.h16),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }

  void loadData() async {
    await FirebaseFirestore.instance.collection('Users').get().then((value) {
      value.docs.forEach((element) {
        searchTerms.add(UserDetails.toUserDetails(element));
        print(UserDetails.toUserDetails(element).toString());
      });
    });
  }
}
