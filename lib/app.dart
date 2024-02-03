import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';
import 'package:adaptive_inscribe/utils/color.dart';

import 'auth/login.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (BuildContext context, Widget? child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: primaryBlack,
          ),
          home: AnimatedSplashScreen(
            splash: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Image(
                    image: AssetImage('assets/applogo.png'),
                    height: 150,
                    width: 150.0,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "AI Notepad",
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                )
              ],
            ),
            backgroundColor: Colors.white,
            nextScreen: const LoginScreen(),
            splashIconSize: 250,
            duration: 3000,
            splashTransition: SplashTransition.fadeTransition,
            pageTransitionType: PageTransitionType.leftToRightWithFade,
            animationDuration: const Duration(seconds: 1),
          ),
        );
      },
    );
  }
}
