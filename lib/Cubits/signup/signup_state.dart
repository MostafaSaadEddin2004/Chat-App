part of 'signup_cubit.dart';

@immutable
class SignUpState {}

class SignUpInitial extends SignUpState {}

class SignUpLoading extends SignUpState {}

class SignUpSuccess extends SignUpState {
  final String successMessage;

  SignUpSuccess({required this.successMessage});
}

class SignUpFailure extends SignUpState {
  final String errorMessage;
  SignUpFailure({required this.errorMessage});
}
