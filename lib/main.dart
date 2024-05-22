import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather/app/theme/app_theme.dart';
import 'app/routes/app_pages.dart';
import 'app/services/check_internet.dart';
import 'app/services/permission.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

//Permission Handle when app will Open..
  await PermissionHandler().requestPermission();

  runApp(
    GetMaterialApp(
      themeMode: ThemeMode.system,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,

      //Global setting  for all page
      enableLog: true,
      defaultTransition: Transition.fade,
      opaqueRoute: Get.isOpaqueRouteDefault,
      popGesture: Get.isPopGestureEnable,
      transitionDuration: Get.defaultTransitionDuration,
      defaultGlobalState: Get.defaultPopGesture,

    ),
  );
}
