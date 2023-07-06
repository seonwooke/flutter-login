import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import '../constants/constants.dart';
import '../controllers/controllers.dart';
import '../models/models.dart';

class UserRepository {
  // Private한 생성자 생성
  UserRepository._privateConstructor();

  // 생성자를 호출하고 반환된 Singleton 인스턴스를 _instance 변수에 할당
  static final UserRepository _instance = UserRepository._privateConstructor();

  // UserRepository() 호출시에 _instance 변수를 반환
  static UserRepository get instance => _instance;

  final _userCollection = FirebaseFirestore.instance.collection("users");

  Future<UserModel> getUser(String uid) async {
    UserModel userModel = UserModel.empty();
    try {
      await _userCollection.doc(uid).get().then((DocumentSnapshot ds) {
        userModel = UserModel.fromMap(ds.data() as Map<String, dynamic>);
      });
    } catch (error) {
      if (kDebugMode) {
        print(error);
        print(userModel.toString());
      }
    }

    return userModel;
  }

  Future<void> addUserToFirebase(UserModel userModel) async {
    try {
      if (kDebugMode) {
        print('${userModel.email} is created');
      }
      await _userCollection.doc(userModel.uid).set(userModel.toMap());
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
    }
  }

  Future<void> updateLoginType(LoginType type, String uid) async {
    _userCollection.doc(uid).update({'loginType': type.name});
  }

  Future<void> updateMyUserInfo() async {
    await _userCollection
        .doc(AuthController.instance.currentUserUid)
        .set(AuthController.instance.currentUserModel.value.toMap());
  }
}
