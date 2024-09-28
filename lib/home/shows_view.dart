import 'dart:convert';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:spider_water/home/shows.dart';
import 'package:spider_water/hover_text.dart';

import '../analytics/analytics.dart';
import '../main.dart';

class ShowsView extends StatelessWidget {
  final double screenHeight;
  final bool isMobile;
  final analytics =
      SpiderAnalytics(firebaseInstance: FirebaseAnalytics.instance);

  ShowsView(this.screenHeight, [this.isMobile = false]);

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
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () {
                analytics.sendEvent(AnalyticsEvent(
                    name: "Clicked show",
                    properties: {"show": jsonEncode(show)}));
                onUrlTapped(show.url);
              },
              child: Wrap(
                direction: Axis.horizontal,
                children: [
                  HoverText(
                      baseColor: Colors.black,
                      hoverColor: Colors.red,
                      textStyle: TextStyle(
                        color: Colors.black,
                        fontSize: isMobile ? 20 : screenHeight / 23,
                        fontFamily: 'Blockstepped',
                      ),
                      child: Text("-${show.title}")),
                  const Padding(padding: EdgeInsets.all(5)),
                  HoverText(
                      baseColor: Colors.red,
                      hoverColor: Colors.black,
                      textStyle: TextStyle(
                        color: Colors.red,
                        fontSize: isMobile ? 16 : screenHeight / 30,
                        fontFamily: 'Blockstepped',
                      ),
                      child: Text(
                        "${formatter.format(show.date)} @ ${DateFormat.jm().format(show.date)}",
                      ))
                ],
              ),
            )
          )
      ],
    );
  }
}
