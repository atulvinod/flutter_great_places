import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:nativefeatues/models/place.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  void addPlace(String title, File image) {
    final newPlace = Place(
      title: title,
      id: DateTime.now().toIso8601String(),
      image: image,
    );
    _items.add(newPlace);
    notifyListeners();
  }
}
