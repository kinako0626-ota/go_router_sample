import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../firebase/firebase_auth/firebase_auth_service.dart';

final signInViewModelProvider = ChangeNotifierProvider(
  (ref) => SignInViewModel(ref.watch(firebaseAuthServiceProvider)),
);

class SignInViewModel extends ChangeNotifier {
  SignInViewModel(this._firebaseAuthService);
  final FirebaseAuthService _firebaseAuthService;
  final emailTextEditingController = TextEditingController();
  final passwordTextEditingController = TextEditingController();

  Future<void> signIn({
    required String email,
    required String password,
  }) async =>
      _firebaseAuthService.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
}
