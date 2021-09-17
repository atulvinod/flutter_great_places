import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class ImageInputWidget extends StatefulWidget {
  final Function(File image)? successCallback;
  const ImageInputWidget({this.successCallback, Key? key}) : super(key: key);

  @override
  _ImageInputWidgetState createState() => _ImageInputWidgetState();
}

class _ImageInputWidgetState extends State<ImageInputWidget> {
  File? _storedImage;
  _takePicture() async {
    final picker = ImagePicker();
    final imageFile =
        await picker.getImage(source: ImageSource.camera, maxWidth: 600);
    if (imageFile.path.isEmpty) {
      return;
    }
    setState(() {
      _storedImage = File(imageFile.path);
    });
    // TO get the appDirectory
    // we get the application directory using path provider
    final appDir = await getApplicationDocumentsDirectory();

    // TO  get the image file name, we use the path package
    final fileName = basename(imageFile.path);

    // By default our image is stored in temp directory, to save to the device
    await _storedImage?.copy('${appDir}/$fileName');
    if (widget.successCallback != null) {
      widget.successCallback!(_storedImage!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 100,
          height: 100,
          decoration:
              BoxDecoration(border: Border.all(width: 1, color: Colors.grey)),
          child: _storedImage != null
              ? Image.file(
                  _storedImage!,
                  fit: BoxFit.cover,
                )
              : Text(
                  'No Image Taken',
                  textAlign: TextAlign.center,
                ),
          alignment: Alignment.center,
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: FlatButton.icon(
            onPressed: _takePicture,
            icon: Icon(Icons.add),
            label: Text('Take Picture'),
          ),
        ),
      ],
    );
  }
}
