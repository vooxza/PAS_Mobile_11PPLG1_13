import 'package:get/get.dart';
import 'package:pas_mobile_11pplg1_13/routes/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashscreenController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    checkLogin();
  }

  Future<void> checkLogin() async {
    await Future.delayed(const Duration(seconds: 2));

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token != null && token.isNotEmpty) {
      print("✅ Token ditemukan: $token");
      Get.offAllNamed(AppRoutes.homepage);
    } else {
      print("⚠️ Token tidak ditemukan, kembali ke login");
      Get.offAllNamed(AppRoutes.loginapi);
    }
  }
}
