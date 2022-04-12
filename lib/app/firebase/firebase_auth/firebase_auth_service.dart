// 📦 Package imports:
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final firebaseAuthServiceProvider =
    Provider<FirebaseAuthService>((_) => FirebaseAuthService());

class FirebaseAuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  bool get emailVerified => _firebaseAuth.currentUser!.emailVerified;

  Stream<User?> get authStateStream => _firebaseAuth.authStateChanges();

  String get currentUserId => _firebaseAuth.currentUser!.uid;

  String? get nullableCurrentUserId => _firebaseAuth.currentUser?.uid;

  String? get currentUserEmailAddress => _firebaseAuth.currentUser!.email;

  User? get currentUser => _firebaseAuth.currentUser;

  Future<void> createNewFirebaseUser({
    required String email,
    required String password,
  }) async {
    await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    await sendEmailVerification();
  }

  Future<void> updateEmailAndPassword({
    required String email,
    required String password,
  }) async {
    await _firebaseAuth.currentUser!.updateEmail(email);
    await _firebaseAuth.currentUser!.updatePassword(password);
  }

  Future<UserCredential> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    final result = await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return result;
  }

  Future<void> get signOut async => _firebaseAuth.signOut();

  Future<void> sendPasswordResetEmail(String email) async =>
      _firebaseAuth.sendPasswordResetEmail(email: email);

  Future<void> sendEmailVerification() async =>
      _firebaseAuth.currentUser!.sendEmailVerification();

  Future<void> updateEmailAddress({
    required String newEmailAddress,
    required String password,
  }) async {
    final emailAuthCredential = EmailAuthProvider.credential(
      email: currentUserEmailAddress!,
      password: password,
    );
    await _firebaseAuth.currentUser!
        .reauthenticateWithCredential(emailAuthCredential);
    await _firebaseAuth.currentUser!.updateEmail(newEmailAddress);
  }

  Future<void> updatePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    /// パスワードの変更には最新の認証情報が必要なので, email, password で再認証を行う。
    /// その後updatePassword()を叩いてパスワードを変更する。

    final emailAuthCredential = EmailAuthProvider.credential(
      email: currentUserEmailAddress!,
      password: currentPassword,
    );
    await _firebaseAuth.currentUser!
        .reauthenticateWithCredential(emailAuthCredential);
    await _firebaseAuth.currentUser!.updatePassword(newPassword);
  }
}
