import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:nativefeatues/helpers/db_helper.dart';
import 'package:nativefeatues/helpers/location_helper.dart';
import 'package:nativefeatues/models/place.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  Future<void> addPlace(
      String title, File image, PlaceLocation placeLocation) async {
    final address = await LocationHelper.getPlaceAddress(
        placeLocation.lat, placeLocation.lng);
    final updatedLocation =
        PlaceLocation(placeLocation.lat, placeLocation.lng, address);
    final newPlace = Place(
        title: title,
        id: DateTime.now().toIso8601String(),
        image: image,
        location: updatedLocation);
    _items.add(newPlace);
    notifyListeners();
    DBHelper.insert('places', {
      'id': newPlace.id,
      'title': title,
      'image': image.path,
      'loc_lat': newPlace.location!.lat,
      'loc_lng': newPlace.location!.lng,
      'address': newPlace.location!.address!
    });
  }

  Future<void> fetchAndSetPlaces() async {
    final dataList = await DBHelper.getData('places');
    _items = dataList
        .map(
          (e) => Place(
            id: e['id'],
            title: e['title'],
            image: File(
              e['image'],
            ),
            location: PlaceLocation(
              e['loc_lat'],
              e['loc_lng'],
              e['address'],
            ),
          ),
        )
        .toList();

    notifyListeners();
  }

  Place getPlaceById(String id) {
    return _items.firstWhere((element) => element.id == id);
  }
}
