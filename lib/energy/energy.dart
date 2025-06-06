import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../analytics/analytics.dart';

class EnergyViews extends StatefulWidget {
  const EnergyViews({super.key});

  @override
  State<StatefulWidget> createState() => _EnergyViewsState();
}

class _EnergyViewsState extends State<EnergyViews> {
  final analytics =
      SpiderAnalytics(firebaseInstance: FirebaseAnalytics.instance);

  @override
  void didChangeDependencies() {
    loadImages();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    analytics.sendEvent(const AnalyticsEvent(name: "Loaded energy page"));
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Image.asset('assets/img/dan-union.jpg'), // Dan's image
              ),
              Expanded(
                child: Image.asset('assets/img/emma-union.jpg'), // Emma's image
              ),
            ],
          ),
          Image.asset('assets/img/stew5.jpg'),
          Image.asset('assets/img/stew1.jpg'),
          Image.asset('assets/img/stew2.jpg'),
          Image.asset('assets/img/stew3.jpg'),
          Image.asset('assets/img/stew4.jpg'),
        ],
      ),
    );
  }

  Future<void> loadImages() async {
    try {
      // Precache new images
      await precacheImage(AssetImage('assets/img/dan-union.jpg'), context);
      await precacheImage(AssetImage('assets/img/emma-union.jpg'), context);
      
      // Precache existing images
      for (var i = 1; i < 6; i++) {
        await precacheImage(AssetImage('assets/img/stew$i.jpg'), context);
      }
    } catch (e) {
      debugPrint('Failed to load and cache image: $e');
    }
  }
}
