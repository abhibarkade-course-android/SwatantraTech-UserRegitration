import 'package:cloud_firestore/cloud_firestore.dart';

class UserDetails {
  final String bod;
  final String gender;
  final String name;
  final String pinCode;
  String url;
  String createdAt;

  UserDetails({
    required this.name,
    required this.gender,
    required this.bod,
    required this.pinCode,
    required this.url,
    required this.createdAt,
  });

  UserDetails.fromJson(Map<String, Object?> json)
      : this(
            name: json['name']! as String,
            gender: json['gender']! as String,
            bod: json['bod']! as String,
            pinCode: json['pinCode']! as String,
            url: json['url']! as String,
            createdAt: json['createdAt']! as String);

  Map<String, Object?> toJson() {
    return {
      'name': name,
      'gender': gender,
      'bod': bod,
      'pinCode': pinCode,
      'url': url,
      'createdAt': createdAt
    };
  }

  static toUserDetails(DocumentSnapshot snap) {
    return UserDetails(
        name: snap.get('name'),
        gender: snap.get('gender'),
        bod: snap.get('bod'),
        pinCode: snap.get('pinCode'),
        url: snap.get('url'),
        createdAt: snap.get('createdAt'));
  }

  @override
  String toString() {
    return 'UserDetails{bod: $bod, gender: $gender, name: $name, pinCode: $pinCode, url: $url, createdAt: $createdAt}';
  }
}
