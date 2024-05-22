import 'package:flutter/material.dart';
import 'package:flutter_weather_bg_null_safety/flutter_weather_bg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:sidebarx/sidebarx.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:weather/app/data/models/weather_model.dart';
import 'package:weather/app/utils/app_text.dart';
import 'package:weather/app/utils/app_color.dart';
import 'package:weather/app/utils/app_icons.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeView({super.key});

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final currentWidth = MediaQuery.of(context).size.width;
    final currentHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      key: scaffoldKey,
      drawer: _buildDrawer(),
      body: Obx(
        () => SafeArea(
          child: FutureBuilder<WeatherModel?>(
            future: controller.futureWeather.value,
            builder: (_, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child:Lottie.asset(AppText.locationAssetAnim),
                );
              }

              if (snapshot.hasError) {
                return _buildErrorContent();
              }

              if (snapshot.hasData) {
                final weatherModel = snapshot.data;
                return _buildWeatherContent(
                    weatherModel, currentWidth, currentHeight);
              }

              return const Center(child: Text('No data available'));
            },
          ),
        ),
      ),
    );
  }

  Widget _buildDrawer() {
    return SidebarX(
      showToggleButton: true,
      collapseIcon: AppIcons.arrowBackIosIcon,
      extendedTheme: SidebarXTheme(
        width: 250,
        decoration: BoxDecoration(color: AppColor.whiteColor),
        padding: const EdgeInsets.all(50.0),
      ),
      controller: SidebarXController(selectedIndex: 0, extended: true),
      items: [
        SidebarXItem(
          icon: AppIcons.trendingUpIcon,
          label: AppText.labelText,
          onTap: () => Get.toNamed('/forecast'),
        ),
        SidebarXItem(
          icon: AppIcons.infoOutlineIcon,
          label: AppText.appLabelText,
          onTap: () {
            _showSnackBar(AppText.appLabelText, AppText.versionCode);
          },
        ),
      ],
    );
  }

  Widget _buildWeatherContent(
      WeatherModel? weatherModel, double width, double height) {
    return SizedBox(
      height: height,
      width: width,
      child: Stack(
        children: [
          WeatherBg(
            weatherType: controller.getWeatherType(weatherModel?.current),
            width: width,
            height: height,
          ),
          _buildLocationInfo(weatherModel),
          _buildTopBar(),
          _buildWeatherDetails(weatherModel),
        ],
      ),
    );
  }

  Widget _buildErrorContent() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(AppText.locationNotFoundAssetAnim),
          const Text(AppText.failedText),
          _iconButton(
            onClick: () => controller.updateWeather(),
            /*onClick: () {
              Get.toNamed('/forecast');},*/
            icon: AppIcons.refreshIcon,
            color: AppColor.redColor,
            size: 25.0,
          ),
        ],
      ),
    );
  }

  Widget _buildLocationInfo(WeatherModel? weatherModel) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.only(top: 100.0, right: 30.0, left: 30.0),
            child: AutoSizeText(
              "${weatherModel?.location?.name ?? ""}, ${weatherModel?.location?.country ?? ""}\n"
              "${DateFormat.yMMMMEEEEd().format(
                DateTime.parse(weatherModel?.current?.lastUpdated ?? ""),
              )}",
              maxLines: 3,
              minFontSize: 20,
              style: AppText.locationWithTimeTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTopBar() {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _iconButton(
            onClick: () => scaffoldKey.currentState?.openDrawer(),
            icon: AppIcons.menuSharpIcon,
            color: AppColor.whiteColor,
            size: 30.0,
          ),
          Row(
            children: [
              IconButton(
                onPressed: () => _showSearchDialog(),
                icon: Icon(AppIcons.searchRouIcon,
                    size: 30.0, color: AppColor.whiteColor),
              ),
              _iconButton(
                onClick: () => controller.searchText.value = AppText.autoIpText,
                icon: AppIcons.locationOnIcon,
                color: AppColor.redColor,
                size: 30.0,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildWeatherDetails(WeatherModel? weatherModel) {
    return Center(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _text(weatherModel?.current?.tempC?.round().toString() ?? "",
                    AppText.bigCelsiusTextStyle),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _text(AppText.degreeText, AppText.bigDegreeTextStyle),
                    _text(AppText.celsiusText, AppText.bigCelsiusTextStyle),
                  ],
                ),
              ],
            ),
            _text(weatherModel?.current?.condition?.text ?? "",
                AppText.sunTextStyle),
            const SizedBox(height: 100.0),
            _buildWeatherAttributes(weatherModel),
            Divider(
              height: 50.0,
              color: AppColor.black38Color,
              thickness: 1.0,
              endIndent: 50.0,
              indent: 50.0,
            ),
            _buildWindAndHumidity(weatherModel),
          ],
        ),
      ),
    );
  }

  Widget _buildWeatherAttributes(WeatherModel? weatherModel) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildWeatherAttribute(
          AppText.feelsLikeText,
          "${weatherModel?.current?.feelslikeC?.round() ?? ""}°C",
        ),
        _buildWeatherAttribute(
          AppText.precipitationText,
          "${weatherModel?.current?.visKm?.round() ?? ""} km",
        ),
      ],
    );
  }

  Widget _buildWeatherAttribute(String label, String value) {
    return Column(
      children: [
        _text(label, AppText.sunTextStyle),
        _text(value, AppText.sunTimeTextStyle),
      ],
    );
  }

  Widget _buildWindAndHumidity(WeatherModel? weatherModel) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildWeatherAttribute(
          AppText.windText,
          "${weatherModel?.current?.windKph?.round() ?? ""} Km/h",
        ),
        _buildWeatherAttribute(
          AppText.humidityText,
          "${weatherModel?.current?.humidity?.round() ?? ""} %",
        ),
      ],
    );
  }

  void _showSearchDialog() {
    Get.dialog(
      AlertDialog(
        title: const Text(AppText.searchText),
        content: TextFormField(
          decoration: const InputDecoration(hintText: AppText.cityText),
          keyboardType: TextInputType.text,
          controller: controller.searchTextController,
        ),
        actions: [
          _materialButton(
            onPressed: () {
              if (controller.searchTextController.text.isEmpty) {
                _showSnackBar(AppText.snacBarTitle, AppText.snacBarMessage);
              } else {
                controller.searchText.value =
                    controller.searchTextController.text;
                controller.searchTextController.clear();
                Get.back();
              }
            },
            text: AppText.searchText,
            color: AppColor.greenColor,
          ),
          _materialButton(
            onPressed: () => Get.back(),
            text: AppText.cancelText,
            textColor: AppColor.blackColor,
          ),
        ],
      ),
    );
  }

  void _showSnackBar(String title, String message) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: AppColor.whiteColor,
      colorText: AppColor.blackColor,
    );
  }

  MaterialButton _materialButton({
    required VoidCallback onPressed,
    Color? textColor,
    required String text,
    Color? color,
  }) {
    return MaterialButton(
      onPressed: onPressed,
      textColor: textColor,
      color: color,
      child: Text(text),
    );
  }

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

  Text _text(String text, TextStyle style) {
    return Text(text, style: style);
  }
}
