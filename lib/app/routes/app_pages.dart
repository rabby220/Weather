import 'package:get/get.dart';

import '../modules/forecast/bindings/forecast_binding.dart';
import '../modules/forecast/views/forecast_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/hourly/bindings/hourly_binding.dart';
import '../modules/hourly/views/hourly_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.FORECAST,
      page: () => ForecastView(),
      binding: ForecastBinding(),
    ),
    GetPage(
      name: _Paths.HOURLY,
      page: () => HourlyView(),
      binding: HourlyBinding(),
    ),
  ];
}
