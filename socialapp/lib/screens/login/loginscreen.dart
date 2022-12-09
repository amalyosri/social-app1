// ignore_for_file: avoid_print, non_constant_identifier_names, must_be_immutable, camel_case_types

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import '../../componants/componant.dart';
import '../../componants/constunt.dart';
import '../../dio_helper/cashe_helper.dart';
import '../registration/registerscreen.dart';
import '../social_layout.dart';
import 'login cubit/lodin_status.dart';
import 'login cubit/lodingcubit.dart';

class Login_Screen extends StatelessWidget {
  Login_Screen({Key? key}) : super(key: key);
  var formkey = GlobalKey<FormState>();
  var email_controller = TextEditingController();
  var pass_controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => Cubitlogin(),
      child: BlocConsumer<Cubitlogin, LoginStates>(
        listener: (context, state) {
          if (state is LoginError) {
            fluttertost(state.error, toststate.Error);
          } else if (state is LoginSuccess) {
            CacheHelper.savedata(key: "uId", value: state.uId).then((value) {
              token1 = state.uId;
              finash_navigate(context, const SocialLayout());
            });
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formkey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "LOGIN",
                          style: Theme.of(context)
                              .textTheme
                              .headline4!
                              .copyWith(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500),
                        ),
                        Text(
                          "Login now to communicate with friends",
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1!
                              .copyWith(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          controller: email_controller,
                          decoration: const InputDecoration(
                            labelText: "Email",
                            prefixIcon: Icon(Icons.email),
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.emailAddress,
                          onFieldSubmitted: (val) {
                            print(val);
                          },
                          validator: (val) {
                            if (val!.isEmpty) {
                              return "email must not empty";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: pass_controller,
                          decoration: InputDecoration(
                              labelText: "Password",
                              prefixIcon: const Icon(Icons.lock_rounded),
                              border: const OutlineInputBorder(),
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    Cubitlogin.get(context).changepassicon();
                                  },
                                  icon:
                                      Icon(Cubitlogin.get(context).passicon))),
                          obscureText: Cubitlogin.get(context).ispass,
                          keyboardType: TextInputType.text,
                          validator: (val) {
                            if (val!.isEmpty) {
                              return "pass must not be empty";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: SizedBox(
                              width: double.infinity,
                              child: Conditional.single(
                                  context: context,
                                  conditionBuilder: (BuildContext context) {
                                    return state is! Loginloding;
                                  },
                                  widgetBuilder: (context) {
                                    return MaterialButton(
                                      color: Theme.of(context).primaryColor,
                                      child: Text(
                                        "login",
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1!
                                            .copyWith(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w500),
                                      ),
                                      onPressed: () {
                                        if (formkey.currentState!.validate()) {
                                          Cubitlogin.get(context).userlogin(
                                              email: email_controller.text,
                                              pass: pass_controller.text);
                                          // finash_navigate(
                                          //     context, SocialLayout());
                                        }

                                        // finash_navigate(
                                        //     context, SocialLayout());
                                      },
                                    );
                                  },
                                  fallbackBuilder: (BuildContext context) {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  })),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Don't have an account?",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            Registratin_Screen()),
                                  );
                                },
                                child: Text("REGISTER",
                                    style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontWeight: FontWeight.bold))),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
