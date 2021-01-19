import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:login_and_sign_up_task/components/register_ways_container.dart';
import 'package:login_and_sign_up_task/mixins/validation_mixin.dart';
import 'package:login_and_sign_up_task/screens/show_logo_screen.dart';
import 'package:login_and_sign_up_task/screens/sign_up_sceen.dart';
import 'package:login_and_sign_up_task/widgets/custom_form_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:login_and_sign_up_task/models/user_data.dart';

class LoginScreen extends StatefulWidget {
  static const routName = 'loginScreen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with ValidationMixin {
  final FocusNode _focusNode1 = FocusNode();
  final FocusNode _focusNode2 = FocusNode();
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  Map<String, dynamic> _authData = {'email': '', 'password': ''};

  bool _showPassword = false;
  bool _submitForm = false;
  void _saveForm() {
    _submitForm = true;
    final isValid = _loginFormKey.currentState.validate();
    if (!isValid) {
      return;
    }
    _setData();
    _loginFormKey.currentState.save();
    Navigator.pushNamed(context, ShowLogoScreen.routName);
  }

  _setData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('email', _authData['email']);
    prefs.setString('password', _authData['password']);
  }

  User user = User();
  _getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      user.email = prefs.getString('email');
      user.password = prefs.getString('password');
    });
  }

  @override
  void dispose() {
    _focusNode1.dispose();
    _focusNode2.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SizedBox.expand(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 30),
                  Center(
                    child: Container(
                      alignment: Alignment.center,
                      height: 150,
                      width: 130,
                      child: Image.asset(
                        'assets/images/catLogo.jpg',
                      ),
                    ),
                  ),
                  Center(
                    child: RichText(
                      text: TextSpan(children: [
                        TextSpan(
                          text: "CAT",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 25.0,
                              fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text: ' Reloaded',
                          style: TextStyle(
                              color: Color(0xFFBC321B), fontSize: 18.0),
                        ),
                      ]),
                    ),
                  ),
                  SizedBox(
                    height: 100.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      RegisterWaysContainer(
                        image: Image.asset(
                          'assets/images/facebook.png',
                          height: 20,
                        ),
                      ),
                      SizedBox(
                        width: 20.0,
                      ),
                      RegisterWaysContainer(
                        image: Image.asset(
                          'assets/images/google.png',
                          height: 20,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      'or',
                      style: TextStyle(color: Colors.grey, fontSize: 18.0),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Form(
                    key: _loginFormKey,
                    child: Column(
                      children: [
                        MyCustomInput(
                          labelText: 'Email ID',
                          focusNode: _focusNode1,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.emailAddress,
                          onFieldSubmit: (_) {
                            FocusScope.of(context).requestFocus(_focusNode2);
                          },
                          onChanged: (val) {
                            _authData['email'] = '$val';
                          },
                          onSave: (val) {
                            _authData['email'] = '$val';
                          },
                          validator: (val) {
                            if (val.isEmpty) return 'please provide an email ';
                            if (val != user?.email)
                              return 'The email is incorrect';
                            else
                              return emailValidation(val);
                          },
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        MyCustomInput(
                          obscureText: !_showPassword,
                          labelText: 'password',
                          focusNode: _focusNode2,
                          textInputAction: TextInputAction.done,
                          onFieldSubmit: (_) {
                            _focusNode2.unfocus();
                          },
                          onChanged: (val) {
                            _authData['password'] = '$val';
                          },
                          onSave: (val) {
                            _authData['password'] = '$val';
                          },
                          validator: (val) {
                            if (val.isEmpty)
                              return 'please provide a password ';
                            if (val != user?.password.toString())
                              return 'The password is incorrect';
                            else
                              return passwordValidation(val);
                          },
                        ),
                        SizedBox(height: 10.0),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 8.0,
                              ),
                              child: Text(
                                'Forgot password?',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 14.0),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: MyCustomFormButton(
                            formText: 'login',
                            onPressed: () {
                              _saveForm();
                            },
                          ),
                        ),
                        SizedBox(
                          height: 50.0,
                        ),
                        FlatButton(
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamed(SignUpScreen.routName);
                          },
                          child: RichText(
                            text: TextSpan(children: [
                              TextSpan(
                                text: "dont't have an account?",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 16.0),
                              ),
                              TextSpan(
                                text: ' sign up',
                                style: TextStyle(
                                    color: Color(0xFFBC321B), fontSize: 16.0),
                              ),
                            ]),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
