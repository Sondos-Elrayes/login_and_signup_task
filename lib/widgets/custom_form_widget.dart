import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyCustomInput extends StatelessWidget {
  final bool obscureText;
  final Function validator;
  final FocusNode focusNode;
  final String labelText;
  final Function onSave;
  final Function onFieldSubmit;
  final TextAlign textAlign;
  final TextInputType keyboardType;
  final int inputMaxLines;
  final TextInputAction textInputAction;
  final Function onChanged;

  MyCustomInput(
      {this.onChanged,
      this.labelText,
      this.onFieldSubmit,
      this.inputMaxLines,
      this.obscureText = false,
      this.validator,
      this.textInputAction,
      this.keyboardType,
      this.textAlign = TextAlign.start,
      this.focusNode,
      this.onSave});
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      obscureText: obscureText,
      validator: validator,
      focusNode: focusNode,
      onFieldSubmitted: onFieldSubmit,
      textInputAction: textInputAction,
      onSaved: onSave,
      decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(color: Colors.grey, fontSize: 14.0),
          hintStyle: TextStyle(color: Colors.grey),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: BorderSide(
              color: Colors.grey.shade400,
            ),
          )),
      keyboardType: keyboardType,
    );
  }
}

class MyCustomFormButton extends StatelessWidget {
  final Function onPressed;
  final String formText;
  MyCustomFormButton({this.onPressed, this.formText});
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Container(
      child: FlatButton(
        onPressed: onPressed,
        child: Text(
          formText,
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
      decoration: BoxDecoration(
        color: Color(0xFFBC321B),
        borderRadius: BorderRadius.circular(5.0),
      ),
      height: 50,
      width: deviceSize.width,
    );
  }
}
