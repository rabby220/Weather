import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather/app/theme/app_theme.dart';
import 'app/routes/app_pages.dart';
import 'app/services/permission.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

//Permission Handle when app will Open..
  PermissionHandler().requestPermission();

  runApp(
    GetMaterialApp(
      themeMode: ThemeMode.system,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
