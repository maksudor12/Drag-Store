import 'package:drugstore_flutter/constants.dart';
import 'package:drugstore_flutter/screens/medicines_screen.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  await Hive.openBox<Map>('cartBox'); // Box for storing cart items

  if (kIsWeb || Platform.isAndroid || Platform.isWindows) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
          apiKey: 'AIzaSyA2dMIA7QDwkgtVaAvCdmHyvzzdrKFWvPM',
          appId: '1:656806131837:android:b29c32fb14c46d88b4d914',
          messagingSenderId: '656806131837',
          projectId: 'chatapp-12268',
          storageBucket: 'chatapp-12268.appspot.com',),);
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
      home: const MedicinesScreen(),
    );
  }
}
