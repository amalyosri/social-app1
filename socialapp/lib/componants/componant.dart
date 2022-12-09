// ignore_for_file: non_constant_identifier_names, camel_case_types, constant_identifier_names, prefer_typing_uninitialized_variables, avoid_print, sort_child_properties_last

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
// import 'package:path/path.dart' as path;
import 'package:socialapp/style/icon_broken.dart';

void finash_navigate(context, widgit) {
  Navigator.pushAndRemoveUntil(context,
      MaterialPageRoute(builder: (context) => widgit), (route) => false);
}

void fluttertost(msg, toststate state) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: changecolortost(state),
      textColor: Colors.white,
      fontSize: 16.0);
}

enum toststate {
  Error,
  Success,
  Warning,
}

Color changecolortost(toststate state) {
  var color;

  switch (state) {
    case toststate.Error:
      color = Colors.red;
      break;

    case toststate.Success:
      color = Colors.green;
      break;

    case toststate.Warning:
      color = Colors.yellow;
      break;
  }

  return color;
}

Widget myDivider() => Padding(
      padding: const EdgeInsetsDirectional.only(start: 20.0),
      child: Container(
        width: double.infinity,
        height: 1.0,
        color: Colors.grey[300],
      ),
    );

Widget textfeild(controller, label, prefixicon, type, validate, {onchang}) {
  return TextFormField(
    controller: controller,
    decoration: InputDecoration(
      labelText: label,
      prefixIcon: prefixicon,
      border: const OutlineInputBorder(),
    ),
    keyboardType: type,
    validator: validate,
    onChanged: onchang,
  );
}

Widget verifiedMsgEmail() {
  var model = FirebaseAuth.instance.currentUser!.emailVerified;
  return Column(
    children: [
      // if (SocialCubit.get(context).model!.isverified != true)
      if (!model)
        Container(
          color: const Color.fromARGB(255, 233, 199, 100),
          child: Row(
            children: [
              const SizedBox(
                width: 10,
              ),
              const Icon(Icons.info_outline),
              const Text("Please verify your email "),
              const Spacer(),
              TextButton(
                  onPressed: () {
                    FirebaseAuth.instance.currentUser
                        ?.sendEmailVerification()
                        .then((value) {
                      fluttertost("check your mail", toststate.Success);
                    }).catchError((error) {
                      print(error.toString());
                    });
                  },
                  child: const Text("Send"))
            ],
          ),
        ),
    ],
  );
}

Widget defaultButton(
    {required String? text,
    required function,
    bool isuppercase = true,
    color,
    radius = 5.0,
    required context}) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(radius),
      color: color ?? Theme.of(context).primaryColor,
    ),
    height: 40,
    width: double.infinity,
    child: MaterialButton(
      child: Text(
        isuppercase ? text!.toUpperCase() : text!,
        style: const TextStyle(color: Colors.white),
        textAlign: TextAlign.center,
      ),
      onPressed: function,
    ),
  );
}

Future navigateto(context, widget) {
  return Navigator.push(
      context, MaterialPageRoute(builder: (context) => widget));
}

AppBar appbar({title, context, List<Widget>? actions}) {
  return AppBar(
    titleSpacing: 0.0,
    title: Text(title),
    leading: IconButton(
      onPressed: () {
        Navigator.pop(context);
      },
      icon: const Icon(IconBroken.Arrow___Left_2),
    ),
    actions: actions,
  );
}

datetime(String date) {
  var time = DateFormat("MMM d, yyyy").format(DateTime.parse(date));
  return time;
}
