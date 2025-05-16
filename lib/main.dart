import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:swipe_clean/screens/home_screen.dart';
import 'package:swipe_clean/services/firebase_service.dart';
import 'package:swipe_clean/theme/theme.dart';
import 'package:swipe_clean/utils/logger.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  initFirebaseStuff();
  await FirebaseService.initService();

  runApp(const MainApp());
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey();

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      theme: themeData,
      home: HomeScreen(),
    );
  }
}

void initFirebaseStuff() {
  try {
    FlutterError.onError = (errorDetails) {
      recordFirebaseError(errorDetails.exception, errorDetails.stack);
    };

    // Pass all uncaught asynchronous errors that aren't handled by the Flutter
    // framework to Crashlytics
    PlatformDispatcher.instance.onError = (error, stack) {
      recordFirebaseError(error, stack, fatal: true);
      return true;
    };
  } catch (e, stack) {
    recordFirebaseError(e, stack);
  }
}
