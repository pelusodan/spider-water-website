import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:spider_water/shows_view.dart';

import 'bobbing_head.dart';

class HomePageContent extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageContentState();
  }
}

class _HomePageContentState extends State<HomePageContent> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return screenWidth < 450
        ? mobilePage(screenHeight)
        : desktopPage(screenHeight, screenWidth);
  }

  Widget desktopPage(double screenHeight, double screenWidth) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const BobbingHead(),
          DefaultTextStyle(
            style: TextStyle(
              color: Colors.black,
              fontSize: screenWidth / 8,
              fontFamily: 'Blockstepped',
            ),
            child: AnimatedTextKit(
              animatedTexts: [
                TypewriterAnimatedText('spider water',
                    speed: const Duration(milliseconds: 500)),
              ],
              isRepeatingAnimation: false,
            ),
          ),
          const Padding(padding: EdgeInsets.all(20)),
          ShowsView(screenHeight),
          const Padding(padding: EdgeInsets.all(40)),
          DefaultTextStyle(
            style: TextStyle(
              color: Colors.black,
              fontSize: screenHeight / 40,
              fontFamily: 'Blockstepped',
            ),
            child: const Text(
              "cambridge ma - synth pop for debutants",
            ),
          )
        ],
      ),
    );
  }

  Widget mobilePage(double screenHeight) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const BobbingHead(),
          DefaultTextStyle(
            style: TextStyle(
              color: Colors.black,
              fontSize: screenHeight / 20,
              fontFamily: 'Blockstepped',
            ),
            child: AnimatedTextKit(
              animatedTexts: [
                TypewriterAnimatedText('spider water',
                    speed: const Duration(milliseconds: 500)),
              ],
              isRepeatingAnimation: false,
            ),
          ),
          const Padding(padding: EdgeInsets.all(15)),
          ShowsView(screenHeight, true),
          const Padding(padding: EdgeInsets.all(40)),
          DefaultTextStyle(
            style: TextStyle(
              color: Colors.black,
              fontSize: screenHeight / 40,
              fontFamily: 'Blockstepped',
            ),
            child: const Text(
              "cambridge ma - synth pop for debutants",
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }
}
