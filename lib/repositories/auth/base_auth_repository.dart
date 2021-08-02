import 'package:firebase_auth/firebase_auth.dart';

import 'package:firebase_auth/firebase_auth.dart' as auth;

abstract class BaseAuthRepository {
  // get user is a listener
  Stream<auth.User> get user;
  Future<auth.User> signUpWithEmailAndPassword({
    required String username,
    required String email,
    required String password,
  });
  Future<auth.User> logInWithEmailAndPassword(
      {required String email, required String password});
  Future<void> logOut();
}
