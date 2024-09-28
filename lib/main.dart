import 'dart:js' as js;
import 'dart:math';
import 'dart:ui';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:spider_water/analytics/analytics.dart';
import 'package:spider_water/energy/energy.dart';

import 'album/album.dart';
import 'analytics/firebase_options.dart';
import 'home/face.dart';
import 'home/home_page_content.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
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
  MyApp({super.key});

  final random = Random();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scrollBehavior: DraggableScrollBehavior(),
      title: 'SPIDER WATER',
      theme: ThemeData(scaffoldBackgroundColor: Colors.black),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(
          title: 'Spider Water', faceIndex: random.nextInt(Face.values.length)),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title, required this.faceIndex});

  final String title;
  final int faceIndex;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final analytics =
      SpiderAnalytics(firebaseInstance: FirebaseAnalytics.instance);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    analytics.sendEvent(const AnalyticsEvent(name: "Load Home Screen"));
    return mainPageContent(screenWidth, screenHeight);
  }

  Widget mainPageContent(double screenWidth, double screenHeight) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        tabBarTheme: TabBarTheme(
          indicator: const UnderlineTabIndicator(
            borderSide: BorderSide(color: Colors.black),
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
          length: 3,
          initialIndex: 2, // make album the default page during promo cycle
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
                          Tab(
                            text: "energy",
                          ),
                          Tab(
                            text: "album",
                          )
                        ]),
                  ),
                )),
            body: TabBarView(children: <Widget>[
              HomePageContent(faceIndex: widget.faceIndex),
              const EnergyViews(),
              const AlbumPage(),
            ]),
          )),
    );
  }
}

void onUrlTapped(String? repoLink) {
  if (repoLink == null) return;
  js.context.callMethod('open', [repoLink]);
}

const mobileWidthCutoff = 600;