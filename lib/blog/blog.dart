import 'package:any_link_preview/any_link_preview.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../analytics/analytics.dart';

class BlogViews extends StatefulWidget {
  const BlogViews({super.key});

  @override
  State<StatefulWidget> createState() => _BlogViewsState();
}

class _BlogViewsState extends State<BlogViews> {
  final analytics =
      SpiderAnalytics(firebaseInstance: FirebaseAnalytics.instance);

  @override
  Widget build(BuildContext context) {
    analytics.sendEvent(const AnalyticsEvent(name: "Loaded blog page"));
    return const SingleChildScrollView(
      child: Column(
        children: [
          ArticleView(
              url:
                  'https://www.humpday.news/music/live-review-the-jungle-spider-water-altered-lemon'),
          ArticleView(
              url:
                  'https://www.humpday.news/music/live-review-silhouette-lounge-spider-water-mystic-river-funk-headfirst-madison-bequer-ana-poulin?rq=spider')
        ],
      ),
    );
  }
}

class ArticleView extends StatelessWidget {
  const ArticleView({super.key, required this.url});

  final String url;

  @override
  Widget build(BuildContext context) {
    const double padding = 70;
    return Padding(
      padding: const EdgeInsets.only(left: padding, right: padding),
      child: AnyLinkPreview(
        link: url,
      ),
    );
  }
}
