import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:spider_water/album/album_description.dart';

import '../analytics/analytics.dart';

class AlbumPage extends StatefulWidget {
  const AlbumPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _AlbumPageState();
  }
}

const style = TextStyle(
  color: Colors.black,
  fontSize: 20,
  fontFamily: 'Blockstepped',
);

class _AlbumPageState extends State<AlbumPage> {
  final analytics =
      SpiderAnalytics(firebaseInstance: FirebaseAnalytics.instance);

  @override
  void didChangeDependencies() {
    loadImages();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    analytics.sendEvent(const AnalyticsEvent(name: "Loaded album page"));

    return SingleChildScrollView(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image.asset(
            'assets/img/album.jpg',
            width: screenWidth / 3,
            height: screenHeight,
          ),
          const AlbumBody(),
        ],
      ),
    );
  }

  Future<void> loadImages() async {
    try {
      await precacheImage(const AssetImage('assets/img/album.jpg'), context);
    } catch (e) {
      debugPrint('Failed to load and cache image: $e');
    }
  }
}

class AlbumBody extends StatelessWidget {
  const AlbumBody({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return SizedBox(
        height: 800,
        width: screenWidth / 2,
        child: Markdown(
          data: description,
          styleSheet: MarkdownStyleSheet(
              a: style, h1: style, h2: style, h3: style, h4: style, p: style),
        ));
  }
}
