import 'package:flutter/material.dart';
import 'package:nativefeatues/provider/great_places.dart';
import 'package:nativefeatues/screens/add_place_screen.dart';
import 'package:nativefeatues/screens/places_detail_screen.dart';
import 'package:nativefeatues/screens/places_list_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => GreatPlaces(),
      child: MaterialApp(
        title: 'Great Places',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          accentColor: Colors.amber,
        ),
        home: PlacesListScreen(),
        routes: {
          AddPlaceScreen.routeName: (_) => AddPlaceScreen(),
          PlaceDetailScreen.routeName: (_) => PlaceDetailScreen()
        },
      ),
    );
  }
}
