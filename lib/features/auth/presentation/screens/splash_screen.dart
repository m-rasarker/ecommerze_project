import 'package:ecommerce_project/app/extensions/localization_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../app/controllers/auth_controller.dart';
import '../../../../app/utils/app_version_service.dart';
import '../../../shared/presentation/screens/bottom_nav_holder_screen.dart';
import '../widgets/app_logo.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static const String name = '/';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _moveToNextScreen();
  }

  Future<void> _moveToNextScreen() async {
    await Future.delayed(Duration(seconds: 2));
    bool isUserLoggedIn = await Get.find<AuthController>().isUserAlreadyLoggedIn();
    if (isUserLoggedIn) {
      await Get.find<AuthController>().loadUserData();
    }
    Navigator.pushReplacementNamed(context, BottomNavHolderScreen.name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Spacer(),
              AppLogo(),
              Spacer(),
              CircularProgressIndicator(),
              const SizedBox(height: 12),
              Text(
                '${context.localization.version} '
                    '${AppVersionService.currentAppVersion}',
              ),
            ],
          ),
        ),
      ),
    );
  }
}