import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  final String title;
  final DateTime dateTime;
  final double amount;

  const ProductItem(
      {required this.title, required this.dateTime, required this.amount});

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(10),
      child: SizedBox(
        width: double.infinity,
        height: deviceSize.height / 7,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 10,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                      'https://ae01.alicdn.com/kf/H3c5b317b00d042e296c30dfaddc55c25o/2020-New-Arrival-1-Piece-High-Quality-ABS-Retractable-Nurse-Badge-Holder-Reel-Reel-Elegant-Hospital.jpg_50x50.jpg_.webp'),
                ),
                title: Text(title),
                subtitle: Text(dateTime.toIso8601String()),
                trailing: Text(amount.toString()),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
