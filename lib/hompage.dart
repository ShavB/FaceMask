import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:face_mask/main.dart';
import 'package:tflite/tflite.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CameraImage imgCamera;
  CameraController cameraController;
  bool isWorking = false;
  String result = "";

  initCamera() {
    cameraController = CameraController(cameras[0], ResolutionPreset.ultraHigh);

    cameraController.initialize().then((value) {
      if (!mounted) {
        return;
      }

      setState(() {
        cameraController.startImageStream((imageFromStream) => {
              if (!isWorking)
                {
                  isWorking = true,
                  imgCamera = imageFromStream,
                  runModelOnFrame(),
                }
            });
      });
    });
  }

  loadModel() async{
    await Tflite.loadModel(model: "assets/model.tflite",
    labels: "assets/labels.txt"
    );
  }

  runModelOnFrame() async{
    if(imgCamera != null){
      var recognition = await Tflite.runModelOnFrame(bytesList: imgCamera.planes.map((plane){
        return plane.bytes;
      }).toList(),
        imageHeight: imgCamera.height,
        imageWidth: imgCamera.width,
        imageMean: 127.5,
        imageStd: 127.5,
        rotation: 90,
        numResults: 1,
        threshold: 0.1,
        asynch: true,
      );
      result = "";

      recognition.forEach((response){
        result += response["label"] + "\n";
      });

      setState(() {
        result; 
      });

      isWorking = false;  
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initCamera();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Column(
      children: [
        Container(
          height: size.height - 100,
          child: (!cameraController.value.isInitialized)
              ? Container()
              : AspectRatio(
                aspectRatio: cameraController.value.aspectRatio,
                child: CameraPreview(cameraController),
              ),
        ),
        Text(result, style: TextStyle(fontSize: 20.0, backgroundColor: Colors.red),),
        Text("Text", style: TextStyle(fontSize: 20.0, backgroundColor: Colors.red),)
        ],

    ));
  }
}
