import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:spider_water/home/shows.dart';
import 'package:spider_water/hover_text.dart';

import '../main.dart';

class ShowsView extends StatelessWidget {
  final double screenHeight;
  final bool isMobile;

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
          GestureDetector(
            onTap: () {
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
      ],
    );
  }
}
