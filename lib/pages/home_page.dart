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
        extendBody: true,

        body: pages[navController.currentIndex.value],
        bottomNavigationBar: Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
          decoration: const BoxDecoration(
            color: Colors.transparent,
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(32),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.10),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: BottomNavigationBar(
              currentIndex: navController.currentIndex.value,
              onTap: (index) => navController.changeTab(index),

              backgroundColor: Colors.transparent,
              elevation: 0,
              type: BottomNavigationBarType.fixed,
              selectedItemColor: Colors.blueAccent,
              unselectedItemColor: Colors.grey[500],
              showUnselectedLabels: false,

              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.shopping_bag_outlined),
                  activeIcon: Icon(Icons.shopping_bag),
                  label: "Product",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.star_border),
                  activeIcon: Icon(Icons.star),
                  label: "Favorite",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person_outline),
                  activeIcon: Icon(Icons.person),
                  label: "Profile",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
