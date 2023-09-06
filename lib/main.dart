import 'dart:js' as js;
import 'dart:ui';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:spider_water/shows.dart';

import 'bobbing_head.dart';

void main() {
  runApp(const MyApp());
}

class DraggableScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        // etc.
      };
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scrollBehavior: DraggableScrollBehavior(),
      title: 'SPIDER WATER',
      theme: ThemeData(scaffoldBackgroundColor: Colors.black),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(title: 'Spider Water'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return mainPageContent(screenWidth, screenHeight);
  }

  Widget mainPageContent(double screenWidth, double screenHeight) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        tabBarTheme: TabBarTheme(
          indicator: UnderlineTabIndicator(
            borderSide: BorderSide(color: Colors.white),
          ),
          labelColor: Colors.white,
          labelStyle: TextStyle(
            color: Colors.black,
            fontSize: screenHeight / 50,
            fontFamily: 'Blockstepped',
          ),
          unselectedLabelStyle: TextStyle(
            color: Colors.black,
            fontSize: screenHeight / 50,
            fontFamily: 'Blockstepped',
          ),
        ),
        primaryColor: Colors.white,
      ),
      home: DefaultTabController(
          length: 3,
          child: Scaffold(
            appBar: AppBar(
              title: DefaultTextStyle(
                style: TextStyle(
                  color: Colors.white,
                  fontSize: screenHeight / 8,
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
              toolbarHeight: 150,
              backgroundColor: Colors.black,
              bottom: const TabBar(tabs: <Widget>[
                Tab(
                  text: "home",
                ),
                Tab(
                  text: "the vibe",
                ),
                Tab(
                  text: "the humdingers",
                )
              ]),
            ),
            body: TabBarView(children: <Widget>[
              SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const BobbingHead(),
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
              ),
              SecondPage(),
              SecondPage(),
            ]),
          )),
    );
  }

  Widget SecondPage() {
    return Text("todo");
  }
}

void onUrlTapped(String? repoLink) {
  if (repoLink == null) return;
  js.context.callMethod('open', [repoLink]);
}

class ShowsView extends StatelessWidget {
  final double screenHeight;

  ShowsView(this.screenHeight);

  @override
  Widget build(BuildContext context) {
    var futureDates =
        ShowList.where((element) => element.date.isAfter(DateTime.now()))
            .toList();
    final DateFormat formatter = DateFormat('M-dd');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var show in futureDates)
          GestureDetector(
            onTap: () {
              onUrlTapped(show.url);
            },
            child: Wrap(
              direction: Axis.horizontal,
              children: [
                DefaultTextStyle(
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: screenHeight / 23,
                    fontFamily: 'Blockstepped',
                  ),
                  child: Text(
                    "-${show.title}",
                  ),
                ),
                const Padding(padding: EdgeInsets.all(5)),
                DefaultTextStyle(
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: screenHeight / 30,
                    fontFamily: 'Blockstepped',
                  ),
                  child: Text(
                    "${formatter.format(show.date)} @ ${DateFormat.jm().format(show.date)}",
                  ),
                ),
              ],
            ),
          )
      ],
    );
  }
}
