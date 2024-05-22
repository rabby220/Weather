import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:weather/app/utils/app_text.dart';
import '../../../services/check_internet.dart';
import '../controllers/introduce_screen_controller.dart';

class IntroduceScreenView extends GetView<IntroduceScreenController> {
  const IntroduceScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: IntroductionScreen(
          pages: [
            PageViewModel(
              title: "Current  Weather",
              body: "You will see the current weather",
              image: Center(
                child: Lottie.asset(AppText.dayRainAssetAnim),
              ),
            ),
            PageViewModel(
              title: "Forecast 7 days Weather",
              body: "You will see the Forecast 7 days Weather",
              image: Center(
                child: Lottie.asset(AppText.daySnowAssetAnim),
              ),
            ),
            PageViewModel(
              title: "Hourly Check Weather",
              body: "You will see the Hourly weather",
              image: Center(
                child: Lottie.asset(AppText.nightCloudyAssetAnim),
              ),
            ),
          ],
          done: const Text("Get Started"),
          next: const Text("Next"),
          back: const Text("Back"),
          showBackButton: true,
          nextStyle: TextButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.blue,
              tapTargetSize: MaterialTapTargetSize.padded),
          backStyle: TextButton.styleFrom(
              foregroundColor: Colors.black,
              backgroundColor: Colors.transparent,
              tapTargetSize: MaterialTapTargetSize.padded),
          onDone: () {
            Get.put(CheckInternet());
          },
          dotsDecorator: DotsDecorator(
            size: const Size.square(10.0),
            activeSize: const Size(20.0, 10.0),
            activeColor: Theme.of(context).colorScheme.primary,
            spacing: const EdgeInsets.symmetric(horizontal: 3.0),
            activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0)),
          ),
          doneStyle: TextButton.styleFrom(
              foregroundColor: Colors.black,
              backgroundColor: Colors.green,
              tapTargetSize: MaterialTapTargetSize.padded),
        ),
      ),
    );
  }
}
