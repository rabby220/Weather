import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_weather_bg_null_safety/bg/weather_bg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import '../../../data/models/weather_model.dart';
import '../../../utils/app_color.dart';
import '../../../utils/app_icons.dart';
import '../../../utils/app_text.dart';
import '../../home/controllers/home_controller.dart';
import '../controllers/forecast_controller.dart';

class ForecastView extends GetView<ForecastController> {
  ForecastView({super.key});

  final HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    final currentWidth = MediaQuery.of(context).size.width;
    final currentHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: _buildAppBar(),
      body: FutureBuilder<WeatherModel?>(
        future: homeController.futureWeather.value,
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: SpinKitWave(color: AppColor.black38Color),
            );
          }

          if (snapshot.hasError) {
            return _buildErrorContent();
          }

          if (snapshot.hasData) {
            WeatherModel? weatherModel = snapshot.data;
            return _buildWeatherForecastContent(
                weatherModel, currentWidth, currentHeight);
          }

          return const Center(child: Text('No data available'));
        },
      ),
    );
  }

  /// Builds the app bar for the forecast view
  AppBar _buildAppBar() {
    return AppBar(
      toolbarHeight: 100.0,
      title: Text(
        AppText.sevenDaysForecastText,
        style: AppText.sunTextStyle,
      ),
      centerTitle: true,
      backgroundColor: AppColor.whiteColor,
    );
  }

  /// Builds the error content widget
  Widget _buildErrorContent() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(AppText.locationNotFoundAssetAnim),
          const Text(AppText.failedText),
          _iconButton(
            onClick: () => homeController.updateWeather(),
            icon: AppIcons.refreshIcon,
            color: AppColor.redColor,
            size: 25.0,
          ),
        ],
      ),
    );
  }

  /// Builds the weather forecast content widget
  Widget _buildWeatherForecastContent(
      WeatherModel? weatherModel, double width, double height) {
    if (weatherModel == null || weatherModel.forecast?.forecastday == null) {
      return const Center(child: Text('No forecast data available'));
    }

    return SizedBox(
      width: width,
      height: height,
      child: ListView.builder(
        itemCount: weatherModel.forecast?.forecastday?.length ?? 0,
        itemBuilder: (_, index) {
          var weather = weatherModel.forecast?.forecastday?[index];
          return Card(
            child: Stack(
              children: [
                WeatherBg(
                  weatherType: homeController.dayByDayWeatherType(weather?.day),
                  width: double.infinity,
                  height: 120,
                ),
                ListTile(
                  title: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        DateFormat.yMMMMEEEEd().format(
                          DateTime.parse(weather?.date.toString() ?? ""),
                        ),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(height: 30),
                      Text(
                        weather?.day?.condition?.text ?? "",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                        ),
                      ),
                    ],
                  ),
                  onTap: () {
                    Get.toNamed('/hourly', arguments: {'forecast': weather});
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  /// Builds an icon button
  IconButton _iconButton({
    required VoidCallback onClick,
    required Icon icon,
    Color? color,
    double? size,
  }) {
    return IconButton(
      onPressed: onClick,
      icon: icon,
      color: color,
      iconSize: size,
    );
  }
}
