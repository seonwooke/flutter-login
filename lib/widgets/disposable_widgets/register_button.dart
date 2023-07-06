import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../pages/pages.dart';

class RegisterButton extends StatelessWidget {
  const RegisterButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 16,
      width: 327,
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Row(
          children: [
            const Text('Not a member?'),
            GestureDetector(
              onTap: () => Get.to(() => SignUpPage()),
              child: const Text(
                ' Register Now!',
                style:
                    TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
    );
  }
}
