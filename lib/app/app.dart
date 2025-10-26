
import 'package:ecommerce_project/app/routes.dart';
import 'package:ecommerce_project/features/auth/presentation/screens/sign_in_screen.dart';
import 'package:ecommerce_project/features/auth/presentation/screens/sign_up_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';

import '../features/auth/presentation/screens/splash_screen.dart';
import '../l10n/app_localizations.dart';
import 'app_theme.dart';
import 'controller_binder.dart';
import 'controllers/language_controller.dart';

class CraftyBay extends StatefulWidget {
  const CraftyBay({super.key});

  static final GlobalKey<NavigatorState> navigatorKey =
  GlobalKey<NavigatorState>();


  static final LanguageController languageController = LanguageController();

  @override
  State<CraftyBay> createState() => _CraftyBayState();
}

class _CraftyBayState extends State<CraftyBay> {
 // static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
 // static FirebaseAnalyticsObserver observer = FirebaseAnalyticsObserver(
  //  analytics: analytics,
 // );

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: CraftyBay.languageController,
      builder: (languageController) {
        return GetMaterialApp(
          navigatorKey: CraftyBay.navigatorKey,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
        //  navigatorObservers: [observer],
          locale: languageController.currentLocale,
          supportedLocales: languageController.supportedLocales,
          theme: AppTheme.lightThemeData,
          darkTheme: AppTheme.darkThemeData,
          themeMode: ThemeMode.light,
          home: SplashScreen(),
          initialRoute: SplashScreen.name,
          onGenerateRoute: onGenerateRoute,
          initialBinding: ControllerBinding(),
        );
      },
    );
  }
}