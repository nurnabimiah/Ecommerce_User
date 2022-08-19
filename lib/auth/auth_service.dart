import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static User? get currentUser => _auth.currentUser;

  static Future<User?> loginUser(String email, String pass) async {
    final credential = await _auth.signInWithEmailAndPassword(email: email, password: pass);
    return credential.user;
  }

  static Future<User?> registerUser(String email, String pass) async {

    final credential = await _auth.createUserWithEmailAndPassword(email: email, password: pass);
    return credential.user;
  }

  static bool isUserVerified() => _auth.currentUser?.emailVerified ?? false;

  static Future<void> sendVerificationMail() {
    return _auth.currentUser!.sendEmailVerification();
  }

  static Future<void> logout() {
    return _auth.signOut();
  }
}