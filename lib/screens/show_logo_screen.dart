import 'package:flutter/material.dart';

class ShowLogoScreen extends StatefulWidget {
  static const routName = 'showLogoScreen';

  @override
  _ShowLogoScreenState createState() => _ShowLogoScreenState();
}

class _ShowLogoScreenState extends State<ShowLogoScreen> {
  Size deviceSize;
  @override
  Widget build(BuildContext context) {
    deviceSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Container(
        height: deviceSize.height,
        width: deviceSize.width,
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Center(
          child: CircleAvatar(
            maxRadius: 100,
            backgroundImage: AssetImage('assets/images/catLogo.jpg'),
          ),
        ),
      ),
    );
  }
}
