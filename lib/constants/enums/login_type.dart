import 'package:flutter/material.dart';

import '../../auth/auth.dart';
import '../../controllers/controllers.dart';
import '../../widgets/widgets.dart';
import '../constants.dart';

enum LoginType { google, email }

extension LoginTypeExtension on LoginType {
  Widget getButton(SignController signController) {
    switch (this) {
      case LoginType.google:
        return SnsLoginButton(
          imageName: AssetsUtils.instance.google,
          onTap: () {
            signController.start();
            GoogleLogin().signIn();
          },
        );
      case LoginType.email:
        return const SizedBox();
    }
  }

  get getSignIn {
    switch (this) {
      case LoginType.google:
        return Authentication.instance.signInWithGoogle();
      case LoginType.email:
        return;
    }
  }
}
