import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pas_mobile_11pplg1_13/networks/client_network_register.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/register_model.dart';
import '../routes/routes.dart';

class RegisterapiController extends GetxController {
  final username = TextEditingController();
  final password = TextEditingController();
  final fullname = TextEditingController();
  final emails = TextEditingController();

  var isLoading = false.obs;
  var registerStatus = "".obs;

  Future<void> register() async {
    final user = username.text.trim();
    final pass = password.text.trim();
    final full = password.text.trim();
    final email = emails.text.trim();

    if (user.isEmpty || pass.isEmpty || full.isEmpty || email.isEmpty) {
      Get.snackbar("Error", "Tidak Boleh ada yang kosong");
      return;
    }

    isLoading.value = true;
    registerStatus.value = "";

    try {
      final url = Uri.parse("${ClientNetworkRegister.baseUrl}latihan/register-user");

      final response = await http.post(
        url,
        body: {
          'username': user,
          'password': pass,
          'full_name': full,
          'email': email,
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final registerModel = RegisterModel.fromJson(data);

        if (registerModel.status == true) {
          final prefs = await SharedPreferences.getInstance();

          await prefs.setString('username', user);
          await prefs.setString('full_name', full);
          await prefs.setString('email', email);

          Get.snackbar(
            "Sukses",
            registerModel.message,
            snackPosition: SnackPosition.TOP,
            duration: const Duration(seconds: 2),
          );

          Get.offAllNamed(AppRoutes.loginapi);
        } else {
          registerStatus.value = "register gagal: ${registerModel.message}";
          Get.snackbar("Gagal", registerModel.message);
        }
      } else {
        registerStatus.value = "Error: ${response.statusCode}";
        Get.snackbar("Error", "Kode HTTP: ${response.statusCode}");
      }   
    } catch (e) {
      registerStatus.value = "Terjadi kesalahan: $e";
      Get.snackbar("Error", "Terjadi kesalahan: $e");
    } 
    isLoading.value = false;
  }

  @override
  void onClose() {
    username.dispose();
    password.dispose();
    fullname.dispose();
    emails.dispose();
    super.onClose();
  }
}
