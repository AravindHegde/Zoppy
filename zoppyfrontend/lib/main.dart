import 'package:flutter/material.dart';
import 'package:zoppyui/AppPages/UserManagement/login.dart';
import 'package:zoppyui/AppPages/UserManagement/signup.dart';
import 'package:zoppyui/AppPages/Dashboard/dashboard.dart';
import 'package:zoppyui/Utility/SecureStorage.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SecureStorage secureStorage = SecureStorage();
  await secureStorage.initialize();
  Widget page = const Login();
  page = const Dashboard();
  if(secureStorage.containsToken()){
    page = const Dashboard();
  }
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: page,
    routes: {
      'signUp': (context) => const SignUp(),
      'login': (context) => const Login(),
      'dashboard' : (context) => const Dashboard()
    },
  ));
}