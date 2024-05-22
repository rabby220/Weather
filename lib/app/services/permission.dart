import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionHandler {
  Future<PermissionStatus> requestPermission() async {
    var status = await Permission.location.status;
    if (!status.isGranted) {
      status = await Permission.location.request();
    }
    if (status.isGranted) {
      await Geolocator.getCurrentPosition();
    } else if (status.isDenied) {
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
    }
    return status;
  }
}
