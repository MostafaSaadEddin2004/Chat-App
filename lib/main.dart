import 'package:chat_app/Pages/ChatPage.dart';
import 'package:chat_app/Pages/SignupPage.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/Pages/LoginPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MainPage());
}

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        Login.id: (context) => Login(),
        Signup.id: (context) => Signup(),
        ChatPage.id: (context)=> ChatPage(),
      },
      initialRoute: Login.id,
    );
  }
}
