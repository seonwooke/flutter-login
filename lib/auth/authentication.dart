import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../constants/constants.dart';
import '../models/models.dart';
import '../repositories/repositories.dart';

class Authentication {
  /// Signlton Pattern
  Authentication._privateConstructor(); // Private한 생성자 생성
  static final Authentication _instance = Authentication
      ._privateConstructor(); // 생성자를 호출하고 반환된 Singleton 인스턴스를 _instance 변수에 할당
  static Authentication get instance =>
      _instance; // Authentication() 호출시에 _instance 변수를 반환

  /// Email Sign Up
  Future<User?> signUpWithEmailAndPassword(
      String email, String password, String displayName) async {
    try {
      UserCredential result =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = result.user;

      if (user != null) {
        await UserRepository.instance.addUserToFirebase(
          UserModel.emailSignUp(
            user,
          ),
        );
        Get.offNamed(AppRoutes.instance.MAIN);
        return user;
      }

      return user;
    } on FirebaseAuthException catch (error) {
      errorSnackBar(error);
    } catch (error) {
      if (kDebugMode) {
        print('email sign up failed');
        print(error.toString());
      }

      return null;
    }

    return null;
  }

  /// Email Sign In
  Future<void> signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      User? user = result.user;

      if (user != null) {
        Get.offNamed(AppRoutes.instance.MAIN);
      } else {
        Get.snackbar(
          '존재하지 않는 계정',
          '존재하지 않는 계정입니다.🙁',
        );
      }
    } on PlatformException catch (error) {
      if (kDebugMode) {
        print(error.toString());
      }
    } on FirebaseAuthException catch (error) {
      errorSnackBar(error);
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
    }
  }

  /// Email Sign Out
  Future<void> signOut() async {
    await FirebaseAuth.instance
        .signOut()
        .then((value) => Get.offAllNamed(AppRoutes.instance.SIGNIN));
  }

  /// Google Sign In
  Future<User?> signInWithGoogle() async {
    User? user;

    if (kIsWeb) {
      GoogleAuthProvider authProvider = GoogleAuthProvider();

      try {
        final UserCredential userCredential =
            await FirebaseAuth.instance.signInWithPopup(authProvider);

        user = userCredential.user;

        if (user != null && userCredential.additionalUserInfo!.isNewUser) {
          await UserRepository.instance.addUserToFirebase(
            UserModel.snsSignUp(
              LoginType.google,
              user,
            ),
          );
        } else if (user != null) {
          await UserRepository.instance.updateLoginType(
            LoginType.google,
            user.uid,
          );
        }

        Get.offNamed(AppRoutes.instance.MAIN);
      } catch (error) {
        if (kDebugMode) {
          print(error);
        }
      }
    } else {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      await googleSignIn.signOut();

      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();

      try {
        if (googleSignInAccount != null) {
          final GoogleSignInAuthentication googleSignInAuthentication =
              await googleSignInAccount.authentication;

          final AuthCredential credential = GoogleAuthProvider.credential(
            accessToken: googleSignInAuthentication.accessToken,
            idToken: googleSignInAuthentication.idToken,
          );

          try {
            final UserCredential userCredential =
                await FirebaseAuth.instance.signInWithCredential(credential);

            user = userCredential.user;

            if (user != null && userCredential.additionalUserInfo!.isNewUser) {
              await UserRepository.instance.addUserToFirebase(
                UserModel.snsSignUp(
                  LoginType.google,
                  user,
                ),
              );
            } else if (user != null) {
              await UserRepository.instance
                  .updateLoginType(LoginType.google, user.uid);
            }
          } on FirebaseAuthException catch (error) {
            if (kDebugMode) {
              print(error.code);
            }
          } catch (error) {
            if (kDebugMode) {
              print(error);
            }
          }
        }

        return user;
      } on PlatformException catch (error) {
        if (kDebugMode) {
          print(error);
        }
      } catch (error) {
        if (kDebugMode) {
          print(error);
        }
      }
    }

    return null;
  }

  /// Google Sign Out
  Future<void> signOutWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();

    try {
      if (!kIsWeb) {
        await googleSignIn.signOut();
      }
      await signOut();
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
    }
  }

  /// Error SnackBar
  void errorSnackBar(FirebaseAuthException error) {
    switch (error.code) {
      case 'invalid-email':
        Get.snackbar(
          '유효하지 않는 이메일',
          '유효하지 않는 이메일 형식입니다.🙁',
        );
        break;
      case 'user-not-found':
        Get.snackbar(
          '존재하지 않는 이메일 입니다.',
          '회원가입을 먼저 해주세요.🙁',
        );
        break;
      case 'wrong-password':
        Get.snackbar(
          '패스워드가 틀렸습니다.',
          '패스워드를 확인 해주세요.🙁\n구글 혹은 애플 계정으로 로그인한 경우일 수 있습니다.',
        );
        break;
      case 'network-request-failed':
        Get.snackbar(
          '네트워크 오류',
          '모바일 네트워크 혹은 와이파이를 확인해 주세요.🙁',
        );
        break;
      case 'email-already-in-use':
        Get.snackbar(
          '이메일 중복',
          '해당 이메일은 이미 존재합니다.🙁',
        );
        break;
      case 'weak-password':
        Get.snackbar(
          '너무 쉬운 비밀번호',
          '비밀번호를 6자 이상으로 입력해주세요.🙁',
        );
        break;
      case 'operation-not-allowed':
        Get.snackbar(
          '허용되지 않는 방법',
          '허용되지 않은 로그인 방법입니다.🙁',
        );
        break;
      default:
        Get.snackbar(
          error.code,
          '${error.message}',
          duration: const Duration(seconds: 5),
        );
    }
  }
}
