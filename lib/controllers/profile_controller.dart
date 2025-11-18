import 'package:get/get.dart';
import 'package:pas_mobile_11pplg1_13/routes/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileController extends GetxController {


  Future<void> logout() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('token');
      await prefs.remove('username');

      Get.snackbar(
        "Logout Berhasil",
        "Kamu telah keluar dari akun.",
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 2),
      );

      Get.offAllNamed(AppRoutes.loginapi);
    } catch (e) {
      Get.snackbar(
        "Logout Gagal",
        "Terjadi kesalahan: $e",
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 3),
      );
    }
  }
}
