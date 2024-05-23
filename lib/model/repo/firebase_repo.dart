import 'package:demo_sign_up/model/data/UserInformation.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class FirebaseRepo{
  Future<UserCredential> loginWithEmailAndPassword(String email, String password);
  Future<UserCredential> signUpWithEmailAndPassword(String email, String password);
  Future<void> saveUserInfo(UserCredential userCredential);
  Future<void> sendPasswordResetEmail(String email);
  Future<UserInformation> fetchUserInfo();
}