class AssetsUtils {
  /// 싱글톤(Singleton) 패턴 : 객체의 인스턴스가 오직 하나만 생성되는 것
  AssetsUtils._privateConstructor();
  static final AssetsUtils _instance = AssetsUtils._privateConstructor();
  static AssetsUtils get instance => _instance;

  final google = 'assets/images/google.png';
  final kakao = 'assets/images/kakao.png';
}
