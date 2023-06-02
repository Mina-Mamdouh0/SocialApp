abstract class SignUpStates{}

class InitialState extends SignUpStates{}

class LoadingSignUpScreen extends SignUpStates{}

class SuccessSignUpScreen extends SignUpStates{}

class ErrorSignUpScreen extends SignUpStates{
  final String error;
  ErrorSignUpScreen(this.error);
}

class LoadingCreateUserScreen extends SignUpStates{}

class SuccessCreateUserScreen extends SignUpStates{}

class ErrorCreateUserScreen extends SignUpStates{
  final String error;
  ErrorCreateUserScreen(this.error);
}

class VisiblePasswordSignUp extends SignUpStates{}



