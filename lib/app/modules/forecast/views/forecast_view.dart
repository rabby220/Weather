import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_weather_bg_null_safety/bg/weather_bg.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

import '../../../data/models/weather_model.dart';
import '../../../utils/app_color.dart';
import '../../../utils/app_text.dart';
import '../../home/controllers/home_controller.dart';
import '../../hourly/views/hourly_view.dart';
import '../controllers/forecast_controller.dart';

class ForecastView extends GetView<ForecastController> {
   ForecastView({super.key});

  final HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    final currentWidth = MediaQuery.of(context).size.width;
    final currentHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100.0,
        title:  Text(
            AppText.sevenDaysForecastText,
          style: AppText.sunTextStyle),
        centerTitle: true,
        backgroundColor: AppColor.whiteColor,
      ),
      body: FutureBuilder(
        future: homeController.futureWeather.value,
        builder: (_, snapshot) {
          if (snapshot.hasData) {
            WeatherModel? weatherModel = snapshot.data;
            return SizedBox(
              width: currentWidth,
              height: currentHeight,
              child: ListView.builder(
                itemCount: weatherModel?.forecast?.forecastday?.length,
                itemBuilder: (_, index) {
                  var weather = weatherModel?.forecast?.forecastday?[index];
                  return Card(
                    child: Stack(
                      children: [
                        Card(
                          child: WeatherBg(
                              weatherType: homeController
                                  .dayByDayWeatherType(weather?.day),
                              width: double.infinity,
                              height: 120),
                        ),
                        ListTile(
                          title: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                DateFormat.yMMMMEEEEd().format(
                                  DateTime.parse(
                                      weather?.date.toString() ?? ""),
                                ),
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              Text(
                                weather?.day?.condition?.text ?? "",
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 17),
                              ),
                            ],
                          ),
                          onTap: () {
                            Get.toNamed('/hourly' , arguments: {'forecast' : weather} );
                            /*Get.to(
                                  () => HourlyView(
                                forecast: weather,
                              ),
                            );*/
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset('assets/anim/failure.json'),
                  const Text('Failed to load Data'),
                  IconButton(
                    onPressed: () {
                      homeController.updateWeather();
                    },
                    icon: const Icon(Icons.refresh),
                  ),
                ],
              ),
            );
          }

          return const Center(
            child: SpinKitWave(color: Colors.black38),
          );
        },
      ),
    );
  }
}