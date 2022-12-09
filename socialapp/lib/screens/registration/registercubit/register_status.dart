abstract class RegisterStates {}

class RegisterInitial extends RegisterStates {}

class Registersuccess extends RegisterStates {}

class Registerloding extends RegisterStates {}

class RegisterError extends RegisterStates {
  String error;
  RegisterError(this.error);
}

class Registerchangepassiconstate extends RegisterStates {}

class CreateUserError extends RegisterStates {
  String error;
  CreateUserError(this.error);
}

class CreateUsersuccess extends RegisterStates {}
