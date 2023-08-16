import 'package:getmetour/button.dart';
import 'package:getmetour/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_walkthrough_screen/flutter_walkthrough_screen.dart';
import 'package:getmetour/jadwal.dart';
// dapet dari pub.dev

class Walktg extends StatelessWidget {
  /*here we have a list of OnbordingScreen which we want to have, each OnbordingScreen have a imagePath,title and an desc.
      */
  final List<OnbordingData> list = [
    OnbordingData(
      image: AssetImage("assets/images/wk1.png"),
      titleText: Text("Welcome to Getmetour"),
      descText: Text("Let's make tournament"),
    ),
    OnbordingData(
      image: AssetImage("assets/images/wk2.png"),
      titleText: Text("Ready to fight?"),
      descText: Text("Make a great team with your friends"),
    ),
    OnbordingData(
      image: AssetImage("assets/images/wk3.png"),
      titleText: Text("Champion"),
      descText: Text("Be the number one"),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    /* remove the back button in the AppBar is to set automaticallyImplyLeading to false
  here we need to pass the list and the route for the next page to be opened after this. */
    return IntroScreen(
      onbordingDataList: list,
      colors: [
        //list of colors for per pages
        Colors.white,
        Colors.red,
      ],
      pageRoute: MaterialPageRoute(
        builder: (context) => Button(),
      ),
      nextButton: Text(
        "NEXT",
        style: TextStyle(
          color: Colors.purple,
        ),
      ),
      lastButton: Text(
        "GOT IT",
        style: TextStyle(
          color: Colors.purple,
        ),
      ),
      skipButton: Text(
        "SKIP",
        style: TextStyle(
          color: Colors.purple,
        ),
      ),
      selectedDotColor: Colors.orange,
      unSelectdDotColor: Colors.grey,
    );
  }
}
