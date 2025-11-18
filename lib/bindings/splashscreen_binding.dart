import 'package:get/get.dart';
import 'package:pas_mobile_11pplg1_13/controllers/splashscreen_controller.dart';

class SplashscreenBinding extends Bindings {
  @override

  void dependencies() {
    Get.put(SplashscreenController());
  }

}