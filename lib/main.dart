import 'dart:js' as js;
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:spider_water/insta_content.dart';

import 'home_page_content.dart';

void main() {
  runApp(const MyApp());
}

class DraggableScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        // etc.
      };
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
        tabBarTheme: TabBarTheme(
          indicator: const UnderlineTabIndicator(
            borderSide: BorderSide(color: Colors.transparent),
          ),
          labelColor: Colors.black,
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
      ),
      home: DefaultTabController(
          length: 1, //todo add a new page
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
                shadowColor: Colors.transparent,
                toolbarHeight: 0,
                backgroundColor: Colors.white,
                bottom: PreferredSize(
                  preferredSize: Size.fromHeight(screenHeight / 16),
                  child: const Align(
                    alignment: Alignment.centerLeft,
                    child: TabBar(
                        isScrollable: true,
                        tabAlignment: TabAlignment.start,
                        tabs: <Widget>[
                          Tab(
                            text: "home",
                          ),
                          /*Tab(
                            text: "the vibe",
                          )*/
                        ]),
                  ),
                )),
            body: TabBarView(children: <Widget>[
              HomePageContent(),
              //InstaContent(), todo make ig work here
            ]),
          )),
    );
  }
}

void onUrlTapped(String? repoLink) {
  if (repoLink == null) return;
  js.context.callMethod('open', [repoLink]);
}
