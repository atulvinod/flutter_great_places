import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:nativefeatues/helpers/db_helper.dart';
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
    DBHelper.insert(
        'places', {'id': newPlace.id, 'title': title, 'image': image.path});
  }

  Future<void> fetchAndSetPlaces() async {
    final dataList = await DBHelper.getData('places');
    _items = dataList
        .map((e) => Place(
            id: e['id'],
            title: e['title'],
            image: File(
              e['image'],
            )))
        .toList();

    notifyListeners();
  }
}
