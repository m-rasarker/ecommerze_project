import 'package:ecommerce_project/features/carts/presentation/controllers/cart_list_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../app/app_colors.dart';
import '../../../../app/asset_paths.dart';
import '../../../../app/constants.dart';
import '../../shared/presentation/widgets/inc_dec_button.dart';
import '../presentation/data/models/wish_item_model.dart';


class CartItem extends StatelessWidget {
  const CartItem({super.key, required this.wishItemModel});

  final WishItemModel wishItemModel;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 4,
      margin: EdgeInsets.symmetric(horizontal: 16),
      shadowColor: AppColors.themeColor.withOpacity(0.3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.all(4),
            decoration: BoxDecoration(),
            child: Image.network(
              wishItemModel.product.photos.isEmpty
                  ? ''
                  : wishItemModel.product.photos.first,
              height: 80,
              width: 80,
              errorBuilder: (_, __, ___) => Container(
                height: 80,
                width: 80,
                alignment: Alignment.center,
                child: Icon(Icons.error_outline),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              wishItemModel.product.title,
                              style: TextTheme.of(context).titleSmall,
                            ),
                            Text(
                              'Size: ${wishItemModel.size ?? 'Nil'}  Color: ${wishItemModel.color ?? 'Nil'}',
                              style: TextTheme.of(context).bodySmall,
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          Get.find<CartListController>().deleteCartbyItemId(wishItemModel.id);
                          Get.find<CartListController>().getCartList();

                        },
                        icon: Icon(Icons.delete_forever_outlined),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '$takaSign${wishItemModel.product.currentPrice}',
                        style: TextTheme.of(
                          context,
                        ).titleSmall?.copyWith(color: AppColors.themeColor),
                      ),
                      IncDecButton(onChange: (int value) {
                        Get.find<CartListController>().updateCart(wishItemModel.id, value);
                      }),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }




}