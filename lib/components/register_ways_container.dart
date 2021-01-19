import 'package:flutter/material.dart';

class RegisterWaysContainer extends StatelessWidget {
  final Image image;
  RegisterWaysContainer({this.image});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 0.0),
      alignment: Alignment.center,
      child: image,
      height: 50.0,
      width: 170.0,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade400),
        borderRadius: BorderRadius.circular(5.0),
      ),
    );
  }
}
