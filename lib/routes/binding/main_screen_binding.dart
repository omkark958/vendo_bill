import 'package:get/get.dart';
import 'package:vendo_bill/widgets/controllers/googlemaps.controller.dart';
import 'package:vendo_bill/widgets/controllers/main_controller.dart';

class MainScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(MainController());
    Get.lazyPut(()=>GooglemapsController());
  }
}