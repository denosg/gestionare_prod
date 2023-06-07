import 'package:flutter/material.dart';
import 'package:gestionare_prod/models/item.dart';
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
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  width: 100,
                  height: 100,
                  margin: const EdgeInsets.only(top: 8, right: 10),
                  child: _imageUrlController == null
                      ? const Text('Enter a Url')
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(_imageUrlController!.text),
                        ),
                ),
                Expanded(
                  child: TextFormField(
                    decoration: const InputDecoration(label: Text('Image Url')),
                    keyboardType: TextInputType.url,
                    textInputAction: TextInputAction.done,
                    controller: _imageUrlController,
                    // _saveForm for individual item that will be added in the Listing class
                    onSaved: (imageUrl) {
                      if (imageUrl != null) {
                        _tempItem = Item(
                          title: _tempItem.title,
                          photoUrl: imageUrl,
                          pricePaid: _tempItem.pricePaid,
                          priceMarket: _tempItem.priceMarket,
                          amountOfItem: _tempItem.amountOfItem,
                        );
                      }
                    },
                    validator: (value) {
                      if (value != null) {
                        if (!value.startsWith('http') &&
                            !value.startsWith('https')) {
                          return 'Please enter a valid URL';
                        }
                      }
                      if (value != null) {
                        if (!value.endsWith('.png') &&
                            !value.endsWith('.jpg') &&
                            !value.endsWith('.jpeg')) {
                          return 'Please enter a valid image URL';
                        }
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
            // price paid for the item / price that we will put the item for
            Container(
              width: double.infinity,
              height: 70,
              // color: Colors.red,
              child: Row(
                children: [
                  // price paid for the item
                  Expanded(
                    child: TextFormField(
                      autocorrect: false,
                      decoration: const InputDecoration(
                        labelText: 'Price Paid',
                      ),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      onSaved: (pricePaidStr) {
                        if (pricePaidStr != null) {
                          final pricePaid = double.parse(pricePaidStr);
                          _tempItem = Item(
                              title: _tempItem.title,
                              photoUrl: _tempItem.photoUrl,
                              pricePaid: pricePaid,
                              priceMarket: _tempItem.priceMarket,
                              amountOfItem: _tempItem.amountOfItem);
                        }
                      },
                      validator: (value) {
                        if (value == '') {
                          return 'Please enter the monehy';
                        }
                        if (value != null) {
                          if (int.tryParse(value) == null) {
                            return 'Please enter a valid number';
                          }
                        }
                        if (value != null) {
                          if (int.parse(value) <= 0) {
                            return 'Please enter a number > 0';
                          }
                        }
                        return null;
                      },
                    ),
                  ),
                  // price that we will put the item for on the market
                  Expanded(
                    child: TextFormField(
                      autocorrect: false,
                      decoration: const InputDecoration(
                        labelText: 'Price Market',
                      ),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      onSaved: (priceMarketStr) {
                        if (priceMarketStr != null) {
                          final priceMarket = double.parse(priceMarketStr);
                          _tempItem = Item(
                              title: _tempItem.title,
                              photoUrl: _tempItem.photoUrl,
                              pricePaid: _tempItem.pricePaid,
                              priceMarket: priceMarket,
                              amountOfItem: _tempItem.amountOfItem);
                        }
                      },
                      validator: (value) {
                        if (value == '') {
                          return 'Please enter the monehy';
                        }
                        if (value != null) {
                          if (int.tryParse(value) == null) {
                            return 'Please enter a valid number';
                          }
                        }
                        if (value != null) {
                          if (int.parse(value) <= 0) {
                            return 'Please enter a number > 0';
                          }
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
