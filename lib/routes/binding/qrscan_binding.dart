import 'package:get/get.dart';
import 'package:vendo_bill/widgets/controllers/qrcodescan_controller.dart';

class QrscanBinding extends Bindings{
  @override
  void dependencies(){
    Get.put(QrcodescanController());
  }
}