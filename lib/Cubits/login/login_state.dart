part of 'login_cubit.dart';

@immutable
class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final String successMessage;

  LoginSuccess({required this.successMessage});
}

class LoginFailure extends LoginState {
  final String errorMessage;
  LoginFailure({required this.errorMessage});
}
