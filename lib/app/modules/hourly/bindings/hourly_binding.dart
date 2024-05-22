import 'package:get/get.dart';

import '../controllers/hourly_controller.dart';

class HourlyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HourlyController>(
      () => HourlyController(),
    );
  }
}
