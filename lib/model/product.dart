import 'package:flutter/foundation.dart';

enum Category { all, accessories, clothing, home }

class Product {
  final Category category;
  final String productName;
  final int id;
  final int price;
  final bool featured;

  const Product({
    @required this.category,
    @required this.featured,
    @required this.id,
    @required this.price,
    @required this.productName,
  })  : assert(category != null, 'Category must not be bull'),
        assert(featured != null, 'Featured must not be nulll'),
        assert(id != null, 'ID must not be bull'),
        assert(price != null, 'Price must not be nulll'),
        assert(productName != null, 'Product name must not be null');

  String get assetName=>'$id-0.jpg';
  String get assetPackage=>'shrine_images';

  @override
  String toString() => '$productName (id=$id)';
}
