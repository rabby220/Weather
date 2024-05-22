import 'package:get/get.dart';

import '../controllers/introduce_screen_controller.dart';

class IntroduceScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IntroduceScreenController>(
      () => IntroduceScreenController(),
    );
  }
}
