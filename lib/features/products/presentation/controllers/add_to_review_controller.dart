import 'package:ecommerce_project/app/urls.dart';
import 'package:ecommerce_project/core/models/network_response.dart';
import 'package:ecommerce_project/core/services/network_caller.dart';
import 'package:get/get.dart';

class AddToReviewController extends GetxController {
  bool _addToReviewinProgress = false;

  String? _errorMessage;

  bool get addToReviewInProgress => _addToReviewinProgress;

  String? get errorMessage => _errorMessage;

  Future<bool> addToReview(String productId, String comments) async {
    bool isSuccess = false;
    _addToReviewinProgress = true;
    update();
    final NetworkResponse response = await Get.find<NetworkCaller>()
        .postRequest(url: Urls.addToReviewUrl, body: {'product': productId,
      'comment': comments,
      'rating':'4'});
    if (response.isSuccess) {
      isSuccess = true;
      _errorMessage = null;
    } else {
      _errorMessage = response.errorMessage;
    }
    _addToReviewinProgress = false;
    update();

    return isSuccess;
  }
}