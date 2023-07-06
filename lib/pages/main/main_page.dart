import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../auth/auth.dart';
import '../../repositories/repositories.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBarWidget(),
      body: _bodyWidget(),
    );
  }

  _appBarWidget() {
    return AppBar(
      title: const Text('MAIN'),
      actions: [
        IconButton(
          icon: const Icon(
            Icons.exit_to_app,
          ),
          onPressed: () async {
            try {
              await UserRepository.instance.updateMyUserInfo();
              await Authentication.instance.signOut();
            } catch (error) {
              if (kDebugMode) {
                print(error);
              }
            }
          },
        )
      ],
    );
  }

  _bodyWidget() {
    return const Center(
      child: Text('MAIN'),
    );
  }
}
