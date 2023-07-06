import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/constants.dart';

class InitPage extends StatelessWidget {
  const InitPage({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(microseconds: 100), () {
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        Get.offNamed(AppRoutes.instance.MAIN);
      } else {
        Get.offNamed(AppRoutes.instance.SIGNIN);
      }
    });

    return Container(
      color: Colors.white,
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
