import 'package:flutter/material.dart';
import 'package:functions_play_ground/Screens/barcodeHome.dart';
import 'package:functions_play_ground/Screens/imageDownload.dart';
import 'package:functions_play_ground/Screens/imagePicker.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'LPI APP',
      theme: ThemeData(
        primaryColor: Colors.purple,
        scaffoldBackgroundColor: Colors.white,
      ),

      initialRoute: ImageDownload.id ,
      routes: {
        ImagePickerScreen.id: (context) => ImagePickerScreen(),
        HomeScreen.id: (context) => HomeScreen(),
        ImageDownload.id: (context) => ImageDownload()
      },
    );
  }
}
 