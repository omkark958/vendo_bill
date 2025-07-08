import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vendo_bill/widgets/screens/googlemaps.dart';

class MainController extends GetxController {
  RxBool theme=true.obs;
    RxInt selectedIndex = 0.obs;
@override
  void onInit() {
    super.onInit();

    // When app is in foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('📱 Foreground message received: ${message.notification?.title}');
      Get.snackbar("From foreground", "No Messages");
    });

    // When app is opened from background
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('🚀 App opened from background message: ${message.notification?.title}');
    });
FirebaseMessaging.instance.getToken().then((token) {
  print('Device Token: $token');
});
    // When app is opened from terminated state
    _checkInitialMessage();
  }
  Future<void> _checkInitialMessage() async {
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      print('⚡️ App opened from terminated state: ${initialMessage.notification?.title}');
      Get.snackbar("From Kill State", "Yes ${initialMessage.notification?.title}");
    }
     Get.snackbar("From Kill State", "No Messages $initialMessage");
  }
  final List<Widget> pages =  [ GoogleMapsSceern(),
    Center(child: Text("Bills Page")),
    Center(child: Text("Profile Page")),
  ]; 

  
  
  onNavItemTap(int index){
    selectedIndex.value=index;
  }
} 