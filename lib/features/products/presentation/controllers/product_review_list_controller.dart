import 'package:ecommerce_project/features/shared/data/models/product_model.dart';
import 'package:get/get.dart';

import '../../../../app/urls.dart';
import '../../../../core/models/network_response.dart';
import '../../../../core/services/network_caller.dart';

class ProductRevierListController extends GetxController {
  int _currentPage = 0;

  int? _lastPageNo;

  final int _pageSize = 40;

  bool _getProductReviewListInProgress = false;

  bool _isInitialLoading = false;

  final List<ProductModel> _productList = [];

  String? _errorMessage;

  bool get getProductsReviewInProgress => _getProductReviewListInProgress;

  bool get isInitialLoading => _isInitialLoading;

  List<ProductModel> get productList => _productList;

  String? get errorMessage => _errorMessage;

  Future<bool> getProductReviewList(String productid) async {
    bool isSuccess = false;

    if (_currentPage > (_lastPageNo ?? 1)) {
      return false;
    }
    if (_currentPage == 0) {
      _productList.clear();
      _isInitialLoading = true;
    } else {
      _getProductReviewListInProgress = true;
    }
    update();

    _currentPage++;

    final NetworkResponse response = await Get.find<NetworkCaller>().getRequest(
        url: Urls.productReviewList(productid));
    if (response.isSuccess) {

      List<ProductModel> list = [];
      for (Map<String, dynamic> jsonData in response.body!['data']['results']) {
        list.add(ProductModel.fromJson(jsonData));
      }
      _productList.addAll(list);
      isSuccess = true;
      _errorMessage = null;
    } else {
      _errorMessage = response.errorMessage;
    }

    if (_isInitialLoading) {
      _isInitialLoading = false;
    } else {
      _getProductReviewListInProgress = false;
    }

    update();
    return isSuccess;
  }


}