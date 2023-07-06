import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmailTextFormField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  const EmailTextFormField({
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
          keyboardType: TextInputType.emailAddress,
          cursorColor: Colors.black,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hintText,
          ),
          validator: ((value) {
            if (value == null || value.isEmpty) {
              return '이메일을 입력하세요.';
            } else if (!value.isEmail) {
              return '이메일 형식이 아닙니다.';
            } else {
              return null;
            }
          }),
        ),
      ),
    );
  }
}
