import 'package:flutter/material.dart';
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
}
