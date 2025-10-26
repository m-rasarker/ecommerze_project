
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductReviewScreen extends StatefulWidget {
  const ProductReviewScreen({super.key});

  static const String name = '/product-review-list';

  @override
  State<ProductReviewScreen> createState() => _ProductReviewScreenState();
}

class _ProductReviewScreenState extends State<ProductReviewScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text('Review List')
      ),



      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              spacing: 16,
              children: [




                TextFormField(
                 // controller: _emailTEController,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(hintText: 'First Name'),
                ),

                TextFormField(
                  // controller: _emailTEController,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(hintText: 'Last Name'),
                ),

                TextFormField(
                  // controller: _emailTEController,
                  textInputAction: TextInputAction.next,
                  maxLines: 5,
                  decoration: InputDecoration(hintText: 'Write Review'
                ),


                // GetBuilder<LoginController>(
                //     builder: (_) {
                //       return Visibility(
                //         visible: _loginController.logInProgress == false,
                //         replacement: CenteredCircularProgress(),
                //         child: FilledButton(
                //           onPressed: _onTapLoginButton,
                //           child: Text('Login'),
                //         ),
                //       );
                //     }
                ),


              ],
            ),
          ),
        ),
      ),
    );
  }
}
