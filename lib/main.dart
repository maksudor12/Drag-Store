import 'package:drugstore_flutter/constants.dart';
import 'package:drugstore_flutter/screens/medicines_screen.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

/*
flutter run -d web-server --web-port=9000
Developed By
Name: Mirza Mojahid
Github: github.com/mirzamojahid
Email: mojahid@shohayok.com
Whatsapp: +8801872945299
Learn more: https://shohayok.com
*/

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  await Hive.openBox<Map>('cartBox'); // Box for storing cart items

  if (kIsWeb || Platform.isAndroid || Platform.isWindows) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyAUrLYKZn5yjLIpV9rIRm24LBLFq4GoNdA",
            appId: "1:441491973614:android:825bfebd86b45350e9daff",
            messagingSenderId: "441491973614",
            storageBucket: 'drugstore-flutter.firebasestorage.app',
            projectId: "drugstore-flutter"));
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title:Constants.app_name,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MedicinesScreen(),
    );
  }
}
