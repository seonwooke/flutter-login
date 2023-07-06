import 'package:get/get.dart';

class SignController extends GetxController {
  static SignController get instance => Get.find();

  var loging = false.obs;

  start() {
    loging.value = true;
  }

  done() {
    loging.value = false;
  }
}
