import 'package:get/get.dart';

import '../controllers/controllers.dart';

class InitBinding implements Bindings {
  @override
  void dependencies() {}
}

class MainBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(AuthController());
  }
}
