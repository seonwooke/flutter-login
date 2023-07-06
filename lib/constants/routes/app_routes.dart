class AppRoutes {
  // Private한 생성자 생성
  AppRoutes._privateConstructor();

  // 생성자를 호출하고 반환된 Singleton 인스턴스를 _instance 변수에 할당
  static final AppRoutes _instance = AppRoutes._privateConstructor();

  // AppPages() 호출시에 _instance 변수를 반환
  static AppRoutes get instance => _instance;

  final String INIT = '/';
  final String SIGNIN = '/sign_in';
  final String SIGNUP = '/sign_up';
  final String MAIN = '/main';
}
