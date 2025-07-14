import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vendo_bill/widgets/controllers/camerascreen.dart';

class CameraScreen extends GetView<CamerascreenController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => controller.isCameraLoaded.value
            ? Column(
                children: [
                  if (controller.capturePic == null) ...[
                    Expanded(
                      child: CameraPreview(controller.cameraController!),
                    ),
                    ElevatedButton(
                      onPressed: controller.takePicture,
                      child: Text("take Pic"),
                    ),
                  ],
                if (controller.capturePic != null) ...[
                    Expanded(
                      child: Image.file(File(controller.capturePic!.path)),
                    ),
                    ElevatedButton(
                      onPressed: controller.takePicture,
                      child: Text("take Pic"),
                    ),
                  ],]
              )
            : Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
