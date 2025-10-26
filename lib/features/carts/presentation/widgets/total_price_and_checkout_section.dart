import 'package:ecommerce_project/features/carts/presentation/controllers/cart_list_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sslcommerz/model/SSLCSdkType.dart';
import 'package:flutter_sslcommerz/model/SSLCommerzInitialization.dart';
import 'package:flutter_sslcommerz/model/SSLCurrencyType.dart';
import 'package:flutter_sslcommerz/sslcommerz.dart';
import 'package:get/get.dart';

import '../../../../app/app_colors.dart';
import '../../../../app/constants.dart';

class TotalPriceAndCheckoutSection extends StatelessWidget {
  const TotalPriceAndCheckoutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;


    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.themeColor.withOpacity(0.1),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Total Price',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
              GetBuilder<CartListController>(
                  builder: (controller) {
                    return Text(
                      '$takaSign${controller.totalPrice}',
                      style: textTheme.titleMedium?.copyWith(
                        color: AppColors.themeColor,
                      ),

                    );
                  }
              ),
            ],
          ),
          SizedBox(
            width: 120,
            child: FilledButton(onPressed: () {
              _startSSLCommerzTransaction();

            }, child: Text('Checkout')),
          ),
        ],
      ),
    );
  }


  
  Future<void> _startSSLCommerzTransaction() async {

    Sslcommerz sslcommerz = Sslcommerz(
      initializer: SSLCommerzInitialization(
        ipn_url: "www.charteredlifebd.com",
        multi_card_name: "visa,master,bkash",
        currency: SSLCurrencyType.BDT,
        product_category: "Preimum",
        sdkType: SSLCSdkType.TESTBOX,

        store_id: "chart68f1923f89dad",
        store_passwd: "chart68f1923f89dad@ssl",
        total_amount: Get.find<CartListController>().totalPrice.toDouble(),
        tran_id: "1231123131212",
      ),
    );



    final resonse = await sslcommerz.payNow();

    if (resonse.status=='VALID')
    {
      double tramount= resonse.storeAmount as double;

    }
    if (resonse.status=='closed')
    {

    }

    if (resonse.status=='FAILED')
    {

    }

  }

}