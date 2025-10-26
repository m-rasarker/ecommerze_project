import 'package:ecommerce_project/app/app.dart';
import 'package:ecommerce_project/app/controllers/auth_controller.dart';
import 'package:ecommerce_project/core/services/network_caller.dart';
import 'package:ecommerce_project/features/auth/presentation/screens/sign_in_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

NetworkCaller setUpNetworkClient() {
  return NetworkCaller(
    onUnAuthorize: _onUnAuthorize,
    accessToken: () {
      return Get.find<AuthController>().accessToken ?? '';
    },
  );
}

Future<void> _onUnAuthorize() async {
  // TODO: remove cache
  Navigator.pushNamedAndRemoveUntil(
    CraftyBay.navigatorKey.currentContext!,
    SignInScreen.name,
        (predicate) => false,
  );
}