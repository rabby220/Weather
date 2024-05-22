import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:get/get.dart';
class PermissionHandler {
  get currentLocation => currentLocation;

  Future<void> requestPermission() async {
    Rx<LocationData?> currentLocation = Rx<LocationData?>(null);
    var permissionStatus = await Permission.location.request();
    if(permissionStatus.isGranted){
      Location location = Location();
      currentLocation.value = await location.getLocation();
    }
    else{
      openAppSettings();
    }

  }
}