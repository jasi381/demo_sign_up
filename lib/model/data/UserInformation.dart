
class UserInformation {
  final String name;
  final String email;
  final String uid;
  final String imgUrl;

  UserInformation({required this.name, required this.email, required this.uid, required this.imgUrl});

  factory UserInformation.fromMap(Map<String, dynamic> map) {
    return UserInformation(
      name: map['name'],
      email: map['email'],
      uid: map['uid'],
      imgUrl: map['imgUrl'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'uid': uid,
      'imgUrl': imgUrl,
    };
  }
}