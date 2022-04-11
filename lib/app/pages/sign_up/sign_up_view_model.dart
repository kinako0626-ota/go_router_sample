import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../model/users.dart';

final signUpViewModelProvider =
    ChangeNotifierProvider((ref) => SignUpViewModel());

class SignUpViewModel extends ChangeNotifier {
  final auth = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;
  final emailTextEditingController = TextEditingController();
  final passwordTextEditingController = TextEditingController();
  final firstNameTextEditingController = TextEditingController();
  final lastNameTextEditingController = TextEditingController();
  bool isLoading = false;

  Future<void> signUp({required String email, required String password}) async {
    debugPrint(email);
    debugPrint(firstNameTextEditingController.text);
    debugPrint(lastNameTextEditingController.text);
    _startLoading();
    try {
      final userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final users = Users(
        email: userCredential.user!.email,
        firstName: firstNameTextEditingController.text,
        lastName: lastNameTextEditingController.text,
        userId: userCredential.user!.uid,
      );
      await db.collection('users').add(users.toJson());
    } on Exception catch (e) {
      debugPrint(e.toString());
    } finally {
      _endLoading();
    }
  }

  void _startLoading() {
    isLoading = true;
    notifyListeners();
  }

  void _endLoading() {
    isLoading = false;
    notifyListeners();
  }
}
