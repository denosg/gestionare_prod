import 'package:flutter/material.dart';
import 'package:gestionare_prod/models/item.dart';

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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Form(
        key: _modalFormKey,
        child: ListView(
          children: [
            // title of particular item
            TextFormField(
              autocorrect: false,
              decoration: InputDecoration(
                  labelText: 'Title',
                  labelStyle: TextStyle(color: Theme.of(context).accentColor)),
              textInputAction: TextInputAction.next,
              autofocus: true,
              // gets the introduced string
              onSaved: (title) {
                if (title != null) {
                  _tempItem = Item(
                    title: title,
                    photoUrl: _tempItem.photoUrl,
                    pricePaid: _tempItem.pricePaid,
                    priceMarket: _tempItem.priceMarket,
                    amountOfItem: _tempItem.amountOfItem,
                  );
                }
              },
              validator: (value) {
                if (value == '') {
                  return 'Please provide a value';
                }
                return null;
              },
            ),
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
