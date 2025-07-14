import 'package:get/get.dart';
import 'package:vendo_bill/routes/binding/camerascreenbinding.dart';
import 'package:vendo_bill/routes/binding/hive.binding.dart';
import 'package:vendo_bill/routes/binding/main_screen_binding.dart';
import 'package:vendo_bill/routes/binding/qrscan_binding.dart';
import 'package:vendo_bill/widgets/screens/camera_screen.dart';
import 'package:vendo_bill/widgets/screens/hive.screen.dart';
import 'package:vendo_bill/widgets/screens/main_screen.dart';
import 'package:vendo_bill/widgets/screens/qrcodescan_screen.dart';

class Approutes {
   static List<GetPage> routes=[
    GetPage(name: "/", page:() => MainScreen(),binding:MainScreenBinding()  ),
    GetPage(name: "/hive", page: ()=>HiveScreen(),binding: HiveBinding()),
    GetPage(name: "/camera", page: ()=>CameraScreen(),binding: Camerascreenbinding()),
    GetPage(name:"/qrscan",page: ()=>QrcodescanScreen(),binding:QrscanBinding()),
  ];
}