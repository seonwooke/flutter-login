// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';

import '../constants/constants.dart';

class UserModel {
  LoginType? loginType;
  String? uid;
  String? email;
  String? photoUrl;
  String? displayName;
  String? stateMessage;
  List<String>? follow;
  List<String>? follower;
  List<String>? pushToken;
  DateTime? signUpDay;
  bool? private;

  UserModel({
    required this.loginType,
    required this.uid,
    required this.email,
    required this.photoUrl,
    required this.displayName,
    required this.stateMessage,
    required this.follow,
    required this.follower,
    required this.pushToken,
    required this.signUpDay,
    required this.private,
  });

  UserModel copyWith({
    LoginType? loginType,
    String? uid,
    String? email,
    String? photoUrl,
    String? displayName,
    String? stateMessage,
    List<String>? follow,
    List<String>? follower,
    List<String>? pushToken,
    DateTime? signUpDay,
    bool? private,
  }) {
    return UserModel(
      loginType: loginType ?? this.loginType,
      uid: uid ?? this.uid,
      email: email ?? this.email,
      photoUrl: photoUrl ?? this.photoUrl,
      displayName: displayName ?? this.displayName,
      stateMessage: stateMessage ?? this.stateMessage,
      follow: follow ?? this.follow,
      follower: follower ?? this.follower,
      pushToken: pushToken ?? this.pushToken,
      signUpDay: signUpDay ?? this.signUpDay,
      private: private ?? this.private,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'loginType': loginType!.name,
      'uid': uid,
      'email': email,
      'photoUrl': photoUrl,
      'displayName': displayName,
      'stateMessage': stateMessage,
      'follow': follow!.toSet().toList(),
      'follower': follower!.toSet().toList(),
      'pushToken': pushToken!.toSet().toList(),
      'signUpDay': signUpDay?.millisecondsSinceEpoch,
      'private': private,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      loginType: map['loginType'] != null
          ? LoginType.values.byName(map['loginType'])
          : null,
      uid: map['uid'] != null ? map['uid'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      photoUrl: map['photoUrl'] != null ? map['photoUrl'] as String : null,
      displayName:
          map['displayName'] != null ? map['displayName'] as String : null,
      stateMessage:
          map['stateMessage'] != null ? map['stateMessage'] as String : null,
      follow: map['follow'] != null ? List<String>.from(map['follow']) : [],
      follower:
          map['follower'] != null ? List<String>.from(map['follower']) : [],
      pushToken:
          map['pushToken'] != null ? List<String>.from(map['pushToken']) : [],
      signUpDay: map['signUpDay'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['signUpDay'] as int)
          : null,
      private: map['private'] != null ? map['private'] as bool : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  factory UserModel.empty() {
    return UserModel(
      loginType: LoginType.email,
      uid: '',
      email: '',
      photoUrl: '',
      displayName: '',
      stateMessage: '',
      follow: [],
      follower: [],
      pushToken: [],
      signUpDay: DateTime.now(),
      private: false,
    );
  }

  factory UserModel.signUp(LoginType loginType, User user, String displayName) {
    return UserModel(
      loginType: loginType,
      uid: user.uid,
      email: user.email,
      photoUrl: '',
      displayName: displayName,
      stateMessage: '',
      follow: [],
      follower: [],
      pushToken: [],
      signUpDay: DateTime.now(),
      private: false,
    );
  }

  factory UserModel.emailSignUp(User user) {
    return UserModel.signUp(
      LoginType.email,
      user,
      DataUtils.instance.randomNicknameGenerator(),
    );
  }

  factory UserModel.snsSignUp(LoginType loginType, User user) {
    return UserModel.signUp(
      loginType,
      user,
      DataUtils.instance.randomNicknameGenerator(),
    );
  }
}
