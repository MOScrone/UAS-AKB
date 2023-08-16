import 'package:flutter/material.dart';
import 'package:getmetour/splashscreen.dart';
import 'package:getmetour/walktg.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:page_transition/page_transition.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Clean Code',
        home: AnimatedSplashScreen(
            duration: 3000,
            splash: SplashScreen(),
            nextScreen: Walktg(),
            splashTransition: SplashTransition
                .scaleTransition, // Transisi animasi dari splash screen (berupa scaling)
            pageTransitionType: PageTransitionType.leftToRight,
            backgroundColor: Color.fromARGB(255, 2, 136, 253)));
  }
}
