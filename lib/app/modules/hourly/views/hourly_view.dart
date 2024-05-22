import 'package:flutter/material.dart';
import 'package:flutter_weather_bg_null_safety/bg/weather_bg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../utils/app_color.dart';
import '../../../utils/app_text.dart';
import '../../home/controllers/home_controller.dart';
import '../controllers/hourly_controller.dart';

class HourlyView extends GetView<HourlyController> {
  HourlyView({super.key});

  final HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? args = Get.arguments;
    final dynamic forecast = args?['forecast'];

    final currentWidth = MediaQuery.of(context).size.width;
    final currentHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100.0,
        title: Text(AppText.hourForecastText, style: AppText.sunTextStyle, ),
        centerTitle: true,
        backgroundColor: AppColor.whiteColor,
      ),
      body: SafeArea(
        child: SizedBox(
          width: currentWidth,
          height: currentHeight,
          child: Column(
            children: [
              Stack(
                children: [
                  WeatherBg(
                    weatherType:
                        homeController.dayByDayWeatherType(forecast?.day),
                    width: currentWidth,
                    height: 300,
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 30.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                const Text(
                                  AppText.maxTemptText,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      forecast?.day?.maxtempC
                                              ?.round()
                                              .toString() ??
                                          "",
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),

                                    ///
                                    const Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          AppText.degreeText,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 10.0,
                                          ),
                                        ),
                                        Text(
                                          AppText.celsiusText,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20.0,
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                const Text(
                                  AppText.minTemptText,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                                Row(
                                  children: [
                                    Text(
                                      forecast?.day?.mintempC
                                              ?.round()
                                              .toString() ??
                                          "",
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          AppText.degreeText,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 10.0,
                                          ),
                                        ),
                                        Text(
                                          AppText.celsiusText,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20.0,
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                                //Image.asset('assets/icon/low_temp.png'),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 50.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              const Text(
                                AppText.sunRisetText,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                forecast?.astro?.sunrise.toString() ?? "",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),

                          //Sunset
                          Column(
                            children: [
                              const Text(
                                AppText.sunSetText,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                forecast?.astro?.sunset.toString() ?? "",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 50.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              const Text(
                                AppText.windText,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "${forecast?.day?.maxwindKph?.round().toString() ?? ""} Km/h",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),

                          //Sunset
                          Column(
                            children: [
                              Text(
                                forecast?.day?.condition?.text?.toString() ??
                                    "",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              Expanded(
                child: ListView.builder(
                  // shrinkWrap: true,
                  padding: const EdgeInsets.only(
                    top: 20.0,
                  ),
                  itemCount: forecast?.hour?.length,
                  itemBuilder: (_, index) {
                    var forecastHour = forecast?.hour?[index];
                    return SizedBox(
                      height: 200.0,
                      width: currentWidth,
                      child: Card(
                        elevation: 3.0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Center(
                                    child: Center(
                                      child: Text(
                                        DateFormat.jm().format(
                                          DateTime.parse(
                                              forecastHour?.time?.toString() ??
                                                  ""),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Expanded(
                              flex: 1,
                              child: Row(
                                children: [
                                  VerticalDivider(
                                    indent: 30.0,
                                    thickness: 1.0,
                                    endIndent: 30.0,
                                    color: Colors.red,
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      Text(forecastHour?.tempC
                                              ?.round()
                                              .toString() ??
                                          ""),
                                      const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            AppText.degreeText,
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 10.0,
                                            ),
                                          ),
                                          Text(
                                            AppText.celsiusText,
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15.0,
                                            ),
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        width: 15.0,
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Text(forecastHour
                                                ?.condition?.text
                                                ?.toString() ??
                                            ""),
                                      ),
                                    ],
                                  ),

                                  const Divider(
                                    color: Colors.black38,
                                    indent: 5.0,
                                    endIndent: 50.0,
                                    thickness: 1.0,
                                  ),

                                  ///
                                  Row(
                                    children: [
                                      Text(
                                          "${AppText.windText}  : ${forecastHour?.windKph?.round().toString() ?? ""}km/h"),
                                      const SizedBox(
                                        width: 20.0,
                                      ),
                                      Text(
                                          "${AppText.humidityText} : ${forecastHour?.humidity?.round().toString() ?? ""}%"),
                                    ],
                                  ),

                                  const Divider(
                                    color: Colors.black38,
                                    indent: 5.0,
                                    endIndent: 50.0,
                                    thickness: 1.0,
                                  ),

                                  Row(
                                    children: [
                                      Text(
                                          '${AppText.feelsLikeText} : ${forecastHour?.feelslikeC?.round().toString() ?? ""}'),
                                      const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            AppText.degreeText,
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 10.0,
                                            ),
                                          ),
                                          Text(
                                            AppText.celsiusText,
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15.0,
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
