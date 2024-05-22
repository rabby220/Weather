import 'package:flutter/material.dart';
import 'package:weather/app/utils/app_color.dart';

class AppText {
  static const String labelText = "ForeCast";
  static const String appLabelText = "Version";
  static const String versionCode = "1.0";
  static const String searchText = "Search";
  static const String cityText = "City name";
  static const String snacBarTitle = "Search Box is Empty";
  static const String snacBarMessage = "Please enter a query???";
  static const String cancelText = "Cancel";
  static const String autoIpText = "auto:ip";
  static const String feelsLikeText = "Feels Like";
  static const String degreeText = "o";
  static const String celsiusText = "C";
  static const String precipitationText = "Precipitation";
  static const String windText = "Wind";
  static const String humidityText = "Humidity";
  static const String failedText = "Failed to load Data";

  static const String locationNotFoundAssetAnim =
      "assets/anim/location_not_found.json";
  static const String locationAssetAnim = "assets/anim/location.json";
  static const String hourForecastText = "Hourly Forecast";
  static const String sevenDaysForecastText = "7 Days Forecast";
  static const String maxTemptText = "Max Temp";
  static const String minTemptText = "Min Temp";
  static const String sunRisetText = "Sun Rise";
  static const String sunSetText = "Sun Set";

  static TextStyle sunTextStyle = TextStyle(
    color: AppColor.blackColor,
    fontSize: 20.0,
    fontWeight: FontWeight.bold,
  );

  //Weather Celsius Text Style
  static TextStyle celsiusTextStyle = TextStyle(
    color: AppColor.whiteColor,
    fontSize: 20.0,
  );

  //Weather degree Text Style
  static TextStyle degreeTextStyle = TextStyle(
    color: AppColor.whiteColor,
    fontSize: 10.0,
  );

  static TextStyle bigCelsiusTextStyle = TextStyle(
    fontSize: 100.0,
    color: AppColor.whiteColor,
  );
  static TextStyle bigDegreeTextStyle = TextStyle(
    fontSize: 50.0,
    color: AppColor.whiteColor,
  );

  static TextStyle sunTimeTextStyle = TextStyle(
    color: AppColor.whiteColor,
    fontSize: 16.0,
  );

//Location and Time Text Style
  static TextStyle locationWithTimeTextStyle = TextStyle(
    fontSize: 30.0,
    fontWeight: FontWeight.bold,
    color: AppColor.blackColor,
  );

  ///Hourly
  static TextStyle hourlyBackgroundTextStyle = TextStyle(
      color: AppColor.blackColor, fontWeight: FontWeight.bold, fontSize: 15.0);

  static TextStyle hourlyCelsiusTextStyle = TextStyle(
    color: AppColor.blackColor,
    fontSize: 15.0,
  );

  static TextStyle hourlyDegreeTextStyle = TextStyle(
    color: AppColor.redColor,
    fontSize: 10.0,
  );

  static TextStyle hourlyTimeTextStyle =
      TextStyle(color: AppColor.blackColor, fontSize: 17.0);
}
