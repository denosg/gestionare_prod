import 'package:flutter/material.dart';
import 'package:gestionare_prod/widgets/product_item.dart';

class ProductsList extends StatelessWidget {
  const ProductsList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) => ProductItem(),
      itemCount: 1,
    );
  }
}
