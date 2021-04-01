import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFormField extends StatelessWidget {
  final String hintText;
  final String labelText;
  final bool obscureText;
  final TextEditingController controller;
  final List<TextInputFormatter> inputFormatters;
  final TextInputType keyboardType;

  CustomTextFormField({
    this.hintText,
    @required this.obscureText,
    this.labelText,
    this.controller,
    this.inputFormatters,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      controller: controller,
      inputFormatters: inputFormatters,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        filled: true,
        // fillColor: Colors.blueGrey[900],
        enabledBorder: OutlineInputBorder(
          // borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: Colors.transparent),
        ),
        focusedBorder: OutlineInputBorder(
          //borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: Theme.of(context).accentColor),
        ),
      ),
    );
  }
}
