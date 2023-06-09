import 'package:flutter/material.dart';

import '../models/item.dart';

class ItemListProvider with ChangeNotifier {
  // list of the items in the listing
  List<Item> _itemsList = [];

  List<Item> get itemsList {
    return [..._itemsList];
  }

// this method handles the inserting an Item in the listing to save + display the item there
  void addItemInList(Item currentItem) {
    _itemsList.insert(0, currentItem);
    notifyListeners();
  }
}
