import 'dart:io';

import 'package:flutter/material.dart';
import 'package:nativefeatues/provider/great_places.dart';
import 'package:nativefeatues/widgets/image_input_widget.dart';
import 'package:nativefeatues/widgets/location_input.dart';
import 'package:provider/provider.dart';

class AddPlaceScreen extends StatefulWidget {
  static const routeName = '/add-place';
  const AddPlaceScreen({Key? key}) : super(key: key);

  @override
  _AddPlaceScreenState createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  File? _pickedImage;
  String? placeName;
  final _formKey = GlobalKey<FormState>();
  _selectedImage(File pickedImage) {
    this._pickedImage = pickedImage;
  }

  _savePlace() {
    if (!this._formKey.currentState!.validate()) {
      return;
    }
    this._formKey.currentState!.save();
    Provider.of<GreatPlaces>(context).addPlace(placeName!, _pickedImage!);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add a new place'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              decoration: InputDecoration(hintText: 'Title'),
                              onSaved: (value) {
                                this.placeName = value;
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Name is required";
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            ImageInputWidget(successCallback: _selectedImage),
                            SizedBox(
                              height: 10,
                            ),
                            LocationInputWidget()
                          ],
                        ))
                  ],
                ),
              ),
            ),
          ),
          RaisedButton.icon(
            onPressed: _savePlace,
            icon: Icon(Icons.add),
            label: Text('Add Place'),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
        ],
      ),
    );
  }
}
