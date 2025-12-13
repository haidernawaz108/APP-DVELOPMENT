import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'login.dart';
import 'signup.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 🔥 Firebase Initialize for Flutter Web + Android
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyDgW2aOomTNznUz2Nyrap3cuVITKCr5GYs",
      authDomain: "car-rental-app-a1cad.firebaseapp.com",
      projectId: "car-rental-app-a1cad",
      storageBucket: "car-rental-app-a1cad.firebasestorage.app",
      messagingSenderId: "282875979256",
      appId: "1:282875979256:web:67a80df67be1aba0c8620d",
    ),
  );

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: 'login',
    routes: {
      'login': (context) => MyLogin(),
      'signup': (context) => MySignup(),
    },
  ));
}
