// ignore_for_file: use_key_in_widget_constructors, avoid_print, unused_local_variable, deprecated_member_use

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/componants/componant.dart';
import 'package:socialapp/style/themes.dart';
import 'componants/constunt.dart';
import 'cubit/bloc_observer.dart';
import 'cubit/social_cubit.dart';
import 'cubit/social_state.dart';
import 'dio_helper/cashe_helper.dart';
import 'dio_helper/dio_helper.dart';
import 'screens/login/loginscreen.dart';
import 'screens/social_layout.dart';

Future<void> firebaseMessagingBackgroundHndle(RemoteMessage message) async {
  print(message.data.toString());
  fluttertost("back ground handel", toststate.Success);
}

void main() async {
  BlocOverrides.runZoned(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp();
      DioHelper.init();
      await CacheHelper.init();

      var token = await FirebaseMessaging.instance.getToken();
      print(token);

      FirebaseMessaging.onMessage.listen((event) {
        print(event.data.toString());
        fluttertost("message when app open", toststate.Success);
      });

      FirebaseMessaging.onMessageOpenedApp.listen((event) {
        print(event.data.toString());
        fluttertost("back ground message", toststate.Success);
      });

      FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHndle);

      Widget widget1;
      bool? onboarding = CacheHelper.getDate(key: "onboarding");
      // token1 = CacheHelper.getDate(key: "token");
      token1 = CacheHelper.getDate(key: "uId");
      print(token1);
      // if (onboarding != null) {
      //   if (token1 != null) {
      //     widget1 = layoutshop();
      //   } else {
      //     widget1 = login_screen();
      //   }
      // }
      // else {
      //   widget1 = story();
      // }
      //flutter.compileSdkVersion
      //flutter.targetSdkVersion
      // flutter.minSdkVersion

      if (token1 != null) {
        widget1 = const SocialLayout();
      } else {
        widget1 = Login_Screen();
      }
      runApp(MyApp(widget1));
    },
    blocObserver: MyBlocObserver(),
  );
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  Widget? widget1;
  MyApp(this.widget1);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => SocialCubit()
          ..getUserData()
          ..gethomedata(),
        child: BlocConsumer<SocialCubit, SocialStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return MaterialApp(
              title: 'Flutter Demo',
              debugShowCheckedModeBanner: false,
              theme: lightTheme,
              themeMode: ThemeMode.light,
              home: widget1,
            );
          },
        ));
  }
}
