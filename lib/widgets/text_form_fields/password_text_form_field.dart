import 'package:flutter/material.dart';

class PasswordFormField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  const PasswordFormField({
    required this.hintText,
    required this.controller,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      width: 328,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0),
        child: TextFormField(
          controller: controller,
          autocorrect: false,
          obscureText: true,
          keyboardType: TextInputType.emailAddress,
          cursorColor: Colors.black,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hintText,
          ),
          validator: ((value) {
            if (value!.trim().isEmpty) {
              return '패스워드 입력하세요.';
            } else {
              return null;
            }
          }),
        ),
      ),
    );
  }
}
