// ignore_for_file: non_constant_identifier_names, avoid_print, camel_case_types, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:socialapp/screens/login/loginscreen.dart';
import '../../componants/componant.dart';
import 'registercubit/register_status.dart';
import 'registercubit/registercubit.dart';

class Registratin_Screen extends StatelessWidget {
  Registratin_Screen({Key? key}) : super(key: key);
  var formkey = GlobalKey<FormState>();
  var email_controller = TextEditingController();
  var pass_controller = TextEditingController();
  var name_controller = TextEditingController();
  var phone_controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state) {
          if (state is Registersuccess) {
            //   if (state.registermodel.status) {
            //     // print(state.registermodel.data!.token);
            //     // print(state.registermodel.status);
            //     // print(state.registermodel.message);
            //     //token1=state.registermodel.data!.token;
            // CacheHelper.savedata(key: "uid", value: state.registermodel.uid)
            //     .then((value) {
            //   token1 = CacheHelper.getDate(key: "uid");
            //   finash_navigate(context, SocialLayout());
            // });

            //     fluttertost(state.registermodel.message, toststate.Success);
            //   } else {
            //     print(state.registermodel.message);
            //     fluttertost(state.registermodel.message, toststate.Error);
            //   }
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              iconTheme: const IconThemeData(color: Colors.black),
              //title: Text("Salla"),
            ),
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
                          "REGISTER",
                          style: Theme.of(context)
                              .textTheme
                              .headline4!
                              .copyWith(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500),
                        ),
                        Text(
                          "REGISTER now to communicate with friends",
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
                        textfeild(
                            name_controller,
                            "Name",
                            const Icon(Icons.person),
                            TextInputType.name, (val) {
                          if (val!.isEmpty) {
                            return "name must not be empty";
                          }
                          return null;
                        }),
                        const SizedBox(
                          height: 20,
                        ),
                        textfeild(
                            phone_controller,
                            "phone",
                            const Icon(Icons.phone),
                            TextInputType.phone, (val) {
                          if (val!.isEmpty) {
                            return "phone must not be empty";
                          }
                          return null;
                        }),
                        const SizedBox(
                          height: 20,
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
                                    RegisterCubit.get(context).changepassicon();
                                  },
                                  icon: Icon(
                                      RegisterCubit.get(context).passicon))),
                          obscureText: RegisterCubit.get(context).ispass,
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
                                    return state is! Registerloding;
                                  },
                                  widgetBuilder: (context) {
                                    return MaterialButton(
                                        color: Theme.of(context).primaryColor,
                                        child: state is Registerloding
                                            ? const CircularProgressIndicator()
                                            : Text(
                                                "Register",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .subtitle1!
                                                    .copyWith(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w500),
                                              ),
                                        onPressed: () {
                                          if (formkey.currentState!
                                              .validate()) {
                                            RegisterCubit.get(context)
                                                .userregister(
                                              email: email_controller.text,
                                              pass: pass_controller.text,
                                              name: name_controller.text,
                                              phone: phone_controller.text,
                                            );
                                            // if (state is CreateUsersuccess) {
                                            //   return finash_navigate(
                                            //       context, Login_Screen());
                                            // }
                                          }
                                          // if (state is CreateUsersuccess) {
                                          return finash_navigate(
                                              context, Login_Screen());
                                        });
                                  },
                                  fallbackBuilder: (BuildContext context) {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  })),
                        ),
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
