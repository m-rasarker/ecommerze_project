import 'package:ecommerce_project/features/wishlist/presentation/controllers/wish_list_controller.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';


import '../../../shared/presentation/widgets/centered_circular_progress.dart';
import '../../../shared/presentation/widgets/product_card.dart';
import '../../widgets/cart_item.dart';

class WishListScreen extends StatefulWidget {
  const WishListScreen({super.key});

  @override
  State<WishListScreen> createState() => _WishListScreenState();
}






class _WishListScreenState extends State<WishListScreen> {

  final WishListController _wishListController = Get.find<WishListController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _wishListController.getWishList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Wish List')),
      body: GetBuilder(
        init: _wishListController,
        builder: (controller) {
          if (controller.addToWishessinProgress) {
            return CenteredCircularProgress();
          } else if (controller.errorMessage != null) {
            return Center(child: Text(controller.errorMessage ?? ''));
          }

          return Column(
            children: [
              Expanded(
                child: GridView.builder(
                  itemCount: controller.wishItemList.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 0,
                  ),
                  itemBuilder: (context, index) {

                    return  FittedBox(
                      child: ProductCard(
                          productModel: controller.wishItemList[index].product),
                    );
                    
                    // return CartItem(
                    //   wishItemModel: controller.wishItemList[index],
                    
                  },

                ),
              ),
            //  TotalPriceAndCheckoutSection(),
            ],
          );
        },
      ),
    );
  }
}