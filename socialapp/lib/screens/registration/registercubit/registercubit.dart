// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../model/create_user.dart';

import 'register_status.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitial());

  static RegisterCubit get(context) => BlocProvider.of(context);
  IconData passicon = Icons.visibility_outlined;
  bool ispass = true;

  void changepassicon() {
    ispass = !ispass;
    passicon =
        ispass ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(Registerchangepassiconstate());
  }

  // late Socialloginmodel registernmodel;

  void userregister(
      {required String email,
      required String pass,
      required String name,
      required String phone}) async {
    emit(Registerloding());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: pass)
        .then((value) {
      // print(value.user!.email);
      // print(value.user!.uid);

      createuser(
          email: email,
          name: name,
          phone: phone,
          uId: value.user!.uid,
          pass: pass);
      // emit(Registersuccess());
    }).catchError((error) {
      print(error.toString());
      emit(RegisterError(error.toString()));
    });
  }

  void createuser({
    required String email,
    //  required String pass,
    required String pass,
    required String name,
    required String phone,
    required String uId,
  }) {
    CreateUser model = CreateUser(
        pass: pass,
        name: name,
        phone: phone,
        email: email,
        uId: uId,
        isverified: false,
        bio: "Write your bio",
        cover:
            "https://img.freepik.com/free-vector/hand-painted-watercolor-abstract-watercolor-background_23-2149009911.jpg?w=996&t=st=1670504386~exp=1670504986~hmac=116b83a6bb1fd39bae7a9faa4ecde83de6c24b8a9941731659a979fffbe4f9c4",
        // "https://img.freepik.com/free-photo/cute-freelance-girl-using-laptop-sitting-floor-smiling_176420-20221.jpg?w=996&t=st=1663844238~exp=1663844838~hmac=ad876ff5df819345ae58e10053e6d5be2e0b9a78f61610616721baccd4bf2dbc",
        image: "https://cdn-icons-png.flaticon.com/512/149/149071.png"
        // "https://img.freepik.com/free-photo/cute-freelance-girl-using-laptop-sitting-floor-smiling_176420-20221.jpg?w=996&t=st=1663844238~exp=1663844838~hmac=ad876ff5df819345ae58e10053e6d5be2e0b9a78f61610616721baccd4bf2dbc"

        );
    FirebaseFirestore.instance
        .collection("user")
        .doc(uId)
        .set(model.toMap())
        .then((value) {
      emit(CreateUsersuccess());
    }).catchError((error) {
      print(error.toString());
      emit(CreateUserError(error.toString()));
    });
  }
}
