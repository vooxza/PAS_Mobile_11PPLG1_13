import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pas_mobile_11pplg1_13/controllers/loginapi_controller.dart';
import 'package:pas_mobile_11pplg1_13/controllers/registerapi_controller.dart';
import 'package:pas_mobile_11pplg1_13/pages/home_page.dart';
import 'package:pas_mobile_11pplg1_13/pages/loginapi_page.dart';

class RegisterapiPage extends StatelessWidget {
  RegisterapiPage({super.key});

  final RegisterapiController controller = Get.put(RegisterapiController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Register Page"), centerTitle: true),
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
            TextField(
              controller: controller.fullname,
              obscureText: false,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Full Name',
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: controller.emails,
              obscureText: false,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Email',
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
                        await controller.register();

                        if (controller.registerStatus.value
                            .toLowerCase()
                            .contains("success")) {
                          Get.snackbar(
                            "Login Berhasil",
                            "Selamat datang !",
                            snackPosition: SnackPosition.TOP,
                            backgroundColor: Colors.green.shade600,
                            colorText: Colors.white,
                          );
                          Get.offAll(() => LoginApiPage());
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
                    : const Text("Register"),
              );
            }),

            const SizedBox(height: 10),
            
            TextButton(
              onPressed: () => Get.to(() => LoginApiPage()),
              child: const Text("Sudah punya akun? Login disini"),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
