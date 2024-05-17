import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:mis_marcas/models/SwimTime.dart';
import 'package:mis_marcas/pages/home_bottom_navigation_bar_page.dart';
import 'package:mis_marcas/pages/home_navigation_drawe_page.dart';
import 'package:mis_marcas/pages/home_tabs_page.dart';
import 'package:mis_marcas/pages/login_page.dart';
import 'package:mis_marcas/pages/register_page.dart';
import 'package:mis_marcas/pages/splash_page.dart';
import 'firebase_options.dart';

Future<void> main() async{
  await Hive.initFlutter();

  Hive.registerAdapter(SwimTimeAdapter());

  await Hive.openBox<SwimTime>('swimTimes');
  runApp(const MyApp());
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mis marcas',
      localizationsDelegates: const[
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const[
        Locale("es", "CO"),
        Locale("es", "US")
      ],
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        useMaterial3: true,
      ),
      home: const SplashPage(),
    );
  }
}