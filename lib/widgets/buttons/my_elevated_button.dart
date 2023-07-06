import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../theme/themes.dart';

class MyElevatedButton extends StatelessWidget {
  final String label;
  final void Function()? onPressed;
  const MyElevatedButton({
    required this.label,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: AppButtonStyle.myElevatedButtonStyle,
      child: Text(
        label,
      ),
    );
  }

  // Factory Design Pattern 적용 방법
  // factory MyElevatedButton.forEventCreate(void Function()? onPressed) {
  //   return MyElevatedButton(label: "이벤트 생성하기", onPressed: onPressed);
  // }
}
