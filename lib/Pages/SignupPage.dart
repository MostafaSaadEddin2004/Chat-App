import 'package:chat_app/Components/Colors.dart';
import 'package:chat_app/Pages/ChatPage.dart';
import 'package:chat_app/Pages/LoginPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class Signup extends StatefulWidget {
  Signup({super.key});

  static String id = 'Signup';

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  String? email;
  String? password;
  GlobalKey<FormState> formkey = GlobalKey();
  bool isLoading = false;
  bool passwordVisible = true;
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: PrimaryColor,
        body: Form(
          key: formkey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(children: [
              const SizedBox(
                height: 60,
              ),
              Container(
                height: 200,
                width: 200,
                child: const Image(
                  image: AssetImage(
                    'assets/images/scholar_logo.png',
                  ),
                  fit: BoxFit.contain,
                ),
              ),
              const Text(
                'Scholar Chat',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontFamily: 'DancingScript',
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 80,
              ),
              Row(
                children: const [
                  Text(
                    'SIGN UP',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                onChanged: (data) {
                  email = data;
                },
                cursorColor: Colors.white,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.email,
                    color: Colors.white,
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                  label: Text(
                    'Email',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                      gapPadding: 16,
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(10)),
                  focusedBorder: OutlineInputBorder(
                      gapPadding: 16,
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                obscureText: !passwordVisible,
                onChanged: (data) {
                  password = data;
                },
                cursorColor: Colors.white,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.lock,
                    color: Colors.white,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      passwordVisible ? Icons.visibility : Icons.visibility_off,
                      color: WhiteColor,
                    ),
                    onPressed: () {
                      setState(() {
                        passwordVisible = !passwordVisible;
                      });
                    },
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                  label: Text(
                    'Password',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                      gapPadding: 16,
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(10)),
                  focusedBorder: OutlineInputBorder(
                      gapPadding: 16,
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () async {
                  if (formkey.currentState!.validate()) {
                    isLoading = true;
                    setState(() {});
                    try {
                      await userRegistering();
                      Navigator.pushNamed(context, ChatPage.id,
                          arguments: email);
                    } on FirebaseAuthException catch (e) {
                      if (e.code == "weak-password") {
                        showSnackBar(context, 'Weak password');
                      } else if (e.code == "email-already-in-use") {
                        showSnackBar(context, 'Email is already exist');
                      }
                      showSnackBar(context, 'Email is created successfully');
                    }
                    isLoading = false;
                    setState(() {});
                  } else {
                    print('invalid Data');
                  }
                },
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  height: 40,
                  width: double.infinity,
                  child: Text(
                    'Sign up',
                    style: TextStyle(
                        color: Color(0xff314f6a),
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account?',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Log in',
                        style: TextStyle(fontSize: 16),
                      ))
                ],
              ),
            ]),
          ),
        ),
      ),
    );
  }

  void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
      message,
    )));
  }

  Future<void> userRegistering() async {
    UserCredential userR = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email!, password: password!);
  }
}
