import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../auth/auth.dart';
import '../../widgets/widgets.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({Key? key}) : super(key: key);

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBarWidget(),
      body: _bodyWidget(),
    );
  }

  _appBarWidget() {
    return AppBar(
      title: const Text('SIGN UP'),
    );
  }

  _bodyWidget() {
    return SafeArea(
      child: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 160),
                EmailTextFormField(
                  hintText: '이메일을 입력해주세요.',
                  controller: emailController,
                ),
                const SizedBox(height: 8),
                PasswordFormField(
                  hintText: '패스워드를 입력해주세요.',
                  controller: passwordController,
                ),
                const SizedBox(height: 8),
                PasswordFormField(
                  hintText: '패스워드를 다시 입력해주세요.',
                  controller: confirmController,
                ),
                const SizedBox(height: 96),
                MyElevatedButton(
                  label: '회원가입',
                  onPressed: () async {
                    EmailSignUp(
                      formKey,
                      emailController,
                      passwordController,
                      confirmController,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void EmailSignUp(
    formKey, emailController, passwordController, confirmController) async {
  if (passwordController.text == confirmController.text) {
    Authentication.instance.signUpWithEmailAndPassword(
      emailController.text.trim(),
      passwordController.text.trim(),
      emailController.text.trim(),
    );
  } else {
    Get.snackbar(
      '비밀번호 불일치',
      '비밀번호가 불일치 합니다.🙁',
    );
  }
}
