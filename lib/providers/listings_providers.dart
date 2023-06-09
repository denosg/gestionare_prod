import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:gestionare_prod/models/listing.dart';

class ListingProviders with ChangeNotifier {
  List<Listing> _listings = [];

  List<Listing> get listings {
    return [..._listings];
  }

  Listing findById(String id) {
    return _listings.firstWhere((listing) => listing.id == id);
  }

  Future<void> fetchListings() async {
    // TODO: implement fetching from firebase database
  }

  // this will be used in the add listing screen where we will get the specifi listing
  Future<void> addListing(Listing listing) async {
    // Send json data to server database
    Uri url = Uri.parse(
        'https://gestionare-produse-default-rtdb.europe-west1.firebasedatabase.app/listings.json');
    final timeStamp = DateTime.now();
    try {
      //This registers as a 'TODO' function (loads at the end, async task)
      //Waits for this operation to finish before going to the next lines of code
      final response = await http.post(
        url,
        body: json.encode({
          'id': listing.id,
          'title': listing.title,
          'dateTime': timeStamp.toIso8601String(),
          'amount': listing.amount,
          'items': listing.itemList
              .map((item) => {
                    'title': item.title,
                    'photoUrl': item.photoUrl,
                    'pricePaid': item.pricePaid,
                    'priceMarket': item.priceMarket,
                    'amountOfItem': item.amountOfItem,
                  })
              .toList(),
        }),
      );
      // adds the order locally in the memory
      _listings.insert(
          0,
          Listing(
            id: json.decode(response.body)['name'],
            title: listing.title,
            dateTime: timeStamp,
            amount: listing.amount,
            itemList: listing.itemList,
          ));
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteListing(String id) async {
    // TODO: implement deleting from firebase database
  }

  Future<void> updateListing(String id, Listing newListing) async {
    // TODO: target the quest that we want to update + http.patch for the update in the firebase database
  }
}
