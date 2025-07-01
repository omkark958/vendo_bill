import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vendo_bill/core/theme/colors/app_colors.dart';
import 'package:vendo_bill/widgets/controllers/main_controller.dart';

class MainScreen extends GetView<MainController> {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final primary = isDark ? AppColors.darkPrimary : AppColors.lightPrimary;
    final onPrimary = isDark
        ? AppColors.darkOnPrimary
        : AppColors.lightOnPrimary;
    final secondary = isDark
        ? AppColors.darkSecondary
        : AppColors.lightSecondary;
    final disabled = isDark ? AppColors.darkDisabled : AppColors.lightDisabled;

    return Scaffold(
      appBar: AppBar(
        title: Text("Main", style: TextStyle(color: onPrimary)),
        backgroundColor: primary,
        actions: [
          IconButton(
            icon: Icon(Icons.brightness_6, color: onPrimary),
            onPressed: () => controller.theme.value = !controller.theme.value,
          ),
        ],
      ),
      body: Obx(() => controller.pages[controller.selectedIndex.value]),
      bottomNavigationBar: Obx(() => BottomNavigationBar(
        onTap: (value) => controller.onNavItemTap(value),
        currentIndex: controller.selectedIndex.value,
        backgroundColor: Theme.of(context).colorScheme.surface,
        selectedItemColor: secondary,
        unselectedItemColor: disabled,
        items: [
          BottomNavigationBarItem(
            icon: IconButton(
              icon: Icon(Icons.home),
              onPressed: () {
                controller.onNavItemTap(0);
              },
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: IconButton(
              icon: Icon(Icons.receipt_long),
              onPressed: () {
                controller.onNavItemTap(1);
              },
            ),
            label: "Bills",
          ),
          BottomNavigationBarItem(
            icon: IconButton(
              icon: Icon(Icons.person),
              onPressed: () {
                controller.onNavItemTap(2);
              },
            ),
            label: "Profile",
          ),
        ],
      ),)
    );
  }
}
