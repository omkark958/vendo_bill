import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QrcodescanController extends GetxController{
  final MobileScannerController mobileScannerController = MobileScannerController();
  bool isFlashOn = false;
  bool isScanning = true;



  Future<void> pickImageAndScan() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) {
      final result = await mobileScannerController.analyzeImage(picked.path);
    
    }
    }
}