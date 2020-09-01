import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ImageDownload extends StatelessWidget {
  static const String id = "download_home";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Firebase Download Demo'),
      ),
      body: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

File _imageFile;
bool _uploaded = false;
String _downlaodUrl;
StorageReference _reference =
    FirebaseStorage.instance.ref().child('myimage.jpg');

class _HomeState extends State<Home> {
  File image;

  Future getImage(bool isCamera) async {
    if (isCamera) {
      image = await ImagePicker.pickImage(source: ImageSource.camera);
    } else {
      image = await ImagePicker.pickImage(source: ImageSource.gallery);
    }
    setState(() {
      _imageFile = image;
    });
  }

  Future uploadImage() async {
    StorageUploadTask uploadTask = _reference.putFile(_imageFile);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    setState(() {
      _uploaded = true;
    });
  }

  Future downloadImage() async {
    String downloadAddress = await _reference.getDownloadURL();
    setState(() {
      _downlaodUrl = downloadAddress;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              RaisedButton(
                child: Text('Camera'),
                onPressed: () {
                  getImage(true);
                },
              ),
              SizedBox(
                height: 10,
              ),
              RaisedButton(
                  child: Text('Gallery'),
                  onPressed: () {
                    getImage(false);
                  }),
              _imageFile == null
                  ? Container()
                  : Image.file(_imageFile, height: 300, width: 300),
              _imageFile == null
                  ? Container()
                  : RaisedButton(
                      child: Text('Upload to storage'),
                      onPressed: () {
                        uploadImage();
                      }), 
              _uploaded == false?  Container()
                  : RaisedButton(
                      child: Text('Download Image'),
                      onPressed: () {
                        downloadImage();
                      }),
              _downlaodUrl == null ? Container()
                  : Image.network(_downlaodUrl),
              
            ],
          ),
        ),
      ),
    );
  }
}
