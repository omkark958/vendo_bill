import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:vendo_bill/widgets/controllers/hive.controller.dart';

class HiveScreen extends GetView<HiveController> {
  const HiveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Hive Screen")),
      body: Obx(
        () => Stack(
          children: [
            SizedBox(
              height: 60,
              child: ListView.builder(
                scrollDirection:Axis.horizontal,
                itemCount: controller.keys.length,
                itemBuilder: (context, index) {
                  return ElevatedButton(
                    onPressed: () {},
                    child: Text('${controller.keys[index]}'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
