import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:spider_water/album/album_description.dart';
import 'dart:math';

import '../analytics/analytics.dart';
import '../main.dart';

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
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IntrinsicWidth(
              child: Image.asset(
            'assets/img/album.jpg',
            height: screenHeight / 2,
          )),
          SizedBox(height: 30),
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                StreamingLink(
                    platformName: "Spotify",
                    imagePath: "img/spotify.png",
                    url: "https://open.spotify.com/album/7bzxwIg5XRQwNCrd8gxwEn?si=_llBqDD1R7-7DJ5TUCrAyA",
                    analytics: analytics
                ),
                SizedBox(width: 10),
                StreamingLink(
                    platformName: "Apple Music",
                    imagePath: "img/apple-music.png",
                    url: "https://music.apple.com/us/album/exit-plan/1770647795",
                    analytics: analytics
                ),
                SizedBox(width: 10),
                StreamingLink(
                    platformName: "Bandcamp",
                    imagePath: "img/bandcamp.png",
                    url: "https://spiderwater.bandcamp.com/album/exit-plan",
                    analytics: analytics
                ),
                SizedBox(width: 10),
                StreamingLink(
                    platformName: "YouTube",
                    imagePath: "img/youtube.png",
                    url: "https://www.youtube.com/watch?v=3-77YkBhULA&list=OLAK5uy_ktGt8xtGlPMZMnzFrXnSqSkMsM0jGRZDs",
                    analytics: analytics
                ),
                SizedBox(width: 10),
                StreamingLink(
                    platformName: "TIDAL",
                    imagePath: "img/tidal.png",
                    url: "https://tidal.com/browse/album/389134256",
                    analytics: analytics
                ),
                SizedBox(width: 10),
                StreamingLink(
                    platformName: "Amazon Music",
                    imagePath: "img/amazon-music.png",
                    url: "https://amazon.com/music/player/albums/B0DHTKLLW3?marketplaceId=ATVPDKIKX0DER&musicTerritory=US&ref=dm_sh_MqOazxG3KKccfu9RIoz8GOCDT",
                    analytics: analytics
                ),
                // SizedBox(width: 10),
                // StreamingLink(
                //     platformName: "YouTube Music",
                //     imagePath: "assets/img/youtube-music.png",
                //     url: "https://spiderwater.bandcamp.com/album/exit-plan",
                //     analytics: analytics
                // ),
              ]
          ),
          SizedBox(height: 30),
          const AlbumBody(),
        ],
      ),
    );
  }

  desktopPage(double screenHeight, double screenWidth) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
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
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                StreamingLink(
                    platformName: "Spotify",
                    imagePath: "img/spotify.png",
                    url: "https://open.spotify.com/album/7bzxwIg5XRQwNCrd8gxwEn?si=_llBqDD1R7-7DJ5TUCrAyA",
                    analytics: analytics
                ),
                SizedBox(width: 10),
                StreamingLink(
                    platformName: "Apple Music",
                    imagePath: "img/apple-music.png",
                    url: "https://music.apple.com/us/album/exit-plan/1770647795",
                    analytics: analytics
                ),
                SizedBox(width: 10),
                StreamingLink(
                    platformName: "Bandcamp",
                    imagePath: "img/bandcamp.png",
                    url: "https://spiderwater.bandcamp.com/album/exit-plan",
                    analytics: analytics
                ),
                SizedBox(width: 10),
                StreamingLink(
                    platformName: "YouTube",
                    imagePath: "img/youtube.png",
                    url: "https://www.youtube.com/watch?v=3-77YkBhULA&list=OLAK5uy_ktGt8xtGlPMZMnzFrXnSqSkMsM0jGRZDs",
                    analytics: analytics
                ),
                SizedBox(width: 10),
                StreamingLink(
                    platformName: "TIDAL",
                    imagePath: "img/tidal.png",
                    url: "https://tidal.com/browse/album/389134256",
                    analytics: analytics
                ),
                SizedBox(width: 10),
                StreamingLink(
                    platformName: "Amazon Music",
                    imagePath: "img/amazon-music.png",
                    url: "https://amazon.com/music/player/albums/B0DHTKLLW3?marketplaceId=ATVPDKIKX0DER&musicTerritory=US&ref=dm_sh_MqOazxG3KKccfu9RIoz8GOCDT",
                    analytics: analytics
                ),
                // SizedBox(width: 10),
                // StreamingLink(
                //     platformName: "YouTube Music",
                //     imagePath: "assets/img/youtube-music.png",
                //     url: "https://spiderwater.bandcamp.com/album/exit-plan",
                //     analytics: analytics
                // ),
              ]
          ),
          SizedBox(height: 30),
        ],
      )
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
          selectable: true,
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

class StreamingLink extends StatelessWidget {
  final String platformName;
  final String imagePath;
  final String url;
  final SpiderAnalytics analytics;

  // Constructor with named parameters
  const StreamingLink({
    Key? key,
    required this.platformName,
    required this.imagePath,
    required this.url,
    required this.analytics
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

      return GestureDetector(
        onTap: () {
          analytics.sendEvent(AnalyticsEvent(
              name: "Clicked Streaming Link",
              properties: {"platform": platformName}));
          onUrlTapped(url);
        },
        child: Image.asset(
          imagePath,
          height: max(50, screenWidth / 15),
          width: max(50, screenWidth / 15)
        )
    );
  }
}
