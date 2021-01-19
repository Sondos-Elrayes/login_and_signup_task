import 'package:shared_preferences/shared_preferences.dart';

class User {
  String userName;
  String email;
  int phoneNumber;
  String password;
  User({this.userName, this.password, this.email, this.phoneNumber});

}
