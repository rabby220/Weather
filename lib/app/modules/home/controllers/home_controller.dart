import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_weather_bg_null_safety/utils/weather_type.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import '../../../data/constant/apis.dart';
import '../../../data/models/weather_model.dart';

class HomeController extends GetxController {
  final searchTextController = TextEditingController();

  RxString searchText = "auto:ip".obs;

  late Rx<Future<WeatherModel>> futureWeather;

  @override
  void onInit() {
    super.onInit();
    futureWeather = fetchData(searchText.value).obs;
    ever(searchText, (_) => updateWeather());
  }

  Future<void> updateWeather() async {
    futureWeather.value = fetchData(searchText.value);
  }

  Future<WeatherModel> fetchData(String searchQuery) async {
    final String url = "$baseUrl&q=$searchQuery&days=7";
    try {
      final response = await get(Uri.parse(url));
      if (response.statusCode == 200) {
        final Map<String, dynamic> json = jsonDecode(response.body);
        return WeatherModel.fromJson(json);
      } else {
        throw ApiException("Failed to fetch data: ${response.reasonPhrase}");
      }
    } on ClientException catch (e) {
      throw ApiException("Failed to connect to the server: $e");
    } catch (e) {
      throw ApiException("An unexpected error occurred: $e");
    }
  }

  WeatherType getWeatherType(Current? current) {
    final text = current?.condition?.text?.toLowerCase();
    if (current == null) return WeatherType.middleRainy;

    if (current.isDay == 1) {
      switch (text) {
        case "sunny":
          return WeatherType.sunny;
        case "overcast":
          return WeatherType.overcast;
        case "partly cloudy":
        case "cloudy":
          return WeatherType.cloudy;
        case "mist":
          return WeatherType.lightSnow;
        case "thunder":
          return WeatherType.thunder;
        case "rain":
          return WeatherType.heavyRainy;
        case "showers":
          return WeatherType.middleSnow;
        case "clear":
          return WeatherType.sunny;
        case "fog":
          return WeatherType.foggy;
        default:
          return WeatherType.middleRainy;
      }
    } else {
      switch (text) {
        case "sunny":
          return WeatherType.sunny;
        case "overcast":
          return WeatherType.overcast;
        case "partly cloudy":
        case "cloudy":
          return WeatherType.cloudyNight;
        case "mist":
          return WeatherType.lightSnow;
        case "thunder":
          return WeatherType.thunder;
        case "rain":
          return WeatherType.heavyRainy;
        case "showers":
          return WeatherType.middleSnow;
        case "clear":
          return WeatherType.sunnyNight;
        case "fog":
          return WeatherType.foggy;
        default:
          return WeatherType.middleRainy;
      }
    }
  }

  WeatherType dayByDayWeatherType(Day? day) {
    final text = day?.condition?.text?.toLowerCase();
    if (text == null) return WeatherType.hazy;

    switch (text) {
      case "sunny":
        return WeatherType.sunny;
      case "overcast":
        return WeatherType.overcast;
      case "partly cloudy":
      case "cloudy":
        return WeatherType.cloudy;
      case "mist":
        return WeatherType.lightSnow;
      case "thunder":
        return WeatherType.thunder;
      case "rain":
        return WeatherType.heavyRainy;
      case "showers":
        return WeatherType.middleSnow;
      case "clear":
        return WeatherType.sunny;
      case "fog":
        return WeatherType.foggy;
      default:
        return WeatherType.hazy;
    }
  }

  @override
  void dispose() {
    searchTextController.dispose();
    super.dispose();
  }
}

class ApiException implements Exception {
  final String message;

  ApiException(this.message);

  @override
  String toString() => 'ApiException: $message';
}
