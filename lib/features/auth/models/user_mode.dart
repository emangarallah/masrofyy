import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  final String uid;
  final String name;
  final String email;
  final String photoUrl;

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.photoUrl,
  });

  // fromMap
  ///transform data from  json  api => dart o object
  factory UserModel.fromFirestore(User user) {
    return UserModel(
      uid: user.uid,
      name: user.displayName ?? "",
      email: user.email ?? "",
      photoUrl: user.photoURL ?? "",
    );
  }

  //to Map
  ///  from dart obj = usermodel => json api firbase  can  read it
  Map<String, dynamic> toMap() {
    return {'uid': uid, 'name': name, 'email': email, 'photpUrl': photoUrl};
  }
}
