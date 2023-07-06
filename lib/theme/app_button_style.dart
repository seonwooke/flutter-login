import 'package:flutter/material.dart';

class AppButtonStyle {
  static final ButtonStyle myElevatedButtonStyle = ButtonStyle(
    backgroundColor: MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.disabled)) {
        return Colors.grey[200];
      }
      return Colors.blue;
    }),
    shape: MaterialStateProperty.resolveWith((states) {
      return RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      );
    }),
    minimumSize: MaterialStateProperty.resolveWith((states) {
      return const Size(328, 40);
    }),
  );
}
