import 'package:flutter/material.dart';

mixin ValidationMixin {
  String userNameValidation(String userName) {
    return userName.length > 0 ? null : 'Enter your name';
  }

  String emailValidation(String email) {
    return email.contains('@')
        ? null
        : 'The email is not a valid email address.';
  }

  String passwordValidation(String password) {
    return password.length > 3
        ? null
        : 'Password must contain at least four characters';
  }
}
