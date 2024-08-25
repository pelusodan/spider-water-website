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
  fontSize: 14,
  fontFamily: 'Blockstepped',
);

const styleh1 = TextStyle(
  color: Colors.black,
  fontSize: 28,
  fontFamily: 'Blockstepped',
);

const styleh2 = TextStyle(
  color: Colors.black,
  fontSize: 24,
  fontFamily: 'Blockstepped',
);

const styleh3 = TextStyle(
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

    return screenWidth < 450
        ? mobilePage(screenHeight)
        : desktopPage(screenHeight, screenWidth);
  }

  Future<void> loadImages() async {
    try {
      await precacheImage(const AssetImage('assets/img/album.jpg'), context);
    } catch (e) {
      debugPrint('Failed to load and cache image: $e');
    }
  }

  mobilePage(double screenHeight) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IntrinsicWidth(
              child: Image.asset(
            'assets/img/album.jpg',
            height: screenHeight / 2,
          )),
          const AlbumBody(),
        ],
      ),
    );
  }

  desktopPage(double screenHeight, double screenWidth) {
    return SingleChildScrollView(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IntrinsicHeight(
              child: Image.asset(
            'assets/img/album.jpg',
            width: screenWidth / 3,
          )),
          const AlbumBody(),
        ],
      ),
    );
  }
}

class AlbumBody extends StatelessWidget {
  const AlbumBody({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return SizedBox(
        height: screenWidth < 450 ? 800 : screenWidth * .45,
        width: screenWidth < 450 ? 800 : screenWidth * .45,
        child: MarkdownBody(
          data: description,
          styleSheet: MarkdownStyleSheet(
              a: style,
              h1: styleh1,
              h2: styleh2,
              h3: styleh3,
              h4: style,
              p: style),
        ));
  }
}
