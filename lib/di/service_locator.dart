import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_sign_up/model/repoImpl/FirebaseRepoImpl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import '../model/repo/firebase_repo.dart';

final GetIt getIt = GetIt.instance;

void setUpLocator(){
  getIt.registerSingleton<FirebaseAuth>(FirebaseAuth.instance);
  getIt.registerSingleton<FirebaseFirestore>(FirebaseFirestore.instance);
  getIt.registerSingleton<FirebaseRepo>(
    FirebaseRepoImpl(
      getIt<FirebaseAuth>(),
      getIt<FirebaseFirestore>()
    )
  );
}