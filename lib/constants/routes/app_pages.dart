import 'package:get/get.dart';

import '../../bindings/bindings.dart';
import '../../pages/pages.dart';
import 'routes.dart';

class AppPages {
  // Private한 생성자 생성
  AppPages._privateConstructor();

  // 생성자를 호출하고 반환된 Singleton 인스턴스를 _instance 변수에 할당
  static final AppPages _instance = AppPages._privateConstructor();

  // AppPages() 호출시에 _instance 변수를 반환
  static AppPages get instance => _instance;

  var pages = [
    GetPage(
      name: AppRoutes.instance.INIT,
      page: () => const InitPage(),
    ),
    GetPage(
      name: AppRoutes.instance.SIGNIN,
      page: () => SignInPage(),
    ),
    GetPage(
      name: AppRoutes.instance.SIGNUP,
      page: () => SignUpPage(),
    ),
    GetPage(
      name: AppRoutes.instance.MAIN,
      page: () => const MainPage(),
      binding: MainBinding(),
    ),
  ];
}
