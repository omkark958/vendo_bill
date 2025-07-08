import 'package:get/get.dart';
import 'package:vendo_bill/routes/binding/main_screen_binding.dart';
import 'package:vendo_bill/widgets/screens/main_screen.dart';

class Approutes {
   static List<GetPage> routes=[
    GetPage(name: "/", page:() => MainScreen(),binding:MainScreenBinding()  )
  ];
}