import 'package:chat_app/Cubits/login/login_cubit.dart';
import 'package:chat_app/Cubits/signup/signup_cubit.dart';
import 'package:chat_app/Pages/ChatPage.dart';
import 'package:chat_app/Pages/SignupPage.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/Pages/LoginPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MainPage());
}

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers:[
        BlocProvider(create: (context)=> LoginCubit()),
        BlocProvider(create: (context)=> SignUpCubit()),
        ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          Login.id: (context) => const Login(),
          SignUp.id: (context) => const SignUp(),
          ChatPage.id: (context) => ChatPage(),
        },
        initialRoute: Login.id,
      ),
    );
  }
}
