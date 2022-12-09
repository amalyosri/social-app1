import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'lodin_status.dart';

class Cubitlogin extends Cubit<LoginStates> {
  Cubitlogin() : super(LoginInitial());

  static Cubitlogin get(context) => BlocProvider.of(context);
  IconData passicon = Icons.visibility_outlined;
  bool ispass = true;

  void changepassicon() {
    ispass = !ispass;
    passicon =
        ispass ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ChangepassIconState());
  }

  //late Socialloginmodel loginmodel;

  void userlogin({required String email, required String pass}) {
    emit(Loginloding());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: pass)
        .then((value) {
      // print(value.user!.email);
      // print(value.user!.uid);
      // print(value.user.pa)
      emit(LoginSuccess(value.user!.uid));
    }).catchError((error) {
      //print(error.toString());
      emit(LoginError(error.toString()));
    });
  }
}
