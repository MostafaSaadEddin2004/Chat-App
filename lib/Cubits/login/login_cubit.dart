import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  void logIn({required String email, required String password}) {
    try {
      emit(LoginLoading());
      Future<void> userLogin() async {
        // ignore: unused_local_variable
        UserCredential userLogIn = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);
        emit(LoginSuccess(successMessage: 'Login is successful'));
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        emit(LoginFailure(errorMessage: 'User is not exist'));
      } else if (e.code == "wrong-password") {
        emit(LoginFailure(errorMessage: "Email and password don't match"));
      }
    } catch (e) {
      emit(LoginFailure(errorMessage: 'Something went wrong'));
    }
  }
}
