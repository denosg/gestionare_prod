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

  Future<void> addListing(Listing listing) async {
    // TODO: implement adding to firebase database
  }

  Future<void> deleteListing(String id) async {
    // TODO: implement deleting from firebase database
  }

  Future<void> updateListing(String id, Listing newListing) async {
    // TODO: target the quest that we want to update + http.patch for the update in the firebase database
  }
}
