import 'package:face_mask/splashScreen.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

List<CameraDescription> cameras;

void main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override

  Widget build(BuildContext context) {
    return MaterialApp(
      home: splashScreen(),
    );
  }
}
