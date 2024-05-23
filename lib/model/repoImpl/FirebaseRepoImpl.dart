import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_sign_up/model/data/UserInformation.dart';
import 'package:demo_sign_up/model/repo/firebase_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseRepoImpl implements FirebaseRepo{

  final FirebaseAuth auth;
  final FirebaseFirestore db;

  FirebaseRepoImpl(this.auth, this.db);


  @override
  Future<UserInformation> fetchUserInfo() async {
    final user = auth.currentUser;
    if (user == null) throw StateError('User not logged in');

    final doc = await db.collection('users').doc(user.uid).get();
    return UserInformation.fromMap(doc.data()!);

  }

  @override
  Future<UserCredential> loginWithEmailAndPassword(String email, String password) {
   return auth.signInWithEmailAndPassword(email: email, password: password);
  }

  @override
  Future<void> saveUserInfo(UserCredential userCredential) async {
    final user = userCredential.user;
    if (user == null) return;

    final userInfo = UserInformation(
      name: user.displayName ?? user.email!.split('@').first,
      email: user.email!,
      uid: user.uid,
      imgUrl: user.photoURL ?? 'https://images.unsplash.com/photo-1511367461989-f85a21fda167?q=80&w=1031&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    );

    await db.collection('users').doc(user.uid).set(userInfo.toMap());

  }

  @override
  Future<void> sendPasswordResetEmail(String email) {
    return auth.sendPasswordResetEmail(email: email);
  }

  @override
  Future<UserCredential> signUpWithEmailAndPassword(String email, String password) {
  return auth.createUserWithEmailAndPassword(email: email, password: password);
  }

}