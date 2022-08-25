import 'package:la_vie/models/login_model.dart';

abstract class LoginStates {}

class LoginInitialState extends LoginStates {}

class LoginLoadingState extends LoginStates {}

class LoginSuccessState extends LoginStates {
  final LoginModel loginModel;

  LoginSuccessState(this.loginModel);
}

class LoginErrorState extends LoginStates {
  dynamic error;

  LoginErrorState(this.error);
}

class SignUpLoadingState extends LoginStates {}

class SignUpSuccessState extends LoginStates {}

class SignUpErrorState extends LoginStates {
  final String? error;

  SignUpErrorState(this.error);
}

class PasswordShow extends LoginStates {}

class SuffixColorChange extends LoginStates {}
