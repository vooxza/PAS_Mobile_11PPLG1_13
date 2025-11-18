import 'package:get/get.dart';
import 'package:pas_mobile_11pplg1_13/controllers/loginapi_controller.dart';

class LoginBindingApi extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginApiController>(() => LoginApiController());
  }

}