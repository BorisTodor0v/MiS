import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:location/location.dart';
import 'package:url_launcher/url_launcher.dart';

class LocationService{
  late Location _location;
  bool _serviceEnabled = false;
  PermissionStatus? _grantedPermission;

  LocationService(){
    _location = Location();
  }

  Future<bool> _checkPermission() async {
    if(await _checkService()){
      _grantedPermission = await _location.hasPermission();
      if(_grantedPermission == PermissionStatus.denied){
        _grantedPermission = await _location.requestPermission();
      }
    }
    return _grantedPermission == PermissionStatus.granted;
  }

  Future<bool> _checkService() async {
    try{
      _serviceEnabled = await _location.serviceEnabled();
      if(!_serviceEnabled){
        _serviceEnabled = await _location.requestService();
      }
    } on PlatformException catch(e){
      debugPrint("${e.code}: ${e.message}\n${e.details}\n${e.stacktrace}");
      _serviceEnabled = false;
      await _checkService();
    }
    return _serviceEnabled;
  }

  /*
  originally used to get current location and pass it as parameter to
  openGoogleMaps function, however it works just as good with passing only the
  destination parameter

  Future<LocationData?> getLocation() async {
    if(await _checkPermission()){
      final locationData = _location.getLocation();
      return locationData;
    }
    return null;
  }
  */

  void openGoogleMaps() async {
    final finki = FINKI();
    final url = 'https://www.google.com/maps/dir/?api=1&destination=${finki.lat},${finki.lon}';
    launchUrl(Uri.parse(url));
  }
}

class FINKI{
  double lat = 42.0042537334237;
  double lon = 21.409596179761888;
}