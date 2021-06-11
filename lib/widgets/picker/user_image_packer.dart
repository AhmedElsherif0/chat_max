import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  final void Function(File imagePicker) imagePickerFunction;

  const UserImagePicker(this.imagePickerFunction);

  @override
  _State createState() => _State();
}

class _State extends State<UserImagePicker> {
  File? _imageFile;

 Future<void> _getImage() async {
    final pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      imageQuality: 80,
      maxWidth: 150,
      maxHeight: 150);

    if (pickedFile == null) {
      return;
    }
    setState(() {
      _imageFile = File(pickedFile.path);
    });
    widget.imagePickerFunction(File(pickedFile.path));
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundImage: _imageFile != null ? FileImage(_imageFile!) : null,
        ),
        TextButton.icon(
          style: ElevatedButton.styleFrom(
              textStyle: TextStyle(color: primaryColor)),
          onPressed: _getImage,
          icon: const Icon(Icons.image),
          label: const Text('Add Image'),
        )
      ],
    );
  }
}
