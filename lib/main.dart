import 'package:assingmentotp/firebase_options.dart';
import 'package:assingmentotp/pages/MyHome_Page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:assingmentotp/pages/lang_page.dart';
import 'package:assingmentotp/provider/lang.dart';
import 'app_localizations.dart'; // Adjust path as per your project structure

void main() async {
  SystemUiOverlayStyle systemUiOverlayStyle = const SystemUiOverlayStyle(
    statusBarColor: Colors.black, // Set status bar color here
    statusBarIconBrightness: Brightness.light, // Set status bar icons brightness
  );
  SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle); // Apply the style

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    ChangeNotifierProvider(
      create: (context) => LanguageProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale = const Locale('en');

  void _changeLanguage(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    var languageProvider = Provider.of<LanguageProvider>(context);

    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          locale: languageProvider.locale ?? _locale,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate, // Add this delegate
          ],
          supportedLocales: const [
            Locale('en', ''),
            Locale('es', ''),
          ],
          home: LangPage(),
          // home: ProfileSelectionScreen(),
          routes: {
            '/home': (context) => ProfileSelectionScreen(),
          },
        );
      },
    );
  }
}
