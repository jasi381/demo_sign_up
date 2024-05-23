import 'dart:ui';

import 'package:demo_sign_up/di/service_locator.dart';
import 'package:demo_sign_up/model/data/UserInformation.dart';
import 'package:demo_sign_up/model/repo/firebase_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final firebaseRepoProvider = Provider<FirebaseRepo>((ref){
  return getIt<FirebaseRepo>();
});


class Loginsignupviewmodel extends StateNotifier<UserInformation?>{

  final FirebaseRepo repo;
  final Ref ref;

  Loginsignupviewmodel(this.repo,this.ref):super(null){
    _initErrorDebounce();
  }


  final authStateProvider = StateProvider<UserCredential?>((ref) => null);
  final errorStateProvider = StateProvider<String?>((ref) => null);
  final isLoadingProvider = StateProvider<bool>((ref) => false);

  static const debounceTimeMillis = 5000;
  var lastErrorShownTime = 0;

  void _initErrorDebounce() {
    ref.read(errorStateProvider.notifier).state = null;
    Future.delayed(const Duration(milliseconds: debounceTimeMillis), () {
      ref.read(errorStateProvider.notifier).state = null;
    });
  }


  void setErrorMessage(String? errorMessage) {
    final currentTimeMillis = DateTime.now().millisecondsSinceEpoch;
    if (errorMessage != null && (currentTimeMillis - lastErrorShownTime) >= debounceTimeMillis) {
      ref.read(errorStateProvider.notifier).state = errorMessage;
      lastErrorShownTime = currentTimeMillis;
      _initErrorDebounce();
    } else if (errorMessage == null) {
      ref.read(errorStateProvider.notifier).state = null;
      lastErrorShownTime = 0;
    }
  }


  void signUpWithEmailPassword(String email,String password, VoidCallback onSignUp) async{

    try{
      print('Jasmeet- Starting sign up process');
      ref.read(isLoadingProvider.notifier).state = true;
      final result = await repo.signUpWithEmailAndPassword(email, password);
      await repo.saveUserInfo(result);
      ref.read(authStateProvider.notifier).state = result;
      ref.read(isLoadingProvider.notifier).state = false;
      onSignUp();
      print('Jasmeet- Sign up process completed');
    }catch(e){
      print('Jasmeet- Sign up process failed with error: $e');
      setErrorMessage(e.toString());
      ref.read(isLoadingProvider.notifier).state= false;

    }
  }


}