import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pas_mobile_11pplg1_13/controllers/bottomnav_controller.dart';
import 'package:pas_mobile_11pplg1_13/controllers/product_controller.dart';
import 'package:pas_mobile_11pplg1_13/controllers/profile_controller.dart';
import 'package:pas_mobile_11pplg1_13/pages/favorite_page.dart';
import 'package:pas_mobile_11pplg1_13/pages/product_page.dart';
import 'package:pas_mobile_11pplg1_13/pages/profile_page.dart';

class HomePage extends StatelessWidget {
  final BottomNavController navController = Get.put(BottomNavController());
  final ProductController productController = Get.put(ProductController());
  final ProfileController profileController = Get.put(ProfileController());

  final List<Widget> pages = [
    ProductPage(),
    FavoritePage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: pages[navController.currentIndex.value],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: navController.currentIndex.value,
          onTap: (index) => navController.changeTab(index),
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.shopping_bag), label: "Product"),
            BottomNavigationBarItem(icon: Icon(Icons.star), label: "Favorite"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
          ],
        ),
      ),
    );
  }
}
