// main.dart
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
// import 'package:hive_flutter/hive_flutter.dart';
import 'package:vendo_bill/core/theme/app_theme.dart';
import 'package:vendo_bill/routes/app_routes.dart';
import 'widgets/controllers/main_controller.dart';
// Background message handler must be a top-level function
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("🔥 Background Message: ${message.notification}");
  Get.snackbar("From background ", "${message.notification}");
}
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  
  await Hive.initFlutter();
  await Hive.openBox("mapBox");
    FirebaseMessaging.instance.requestPermission();
  // Set background message handler
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  
  Get.put(MainController());
  runApp(const MyApp());
}

class MyApp extends GetView<MainController> {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => GetMaterialApp(
          title: 'Vendo Bill',
          debugShowCheckedModeBanner: false,
          initialRoute: "/",
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: controller.theme.value ? ThemeMode.light : ThemeMode.dark,
          getPages: Approutes.routes
        ));
  }
}



