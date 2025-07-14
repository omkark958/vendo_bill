import 'dart:io';

import 'package:camera/camera.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

class CamerascreenController extends GetxController {
  CameraController? cameraController;
  List<CameraDescription>? availabeCamera;
  RxBool isCameraLoaded=false.obs;
  XFile? capturePic;
  @override
  void onInit() {
    super.onInit();
    loadCamera();
  }
  loadCamera()async{
    availabeCamera=await availableCameras();
    cameraController=CameraController(availabeCamera![0],ResolutionPreset.high);
    cameraController!.initialize().then((_){
      isCameraLoaded.value=true;
    });
  }
  takePicture()async {
    isCameraLoaded.value=false;
    capturePic= await cameraController!.takePicture();
    isCameraLoaded.value=true;
  }
  savePic()async{
    isCameraLoaded.value=false;
   final Directory extDir = await getApplicationDocumentsDirectory();
   final String dirPath = '${extDir.path}/Pictures/flutter_test';
    await Directory(dirPath).create(recursive: true);
    final String filePath = '$dirPath${DateTime.now().millisecondsSinceEpoch}.jpg';
    await capturePic!.saveTo(filePath);
    capturePic=null;
    isCameraLoaded.value=true;
  }
}