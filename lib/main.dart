import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'di/service_locator.dart';
import 'model/providers/providers.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyA4DrdeDUzTCpYNGsBjsGLZ9smo8T3fhMw",
          appId: "1:367104753601:android:f901c25ceaa73a1ad83940",
          messagingSenderId: "367104753601",
          projectId: "dmeo-1c159"));
  setUpLocator();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.transparent));
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      home: const HomeScreen(),
      routes: {
        '/home' :(context) => const HomeScreen(),
        '/login' :(context) => const Dummy()
      },
    );
  }
}

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(loginSignUpViewModelProvider.notifier);
    final isLoading = ref.watch(viewModel.isLoadingProvider);
    print("Jasmeet- $isLoading");
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isLoading == true)
              const CircularProgressIndicator()
            else

              const TextField(
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  viewModel.signUpWithEmailPassword(
                      "sjasmet38@gmail.com",
                      "jameet34",
                          () {
                    Navigator.pushReplacementNamed(context, '/login');
                  }
                  );
                },
                child: const Text("SignUp"),
              )
          ],
        ),
      ),
    );
  }
}


class Dummy extends StatelessWidget {
  const Dummy({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        Text("Jasmeet Singh")
      ],),
    );
  }
}

