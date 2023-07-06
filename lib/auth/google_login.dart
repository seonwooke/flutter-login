import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../constants/constants.dart';
import '../controllers/controllers.dart';
import 'auth.dart';

class GoogleLogin implements Login {
  @override
  Future<void> signIn() async {
    User? user = await Authentication.instance.signInWithGoogle();
    if (user != null) {
      Get.offNamed(AppRoutes.instance.MAIN);
      SignController.instance.done();
    } else {
      SignController.instance.done();
      await signOut();
    }
  }

  @override
  Future<void> signOut() async {
    await Authentication.instance.signOutWithGoogle();
  }
}
