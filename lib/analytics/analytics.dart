import 'package:firebase_analytics/firebase_analytics.dart';

class SpiderAnalytics {
  final FirebaseAnalytics firebaseInstance;

  SpiderAnalytics({required this.firebaseInstance});

  sendEvent(AnalyticsEvent event) async {
    return await firebaseInstance.logEvent(
        name: event.name, parameters: event.properties);
  }
}

class AnalyticsEvent {
  final String name;
  final Map<String, Object>? properties;

  const AnalyticsEvent({required this.name, this.properties});
}
