import 'package:ecommerce_project/app/urls.dart';
import 'package:ecommerce_project/core/models/network_response.dart';
import 'package:ecommerce_project/core/services/network_caller.dart';

import 'package:get/get.dart';

import '../../../shared/data/models/product_details_mode.dart';

class ProductDetailsController extends GetxController {
  bool _getProductDetailsInProgress = false;

  ProductDetailsModel? _productDetailsModel;

  String? _errorMessage;

  bool get getProductDetailsInProgress => _getProductDetailsInProgress;

  ProductDetailsModel? get productDetails => _productDetailsModel;

  String? get errorMessage => _errorMessage;

  Future<bool> getProductDetails(String productId) async {
    bool isSuccess = false;
    _getProductDetailsInProgress = true;
    update();
    final NetworkResponse response = await Get.find<NetworkCaller>().getRequest(
      url: Urls.productDetailsUrl(productId),
    );
    if (response.isSuccess) {
      _productDetailsModel = ProductDetailsModel.fromJson(
        response.body!['data'],
      );
      isSuccess = true;
      _errorMessage = null;
    } else {
      _errorMessage = response.errorMessage;
    }

    _getProductDetailsInProgress = false;
    update();

    return isSuccess;
  }
}