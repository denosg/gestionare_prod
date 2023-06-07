import 'package:flutter/material.dart';

import '../../models/item.dart';

class AmountItemForm extends StatefulWidget {
  final Item tempItem;
  final Function(Item) onSave;

  const AmountItemForm({required this.tempItem, required this.onSave});

  @override
  State<AmountItemForm> createState() => _AmountItemFormState();
}

class _AmountItemFormState extends State<AmountItemForm> {
  int _amount = 0;

  void _decrement() {
    if (_amount > 0) {
      setState(() {
        _amount--;
      });
    }
  }

  void _increment() {
    setState(() {
      _amount++;
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: const Icon(Icons.remove),
          onPressed: _decrement,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Container(
            width: width * 0.2,
            height: height * 0.07,
            padding: EdgeInsets.all(width * 0.03),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: Colors.grey[300]),
            child: TextFormField(
              textAlign: TextAlign.center,
              decoration: InputDecoration.collapsed(
                hintText: '$_amount',
                hintStyle: const TextStyle(color: Colors.black54),
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  _amount = int.tryParse(value) ?? 0;
                });
              },
              onSaved: (enteredString) {
                if (enteredString != null) {
                  Item updatedItem = Item(
                    title: widget.tempItem.title,
                    photoUrl: widget.tempItem.photoUrl,
                    pricePaid: widget.tempItem.pricePaid,
                    priceMarket: widget.tempItem.priceMarket,
                    amountOfItem: int.parse(enteredString),
                  );

                  widget.onSave(updatedItem);
                }
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a value';
                }
                final number = int.tryParse(value);
                if (number == null || number < 0) {
                  return 'Invalid number';
                }
                return null;
              },
            ),
          ),
        ),
        const SizedBox(width: 8),
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: _increment,
        ),
      ],
    );
  }
}
