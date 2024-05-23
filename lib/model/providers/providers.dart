import 'package:demo_sign_up/di/service_locator.dart';
import 'package:demo_sign_up/model/repo/firebase_repo.dart';
import 'package:demo_sign_up/viewModel/LoginSignUpViewModel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final firebaseRepoProvider = Provider<FirebaseRepo>((ref){
  return getIt<FirebaseRepo>();
});


final loginSignUpViewModelProvider = StateNotifierProvider.autoDispose((ref){
  final repo = ref.watch(firebaseRepoProvider);
  return Loginsignupviewmodel(repo,ref);
});