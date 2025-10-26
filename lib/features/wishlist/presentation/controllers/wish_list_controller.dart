import 'package:ecommerce_project/app/urls.dart';
import 'package:ecommerce_project/core/models/network_response.dart';
import 'package:ecommerce_project/core/services/network_caller.dart';
import 'package:ecommerce_project/features/wishlist/presentation/data/models/wish_item_model.dart';

import 'package:get/get.dart';

import '../../../carts/data/models/cart_item_model.dart';

class WishListController extends GetxController {
  bool _addToWishInProgress = false;

  String? _errorMessage;

  bool get addToWishessinProgress => _addToWishInProgress;

  String? get errorMessage => _errorMessage;
  List<WishItemModel> _wishItemList = [];



  List<WishItemModel> get wishItemList => _wishItemList;

  Future<bool> addToWishList(String productId) async {
    bool isSuccess = false;
    _addToWishInProgress = true;
    update();
    final NetworkResponse response = await Get.find<NetworkCaller>()
        .postRequest(url: Urls.addWishListUrl, body: {'product': productId});
    if (response.isSuccess) {
      isSuccess = true;
      _errorMessage = null;
    } else {
      _errorMessage = response.errorMessage;
    }
    _addToWishInProgress = false;
    update();

    return isSuccess;
  }



  Future<bool> getWishList() async {
    bool isSuccess = false;
    _addToWishInProgress = true;
    update();
    final NetworkResponse response = await Get.find<NetworkCaller>()
        .getRequest(url: Urls.GetWishListUrl);
    if (response.isSuccess) {
      List<WishItemModel> list = [];
      for (Map<String, dynamic> jsonData in response.body!['data']['results']) {
        list.add(WishItemModel.fromJson(jsonData));
      }
      _wishItemList = list;
      _errorMessage = null;
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }
    _addToWishInProgress = false;
    update();

    return isSuccess;
  }
}
