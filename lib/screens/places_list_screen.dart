import 'package:flutter/material.dart';
import 'package:nativefeatues/provider/great_places.dart';
import 'package:nativefeatues/screens/add_place_screen.dart';
import 'package:provider/provider.dart';

class PlacesListScreen extends StatelessWidget {
  const PlacesListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Places'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
            },
            icon: Icon(Icons.add),
          )
        ],
      ),
      body: Consumer<GreatPlaces>(
        child: Text('Got no places yet! Add some'),
        builder: (ctx, values, child) => ListView.builder(
          itemBuilder: (ctx, index) => ListTile(
            leading: CircleAvatar(
              backgroundImage: FileImage(values.items[index].image),
            ),
            title: Text(values.items[index].title),
          ),
        ),
      ),
    );
  }
}