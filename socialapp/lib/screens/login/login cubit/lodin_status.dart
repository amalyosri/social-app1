abstract class LoginStates {}

class LoginInitial extends LoginStates {}

class LoginSuccess extends LoginStates {
  String uId;
  LoginSuccess(this.uId);
}

class Loginloding extends LoginStates {}

class LoginError extends LoginStates {
  String error;
  LoginError(this.error);
}

class ChangepassIconState extends LoginStates {}
