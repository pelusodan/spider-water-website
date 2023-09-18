import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';

import '../analytics/analytics.dart';
import '../main.dart';
import 'face.dart';

class BobbingHead extends StatefulWidget {
  const BobbingHead({super.key, required this.faceIndex});

  final int faceIndex;

  @override
  State<StatefulWidget> createState() {
    return _BobbingHeadState();
  }
}

class _BobbingHeadState extends State<BobbingHead>
    with TickerProviderStateMixin {
  late AnimationController bouncingController;
  late Animation bouncingAnimation;
  final analytics =
      SpiderAnalytics(firebaseInstance: FirebaseAnalytics.instance);
  late Face face;

  @override
  void didChangeDependencies() {
    prefetchImage();
    super.didChangeDependencies();
  }

  @override
  void initState() {
    face = Face.values[widget.faceIndex];
    startAnimation();
    super.initState();
  }

  @override
  void dispose() {
    bouncingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: bouncingAnimation.value,
      child: GestureDetector(
          onTap: () {
            analytics
                .sendEvent(const AnalyticsEvent(name: "Clicked the head!"));
            onUrlTapped("https://www.instagram.com/spiderwaterband/");
          },
          child: Tooltip(
            message: face.tooltip,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Image.asset(
                face.imgPath,
                width: 300,
                height: 300,
              ),
            ),
          )),
    );
  }

  void startAnimation() {
    bouncingController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));

    bouncingAnimation =
        Tween(begin: const Offset(0, 0), end: const Offset(0, -10.0))
            .animate(bouncingController);
    bouncingController.addListener(() => setState(() {}));
    bouncingController.forward();

    bouncingController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        bouncingController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        bouncingController.forward(from: 0.0);
      }
    });
  }

  Future<void> prefetchImage() async {
    try {
      precacheImage(AssetImage(face.imgPath), context);
    } catch (e) {
      debugPrint('Failed to preload head $e');
    }
  }
}
