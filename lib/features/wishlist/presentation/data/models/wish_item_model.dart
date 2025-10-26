import 'package:ecommerce_project/features/shared/data/models/product_model.dart';

class WishItemModel {
  final String id;
  final ProductModel product;

  String? color;
  String? size;

  WishItemModel({
    required this.id,
    required this.product,
    required this.color,
    required this.size,
  });

  factory WishItemModel.fromJson(Map<String, dynamic> jsonData) {
    return WishItemModel(
      id: jsonData['_id'],
      product: ProductModel.fromJson(jsonData['product']),
      color: jsonData['color'],
      size: jsonData['size'],
    );
  }
}

