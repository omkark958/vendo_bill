import 'package:get/get.dart';
import 'package:vendo_bill/widgets/controllers/camerascreen.dart';

class Camerascreenbinding extends Bindings {
  @override
  void dependencies() {
    Get.put(CamerascreenController());
  }
}