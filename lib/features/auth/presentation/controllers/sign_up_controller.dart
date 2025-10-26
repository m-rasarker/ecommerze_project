import 'package:ecommerce_project/app/urls.dart';
import 'package:ecommerce_project/core/models/network_response.dart';
import 'package:ecommerce_project/core/services/network_caller.dart';
import 'package:ecommerce_project/features/auth/data/models/sign_up_request_model.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  bool _signUpInProgress = false;

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  bool get signUpInProgress => _signUpInProgress;

  Future<bool> signUp(SignUpRequestModel model) async {
    bool isSuccess = false;
    _signUpInProgress = true;
    update();
    final NetworkResponse response = await Get.find<NetworkCaller>()
        .postRequest(url: Urls.signUpUrl, body: model.toJson());

    if (response.isSuccess) {
      _errorMessage = null;
      isSuccess = true;
    } else {
      _errorMessage = response.body?['msg'] ?? response.errorMessage;
    }
    _signUpInProgress = false;
    update();

    return isSuccess;
  }
}