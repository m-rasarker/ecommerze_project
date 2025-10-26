import 'package:ecommerce_project/app/urls.dart';
import 'package:ecommerce_project/core/models/network_response.dart';
import 'package:ecommerce_project/core/services/network_caller.dart';
import 'package:ecommerce_project/features/carts/data/models/cart_item_model.dart';
import 'package:get/get.dart';

class CartListController extends GetxController {
  bool _inProgress = false;

  List<CartItemModel> _cartItemList = [];

  bool get inProgress => _inProgress;

  List<CartItemModel> get cartItemList => _cartItemList;

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  Future<bool> getCartList() async {
    bool isSuccess = false;
    _inProgress = true;
    update();

    final NetworkResponse response = await Get.find<NetworkCaller>().getRequest(
      url: Urls.cartListUrl,
    );
    if (response.isSuccess) {
      List<CartItemModel> list = [];
      for (Map<String, dynamic> jsonData in response.body!['data']['results']) {
        list.add(CartItemModel.fromJson(jsonData));
      }
      _cartItemList = list;
      _errorMessage = null;
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }

    _inProgress = false;
    update();

    return isSuccess;
  }





  Future<bool> deleteCartbyItemId(String cartItemId,) async {
    bool isSuccess = false;
    _inProgress = true;
    update();

    // Map<String, String>  body = {
    //   "product": cartItemId
    //
    // };

    final NetworkResponse response = await Get.find<NetworkCaller>().deleteRequest(
      url: Urls.deletecartListUrl(cartItemId),body: {'product': cartItemId}
    );
    if (response.isSuccess) {
      deleteCart(cartItemId);
      update();
      _errorMessage = null;
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }


    _inProgress = false;
    update();

    return isSuccess;
  }





  int get totalPrice {
    int total = 0;
    for (CartItemModel item in _cartItemList) {
      total += (item.quantity * item.product.currentPrice);
    }

    return total;
  }

  void updateCart(String cartItemId, int quantity) {
    _cartItemList.firstWhere((item) => item.id == cartItemId)
        .quantity = quantity;
    update();
  }



  void deleteCart(String cartItemId) {
    _cartItemList.removeWhere((item) => item.id == cartItemId);
    update();
  }


}