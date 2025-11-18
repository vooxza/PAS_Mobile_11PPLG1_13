import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pas_mobile_11pplg1_13/controllers/loginapi_controller.dart';
import 'package:pas_mobile_11pplg1_13/pages/home_page.dart';
import 'package:pas_mobile_11pplg1_13/pages/registerapi_page.dart';

class LoginApiPage extends StatelessWidget {
  LoginApiPage({super.key});

  final LoginApiController controller = Get.put(LoginApiController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login Page"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 16),
            const Text(
              "Welcome to our first app",
              style: TextStyle(
                fontSize: 16,
                color: Colors.blueGrey,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Image.asset('assets/logo_flutter.png', width: 100, height: 100),
            const SizedBox(height: 20),

            TextField(
              controller: controller.username,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Username',
              ),
            ),
            const SizedBox(height: 10),

            TextField(
              controller: controller.password,
              obscureText: true,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Password',
              ),
            ),
            const SizedBox(height: 20),

            Obx(() {
              return ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(120, 45),
                ),
                onPressed: controller.isLoading.value
                    ? null
                    : () async {
                        await controller.login();

                        if (controller.loginStatus.value
                            .toLowerCase()
                            .contains("success")) {
                          Get.snackbar(
                            "Login Berhasil",
                            "Selamat datang kembali!",
                            snackPosition: SnackPosition.TOP,
                            backgroundColor: Colors.green.shade600,
                            colorText: Colors.white,
                          );
                          Get.offAll(() => HomePage());
                        }
                      },
                child: controller.isLoading.value
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : const Text("Login"),
              );
            }),

            const SizedBox(height: 20),

            TextButton(
              onPressed: () => Get.to(() => RegisterapiPage()),
              child: const Text("Belum punya akun? Register di sini"),
            ),
          ],
        ),
      ),
    );
  }
}
