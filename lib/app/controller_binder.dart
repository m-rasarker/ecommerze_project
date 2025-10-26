import 'package:ecommerce_project/app/set_up_network_client.dart';
import 'package:ecommerce_project/features/shared/presentation/controllers/main_nav_controller.dart';
import 'package:get/get.dart';

import '../features/auth/presentation/controllers/login_controller.dart';
import '../features/auth/presentation/controllers/sign_up_controller.dart';
import '../features/auth/presentation/controllers/verify_otp_controller.dart';
import '../features/carts/presentation/controllers/cart_list_controller.dart';
import '../features/home/presentation/controllers/home_slider_controller.dart';
import '../features/wishlist/presentation/controllers/wish_list_controller.dart';
import '../features/shared/presentation/controllers/category_controller.dart';
import 'controllers/auth_controller.dart';

class ControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthController());
    Get.put(MainNavController());
    Get.put(setUpNetworkClient());
    Get.put(SignUpController());
    Get.put(VerifyOtpController());
    Get.put(LoginController());
    Get.put(HomeSliderController());
    Get.put(CategoryController());
    Get.put(CartListController());
    Get.put(WishListController());



  }
}