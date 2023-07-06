import 'package:get/get.dart';

import '../constants/constants.dart';
import 'auth.dart';

class EmailLogin implements Login {
  @override
  Future<void> signIn() async {
    Get.toNamed(AppRoutes.instance.SIGNIN);
  }

  @override
  Future<void> signOut() async {
    Authentication.instance.signOut();
  }

  Future<void> emailSignIn(String email, String password) async {
    await Authentication.instance.signInWithEmailAndPassword(email, password);
  }
}
