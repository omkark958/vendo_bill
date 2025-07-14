import "package:get/get.dart";
import "package:flutter/material.dart";
import "package:mobile_scanner/mobile_scanner.dart";
import "package:vendo_bill/widgets/controllers/qrcodescan_controller.dart";

class QrcodescanScreen extends GetView<QrcodescanController> {
  const QrcodescanScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("QR Scan")),
      body: Column(
        children: [
          ElevatedButton(onPressed: controller.pickImageAndScan, child: const Text("Pick Image")),
          Expanded(
            child: MobileScanner(
              controller: controller.mobileScannerController,
              onDetect: (barcodeCapture) {
                final barcode = barcodeCapture.barcodes.first;
                final String? value = barcode.rawValue;
                if (value != null) {
                  Get.snackbar("title", value);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
