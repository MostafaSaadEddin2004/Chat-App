import 'package:chat_app/Components/Colors.dart';
import 'package:chat_app/Components/buttons.dart';
import 'package:chat_app/Cubits/signup/signup_cubit.dart';
import 'package:chat_app/functions/show_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  static String id = 'Signup';

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String? email;
  String? password;
  GlobalKey<FormState> formKey = GlobalKey();
  bool isLoading = false;
  bool passwordVisible = true;
  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpCubit, SignUpState>(
      listener: (context, state) {
        if (state is SignUpLoading) {
          isLoading = true;
        } else if (state is SignUpSuccess) {
          showSnackBar(context, state.successMessage);
        } else if (state is SignUpFailure) {
          showSnackBar(context, state.errorMessage);
        }
      },
      child: ModalProgressHUD(
        inAsyncCall: isLoading,
        child: Scaffold(
          backgroundColor: PrimaryColor,
          body: Form(
            key: formKey,
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
                        passwordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
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
                RegistrationButton(
                    onTap: () {
                      if (formKey.currentState!.validate()) {
                        BlocProvider.of<SignUpCubit>(context)
                            .signUp(email: email!, password: password!);
                      }
                    },
                    title: 'Sign Up',
                    isLoading: isLoading),
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
      ),
    );
  }
}
