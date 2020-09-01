import 'dart:io';
import 'package:functions_play_ground/helperClasses/uploader.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_cropper/image_cropper.dart';

class ImagePickerScreen extends StatelessWidget {
  static const String id = "image_capture";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Image Uploader"),
      ),
      
      body: ImageCapture(),
    );
  }
}

class ImageCapture extends StatefulWidget {
  @override
  _ImageCaptureState createState() => _ImageCaptureState();
}

class _ImageCaptureState extends State<ImageCapture> {
  File _imageFile;

  Future<void> _pickImage(ImageSource source) async {
    File selected = await ImagePicker.pickImage(source: source);
    setState(() {
      _imageFile = selected;
    });
  }

  Future<void> _cropImage() async {
    File cropped = await ImageCropper.cropImage(
      sourcePath: _imageFile.path,
    );
    setState(() {
      _imageFile = cropped ?? _imageFile;
    });
  }

  void _clear(){
    setState(() => _imageFile = null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      bottomNavigationBar: BottomAppBar(
        child: Row(
          children: <Widget>[
            
            IconButton(icon: Icon(Icons.photo_camera), onPressed: ()=> _pickImage(ImageSource.camera)),
            IconButton(icon: Icon(Icons.photo_library), onPressed: ()=> _pickImage(ImageSource.gallery)),
          ],
        ),
      ),
      body: ListView(

        children: <Widget>[
          ClipOval(
            child: SizedBox(width: 100, height: 100,
            child: (_imageFile != null)?Image.file(_imageFile, fit: BoxFit.contain,):
            Image.network('https://cdn.business2community.com/wp-content/uploads/2017/08/blank-profile-picture-973460_640.png')

            ),
           
          ),
          
                    
                    
          if (_imageFile != null)...[
            Image.file(_imageFile),
            

            Row(
              children: <Widget>[
                
                FlatButton(onPressed: _cropImage, child: Icon(Icons.crop)),
                FlatButton(onPressed: _clear, child: Icon(Icons.refresh)),
              ],
            ),

           Uploader(file: _imageFile)
          ]
        ],
      ),
    );
  }
}
