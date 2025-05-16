import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:swipe_clean/services/firebase_service.dart';
import 'package:swipe_clean/utils/logger.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  initFirebaseStuff();
  await FirebaseService.initService();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(body: Center(child: Text('Hello World!'))),
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
