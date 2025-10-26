
import 'package:ecommerce_project/features/products/presentation/controllers/add_to_review_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../../../shared/presentation/widgets/centered_circular_progress.dart';

class ProductReviewScreen extends StatefulWidget {
  const ProductReviewScreen({super.key});

  static const String name = '/product-review';

  @override
  State<ProductReviewScreen> createState() => _ProductReviewScreenState();
}

class _ProductReviewScreenState extends State<ProductReviewScreen> {
  AddToReviewController _addToReviewController = AddToReviewController();
  TextEditingController fnameTEController = TextEditingController();
  TextEditingController lnameTEController = TextEditingController();
  TextEditingController commentsTEController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text('Add Review')

      ),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              spacing: 16,
              children: [
              TextFormField(
               controller: fnameTEController,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(hintText: 'First Name'),
            ),

            TextFormField(
               controller: lnameTEController,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(hintText: 'Last Name'),
            ),

            TextFormField(
               controller: commentsTEController,
              textInputAction: TextInputAction.next,
              maxLines: 5,
              decoration: InputDecoration(hintText: 'Write Review'
              )),
                // GetBuilder<AddToReviewController>(
                //     builder: (_) {
                //       return Visibility(
                //         visible: _addToReviewController.addToReviewInProgress == false,
                //         replacement: CenteredCircularProgress(),
                //         child: FilledButton(
                //           onPressed: (){},
                //           child: Text('Submit'),
                //         ),
                //       );
                //     }
                // ),
            FilledButton(
                        onPressed: (){},
                        child: Text('Submit'))

              ],







            ),
          ),
        ),
      ),
    );
  }
}
