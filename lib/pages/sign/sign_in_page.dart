import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../auth/auth.dart';
import '../../constants/constants.dart';
import '../../controllers/controllers.dart';
import '../../widgets/widgets.dart';

class SignInPage extends StatelessWidget {
  SignInPage({Key? key}) : super(key: key);

  final signController = Get.put(SignController());

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBarWidget(),
      body: _bodyWidget(),
    );
  }

  _appBarWidget() {
    return AppBar(
      title: const Text('SIGN IN'),
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
                /// Email Login
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
                const SizedBox(height: 16),
                const RegisterButton(),
                const SizedBox(height: 120),
                MyElevatedButton(
                  label: '로그인',
                  onPressed: () async {
                    emailSignIn(
                      formKey,
                      signController,
                      emailController,
                      passwordController,
                    );
                  },
                ),

                /// SNS Login
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    LoginType.values.length,
                    (index) =>
                        LoginType.values[index].getButton(signController),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void emailSignIn(
    formKey, signController, emailController, passwordController) async {
  if (formKey.currentState!.validate()) {
    signController.start();
    await Authentication.instance.signInWithEmailAndPassword(
      emailController.text.trim(),
      passwordController.text.trim(),
    );
    signController.done();
  }
}
