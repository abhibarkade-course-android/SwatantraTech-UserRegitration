class UserDetails {
  UserDetails({
    required this.name,
    required this.gender,
    required this.bod,
    required this.pinCode,
    required this.url,
  });

  UserDetails.fromJson(Map<String, Object?> json)
      : this(
            name: json['name']! as String,
            gender: json['gender']! as String,
            bod: json['bod']! as String,
            pinCode: json['pinCode']! as String,
            url: json['url']! as String);

  final String bod;
  final String gender;
  final String name;
  final String pinCode;
  final String url;

  Map<String, Object?> toJson() {
    return {
      'name': name,
      'gender': gender,
      'bod': bod,
      'pinCode': pinCode,
      'url': url,
    };
  }
}
