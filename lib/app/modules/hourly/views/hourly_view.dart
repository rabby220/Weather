import 'package:flutter/material.dart';
import 'package:flutter_weather_bg_null_safety/bg/weather_bg.dart';
import 'package:flutter_weather_bg_null_safety/utils/weather_type.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../utils/app_color.dart';
import '../../../utils/app_text.dart';
import '../../home/controllers/home_controller.dart';
import '../controllers/hourly_controller.dart';

class HourlyView extends GetView<HourlyController> {
  final HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? args = Get.arguments;
    final dynamic forecast = args?['forecast'];

    return Scaffold(
      appBar: _buildAppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildHeader(forecast, context),
              const SizedBox(height: 20),
              _buildHourlyList(forecast),
            ],
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      toolbarHeight: 100.0,
      title: Text(
        AppText.hourForecastText,
        style: AppText.sunTextStyle.copyWith(fontSize: 24.0),
      ),
      centerTitle: true,
      backgroundColor: AppColor.whiteColor,
    );
  }

  Widget _buildHeader(dynamic forecast, context) {
    return Stack(
      children: [
        WeatherBg(
          weatherType: _getWeatherType(forecast?.day),
          width: MediaQuery.of(context).size.width,
          height: 300,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTemperatureInfo(forecast),
              const SizedBox(height: 20.0),
              _buildSunInfo(forecast),
              const SizedBox(height: 20.0),
              _buildWeatherInfo(forecast),
            ],
          ),
        ),
      ],
    );
  }

  WeatherType _getWeatherType(dynamic day) {
    return homeController.dayByDayWeatherType(day);
  }

  Widget _buildTemperatureInfo(dynamic forecast) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildTemperatureItem(
          label: AppText.maxTemptText,
          value: forecast?.day?.maxtempC?.round()?.toString() ?? '',
        ),
        _buildTemperatureItem(
          label: AppText.minTemptText,
          value: forecast?.day?.mintempC?.round()?.toString() ?? '',
        ),
      ],
    );
  }

  Widget _buildTemperatureItem({required String label, required String value}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppText.hourlyBackgroundTextStyle.copyWith(fontSize: 18.0),
        ),
        const SizedBox(height: 5.0),
        Text(
          value,
          style: AppText.hourlyBackgroundTextStyle.copyWith(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 5.0),
        Text(
          '${AppText.degreeText} ${AppText.celsiusText}',
          style: AppText.degreeTextStyle.copyWith(fontSize: 14.0),
        ),
      ],
    );
  }

  Widget _buildSunInfo(dynamic forecast) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildSunItem(AppText.sunRisetText, forecast?.astro?.sunrise),
        _buildSunItem(AppText.sunSetText, forecast?.astro?.sunset),
      ],
    );
  }

  Widget _buildSunItem(String label, String? time) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppText.hourlyBackgroundTextStyle.copyWith(fontSize: 18.0),
        ),
        const SizedBox(height: 5.0),
        Text(
          time ?? '',
          style: AppText.hourlyBackgroundTextStyle.copyWith(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildWeatherInfo(dynamic forecast) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildWeatherCondition(forecast?.day?.condition?.text),
        _buildWeatherItem(
          label: AppText.windText,
          value: '${forecast?.day?.maxwindKph?.round()?.toString() ?? ''} Km/h',
        ),
      ],
    );
  }

  Widget _buildWeatherCondition(String? condition) {
    return Text(
      condition ?? '',
      style: AppText.hourlyBackgroundTextStyle.copyWith(fontSize: 16.0),
    );
  }

  Widget _buildWeatherItem({required String label, required String value}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppText.hourlyBackgroundTextStyle.copyWith(fontSize: 18.0),
        ),
        const SizedBox(height: 5.0),
        Text(
          value,
          style: AppText.hourlyBackgroundTextStyle.copyWith(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildHourlyList(dynamic forecast) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: forecast?.hour?.length ?? 0,
      itemBuilder: (_, index) {
        final forecastHour = forecast?.hour?[index];
        return _buildHourlyCard(forecastHour);
      },
    );
  }

  Widget _buildHourlyCard(dynamic forecastHour) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Card(
        elevation: 3.0,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildHourlyTime(forecastHour),
              _buildHourlyDetails(forecastHour),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHourlyTime(dynamic forecastHour) {
    return Text(
      DateFormat.jm().format(DateTime.parse(forecastHour?.time ?? '')),
      style: AppText.hourlyTimeTextStyle.copyWith(fontSize: 18.0),
    );
  }

  Widget _buildHourlyDetails(dynamic forecastHour) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        _text(
          forecastHour?.tempC?.round()?.toString() ?? '',
          AppText.hourlyBackgroundTextStyle.copyWith(fontSize: 18.0),
        ),
        const SizedBox(height: 5.0),
        _text(
          '${AppText.degreeText}${AppText.celsiusText}',
          AppText.degreeTextStyle.copyWith(fontSize: 14.0),
        ),
        const SizedBox(height: 5.0),
        _text(
          forecastHour?.condition?.text ?? '',
          AppText.hourlyBackgroundTextStyle.copyWith(fontSize: 16.0),
        ),
        const SizedBox(height: 5.0),
        _text(
          '${AppText.windText}: ${forecastHour?.windKph?.round()?.toString() ?? ''} Km/h',
          AppText.hourlyBackgroundTextStyle.copyWith(fontSize: 16.0),
        ),
        const SizedBox(height: 5.0),
        _text(
          '${AppText.humidityText}: ${forecastHour?.humidity?.round()?.toString() ?? ''}%',
          AppText.hourlyBackgroundTextStyle.copyWith(fontSize: 16.0),
        ),
        const SizedBox(height: 5.0),
        _text(
          '${AppText.feelsLikeText}: ${forecastHour?.feelslikeC?.round()?.toString() ?? ''} ${AppText.degreeText}${AppText.celsiusText}',
          AppText.hourlyBackgroundTextStyle.copyWith(fontSize: 16.0),
        ),
      ],
    );
  }

  Text _text(String text, TextStyle style) {
    return Text(text, style: style);
  }
}
