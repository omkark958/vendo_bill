import 'package:get/get.dart';
import 'package:vendo_bill/widgets/controllers/hive.controller.dart';

class HiveBinding extends Bindings{
  @override
  void dependencies(){
    Get.put(HiveController());
  }
}