import 'package:flutter/material.dart';
import 'package:vigenesia/register/register.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    title: "APK Vigenesia",
    debugShowCheckedModeBanner: false,
    home: RegisterForm(),
  ));
}
