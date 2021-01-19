import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login_and_sign_up_task/mixins/validation_mixin.dart';
import 'package:login_and_sign_up_task/screens/show_logo_screen.dart';
import 'package:login_and_sign_up_task/widgets/custom_form_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:login_and_sign_up_task/models/user_data.dart';

class SignUpScreen extends StatefulWidget {
  static const routName = 'signUpScreen';
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> with ValidationMixin {
  final FocusNode _focusNode1 = FocusNode();
  final FocusNode _focusNode2 = FocusNode();
  final FocusNode _focusNode3 = FocusNode();
  final FocusNode _focusNode4 = FocusNode();
  final FocusNode _focusNode5 = FocusNode();
  GlobalKey<FormState> _registerFormKey = GlobalKey<FormState>();

  Map _registrationData = {
    'userName': '',
    'email': '',
    'phone': 0,
    'password': '',
    'passwordConfirmation': '',
  };

  bool _showPassword = false;
  bool _submitForm = false;
  void _saveForm() async {
    _submitForm = true;
    final isValid = _registerFormKey.currentState.validate();
    if (!isValid) return;
    _registerFormKey.currentState.save();
    _saveData();
    await Navigator.pushNamed(context, ShowLogoScreen.routName);
  }

  _saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString('userName', _registrationData['userName']);
    prefs.setString('email', _registrationData['email']);
    prefs.setInt('phone', int.parse(_registrationData['phone']));
    prefs.setString('password', _registrationData['password']);
  }

  User user = User();
  _getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      user.email = prefs.getString('email');
      user.password = prefs.getString('password');
      user.phoneNumber = prefs.getInt('phone');
      user.userName = prefs.getString('userName');
    });
  }

  @override
  void dispose() {
    _focusNode1.dispose();
    _focusNode2.dispose();
    _focusNode3.dispose();
    _focusNode4.dispose();
    _focusNode5.dispose();
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
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.grey),
      ),
      body: SizedBox.expand(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const SizedBox(
                height: 30.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Register to CAT Reloaded',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                      ),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    Form(
                      key: _registerFormKey,
                      child: Column(
                        children: [
                          MyCustomInput(
                            labelText: 'Full Name',
                            focusNode: _focusNode1,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.text,
                            onFieldSubmit: (_) {
                              FocusScope.of(context).requestFocus(_focusNode2);
                            },
                            onSave: (val) {
                              _registrationData['userName'] = '$val';
                            },
                            validator: userNameValidation,
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          MyCustomInput(
                            labelText: 'Email',
                            focusNode: _focusNode2,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.emailAddress,
                            onFieldSubmit: (_) {
                              FocusScope.of(context).requestFocus(_focusNode3);
                            },
                            onSave: (val) {
                              _registrationData['email'] = '$val';
                            },
                            validator: (val) {
                              return val.isNotEmpty
                                  ? emailValidation(val)
                                  : 'please provide an email ';
                            },
                          ),
                          SizedBox(
                            height: 30.0,
                          ),
                          MyCustomInput(
                            labelText: 'Phone Number',
                            focusNode: _focusNode3,
                            keyboardType: TextInputType.phone,
                            textInputAction: TextInputAction.next,
                            onFieldSubmit: (_) {
                              FocusScope.of(context).requestFocus(_focusNode4);
                            },
                            onSave: (val) {
                              _registrationData['phone'] = val;
                            },
                            validator: (val) {
                              return val.isNotEmpty
                                  ? null
                                  : 'please provide a phone number';
                            },
                          ),
                          SizedBox(
                            height: 30.0,
                          ),
                          MyCustomInput(
                            obscureText: !_showPassword,
                            labelText: 'password',
                            focusNode: _focusNode4,
                            textInputAction: TextInputAction.done,
                            onFieldSubmit: (_) {
                              FocusScope.of(context).requestFocus(_focusNode5);
                            },
                            onChanged: (val) {
                              _registrationData['password'] = '$val';
                            },
                            onSave: (val) {
                              _registrationData['password'] = '$val';
                            },
                            validator: (val) {
                              return val.isNotEmpty
                                  ? passwordValidation(val)
                                  : 'please provide a password ';
                            },
                          ),
                          SizedBox(
                            height: 30.0,
                          ),
                          MyCustomInput(
                              obscureText: !_showPassword,
                              labelText: 'Confirm Password',
                              focusNode: _focusNode5,
                              textInputAction: TextInputAction.done,
                              onFieldSubmit: (_) {
                                _focusNode5.unfocus();
                              },
                              onSave: (val) {
                                _registrationData['passwordConfirmation'] = val;
                              },
                              validator: (val) {
                                if (val.isEmpty)
                                  return 'the confirm password confirmation dose not match';
                                if (val != _registrationData['password'])
                                  return 'the confirm password confirmation dose not match';
                                return null;
                              }),
                          SizedBox(
                            height: 60.0,
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: MyCustomFormButton(
                              formText: 'Register',
                              onPressed: () {
                                _saveForm();
                              },
                            ),
                          ),
                          SizedBox(
                            height: 30.0,
                          ),
                          Text(
                            'By registering you agree to terms & conditional ',
                            style: TextStyle(fontSize: 14.0),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5.0),
                            child: Text('and privacy policy of the team ',
                                style: TextStyle(fontSize: 14.0)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
