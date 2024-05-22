import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';

class CheckInternet extends GetxService {
  Future<void> checkConnectivity() async {
    final connectivityResult = await (Connectivity().checkConnectivity());

    if (connectivityResult.contains(ConnectivityResult.none)) {
      Get.snackbar('No Internet', 'Please Check Your Internet Connection.',
          snackPosition: SnackPosition.BOTTOM);
    } else {
      Get.offNamed('/home');
    }
  }

  StreamSubscription? streamSubscription;

  @override
  void onInit() {
    super.onInit();
    StreamSubscription streamSubscription =
        Connectivity().onConnectivityChanged.listen((event) {
      checkConnectivity();
    });
  }

  @override
  void onClose() {
    streamSubscription!.cancel();
    super.onClose();
  }
}
