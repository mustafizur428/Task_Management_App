import 'package:flutter/material.dart';

class reusableTextFleid extends StatelessWidget {
  final String text;
  final IconData? icon;
  final bool isPasswordType;
  final TextEditingController controller;
  final int? maxLine;
  const reusableTextFleid(
      {super.key,
      required this.text,
      this.icon,
      required this.isPasswordType,
      required this.controller, this.maxLine});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: isPasswordType,
      enableSuggestions: !isPasswordType,
      autocorrect: !isPasswordType,
      cursorColor: Colors.lightBlue,
      style: TextStyle(
        color: Colors.black,
      ),
      decoration: InputDecoration(
        prefixIcon: Icon(
          icon,
          size: 20,
          color: Colors.grey,
        ),
        labelText: text,
        labelStyle: TextStyle(
          color: Colors.grey,
          fontSize: 20,
        ),
        filled: true,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        fillColor: Colors.lightBlue.withOpacity(0.3),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(width: 0, style: BorderStyle.none)),
      ),
      maxLines: maxLine??1,
      keyboardType: isPasswordType
          ? TextInputType.visiblePassword
          : TextInputType.emailAddress,
    );
  }
}
