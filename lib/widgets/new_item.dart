import 'package:flutter/material.dart';
import 'package:gestionare_prod/models/item.dart';
import 'package:gestionare_prod/widgets/textForms/amount_item_form.dart';
import 'package:gestionare_prod/widgets/textForms/image_url_form.dart';
import 'package:gestionare_prod/widgets/textForms/price_market_form.dart';
import 'package:gestionare_prod/widgets/textForms/price_paid_form.dart';
import 'package:gestionare_prod/widgets/textForms/title_form.dart';

class NewItem extends StatefulWidget {
  const NewItem({super.key});

  @override
  State<NewItem> createState() => _NewItemState();
}

class _NewItemState extends State<NewItem> {
  final _modalFormKey = GlobalKey<FormState>();
  final TextEditingController? _imageUrlController = TextEditingController();

  var _tempItem = Item(
      title: '', photoUrl: '', pricePaid: 0, priceMarket: 0, amountOfItem: 0);

  void saveStateOfTextField(Item updatedItem) {
    setState(() {
      _tempItem =
          updatedItem; // Update _tempItem with the updatedItem from MyTextForm
    });
    print("data of item: $_tempItem");
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Container(
      padding: EdgeInsets.only(
          top: 10,
          left: 10,
          right: 10,
          bottom: MediaQuery.of(context).viewInsets.bottom + 10),
      child: Form(
        key: _modalFormKey,
        child: ListView(
          children: [
            // title of particular item
            TitleForm(tempItem: _tempItem, onSave: saveStateOfTextField),
            // image on the left + image url on the right
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 100,
                  height: 100,
                  margin: const EdgeInsets.only(top: 8, right: 10),
                  child: _imageUrlController == null
                      ? const Text('Enter a Url')
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          // child: Image.network(_imageUrlController!.text),
                        ),
                ),
                Expanded(
                  child: ImageUrlForm(
                      tempItem: _tempItem, onSave: saveStateOfTextField),
                ),
              ],
            ),
            // price paid for the item / price that we will put the item for
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // price paid for the item
                PricePaidForm(
                    tempItem: _tempItem, onSave: saveStateOfTextField),
                // price that we will put the item for on the market
                PriceMarketForm(
                    tempItem: _tempItem, onSave: saveStateOfTextField),
              ],
            ),
            // amount of the item
            const SizedBox(height: 20),
            AmountItemForm(tempItem: _tempItem, onSave: saveStateOfTextField),
            // Save button
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
