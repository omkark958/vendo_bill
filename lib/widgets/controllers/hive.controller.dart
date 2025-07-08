import 'dart:developer';

import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveController extends GetxController{
  Box? mapBox;
  RxList keys=[].obs;
  RxMap map={}.obs;
  @override
  void onInit() async{
    mapBox= Hive.box("mapBox");
    keys.value=mapBox!.keys.toList();
    log('${mapBox!.values} mapBox');
    super.onInit();
  }
}