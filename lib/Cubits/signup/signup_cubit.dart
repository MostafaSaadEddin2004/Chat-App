import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'signup_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpInitial());
  void signUp({required String email, required String password}) {
    try {
      emit(SignUpLoading());
      Future<void> userRegistration() async {
        // ignore: unused_local_variable
        UserCredential userSignUp = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        emit(SignUpSuccess(successMessage: 'Sign up is successful'));
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == "weak-password") {
        emit(SignUpFailure(errorMessage: 'Weak password'));
      } else if (e.code == "email-already-in-use") {
        emit(SignUpFailure(errorMessage: 'Email is already exist'));
      }
    } catch (e) {
      emit(SignUpFailure(errorMessage: 'Something went wrong'));
    }
  }
}
