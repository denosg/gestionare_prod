import 'package:flutter/material.dart';
import 'package:gestionare_prod/widgets/product_item.dart';

class ProductsList extends StatelessWidget {
  const ProductsList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return ProductItem(
          title: 'test',
          dateTime: DateTime.now(),
          amount: 100,
        );
      },
      itemCount: 1,
    );
  }
}
