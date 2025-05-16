import 'dart:io';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

final logger = Logger(
  filter: _TestFilter(),
  printer: PrettyPrinter(
    methodCount: 0, // Number of method calls to be displayed
    errorMethodCount: 8, // Number of method calls if stacktrace is provided
    colors: true, // Colorful log messages
    printEmojis: true, // Print an emoji for each log message
    lineLength: 100,
  ),
);

class _TestFilter extends LogFilter {
  static bool isTestMode = Platform.environment.containsKey('FLUTTER_TEST');
  @override
  bool shouldLog(LogEvent event) {
    return !isTestMode;
  }
}

/// All firebase errors should come through this function.
/// If we are in debug mode, then we skip logging the error.
void recordFirebaseError(error, StackTrace? stack,
    {bool fatal = true, reason}) {
  if (kDebugMode) {
    logger.f("Error! $error\nStackTrace: $stack");
    return;
  }

  FirebaseCrashlytics.instance
      .recordError(error, stack, fatal: fatal, reason: reason);
}

mixin ScreenLogger<T extends StatefulWidget> on State<T> {
  late String screenName = widget.runtimeType.toString();

  @override
  void initState() {
    super.initState();
    logger.t("Logging screen view: $screenName");
    if (!kDebugMode) {
      FirebaseAnalytics.instance.logScreenView(
        screenName: screenName,
        screenClass: screenName,
      );
    }
  }
}
