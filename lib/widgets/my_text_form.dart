import 'package:flutter/material.dart';
import 'package:gestionare_prod/models/item.dart';

class MyTextForm extends StatefulWidget {
  final String hintText;
  final Item tempItem;
  final Function(Item) onSave;
  final bool isTitle;
  final bool isPhotoUrl;
  final TextInputType textInputType;

  const MyTextForm({
    required this.hintText,
    required this.tempItem,
    required this.onSave,
    required this.isTitle,
    required this.isPhotoUrl,
    required this.textInputType,
  });

  @override
  State<MyTextForm> createState() => _MyTextFormState();
}

//TODO: add logic for getting the info regarding the type of text field that is being used and use that logic here

class _MyTextFormState extends State<MyTextForm> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Container(
      width: width * 0.8,
      height: height * 0.07,
      padding: EdgeInsets.all(width * 0.03),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6), color: Colors.grey[300]),
      child: Center(
        child: Row(
          children: <Widget>[
            const Icon(
              Icons.title,
              color: Colors.black54,
            ),
            SizedBox(
              width: width * 0.04,
            ),
            Expanded(
              child: TextFormField(
                autocorrect: false,
                decoration: InputDecoration.collapsed(
                  hintText: widget.hintText,
                  hintStyle: const TextStyle(color: Colors.black54),
                ),
                textInputAction: TextInputAction.next,
                autofocus: true,
                keyboardType: widget.textInputType,
                // gets the introduced string
                onSaved: (enteredString) {
                  if (enteredString != null) {
                    Item? updatedItem;
                    if (widget.isTitle) {
                      updatedItem = Item(
                        title: enteredString,
                        photoUrl: widget.tempItem.photoUrl,
                        pricePaid: widget.tempItem.pricePaid,
                        priceMarket: widget.tempItem.priceMarket,
                        amountOfItem: widget.tempItem.amountOfItem,
                      );
                    }
                    if (widget.isPhotoUrl) {
                      updatedItem = Item(
                        title: widget.tempItem.title,
                        photoUrl: enteredString,
                        pricePaid: widget.tempItem.pricePaid,
                        priceMarket: widget.tempItem.priceMarket,
                        amountOfItem: widget.tempItem.amountOfItem,
                      );
                    }
                    widget.onSave(updatedItem!);
                  }
                },
                validator: (value) {
                  if (value == '') {
                    return 'Please provide a value';
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
