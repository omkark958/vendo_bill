import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

class GooglemapsController extends GetxController {
  GoogleMapController? googleMapController;
  LatLng center = LatLng(37.7749, -122.4194);
  final Rx<Marker?> currentLocationMarker = Rx<Marker?>(null);
  final TextEditingController searchController = TextEditingController();
  Marker? searchedMarker;
  List data = [].obs;
  @override
  void onInit() {
    super.onInit();
    setCurrentLocation();
  }

  Future<void> setCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
    }
    LocationPermission permission = await Geolocator.checkPermission();
    if (!serviceEnabled || permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return;
      }
      if (permission == LocationPermission.deniedForever) {
        await Get.dialog(
          AlertDialog(
            icon: Icon(Icons.warning),
            title: Text("Location Permission Required"),
            content: Text("Allow location Access"),
            actions: [
              ElevatedButton(
                onPressed: () async {
                  bool flag = await Geolocator.openAppSettings();
                  if (flag) {
                    Get.close(1);
                  }
                },
                child: Text("Open Settings"),
              ),
              ElevatedButton(
                onPressed: () {
                  Get.snackbar(
                    "location",
                    "Access denied",
                    colorText: Colors.redAccent,
                  );
                },
                child: Text("Cancel"),
              ),
            ],
          ),
        );
      }
    }
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    LatLng currentLatLng = LatLng(position.latitude, position.longitude);
    center = currentLatLng;
    currentLocationMarker.value = Marker(
      markerId: MarkerId("currentLocation"),
      position: currentLatLng,
      infoWindow: InfoWindow(title: "You are here"),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
    );
    googleMapController?.animateCamera(
      CameraUpdate.newLatLngZoom(currentLatLng, 15),
    );
  }

  void onTap(LatLng argument, {name}) {
    log('$name');
    currentLocationMarker.value = Marker(
      markerId: MarkerId("Selectedlocation"),
      position: argument,
      infoWindow: InfoWindow(title: name ?? "You are here"),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
    );
    googleMapController?.animateCamera(
      CameraUpdate.newLatLngZoom(argument, 15),
      duration: Duration(seconds: 2),
    );
  }

  Future<void> searchLocation() async {
    String query = searchController.text;
    if (query.isEmpty) return;

    List<Location> locations = await locationFromAddress(query);
    if (locations.isEmpty) return;

    LatLng target = LatLng(locations.first.latitude, locations.first.longitude);

    currentLocationMarker.value = Marker(
      markerId: MarkerId("searchedLocation"),
      position: target,
      infoWindow: InfoWindow(title: query),
      icon: BitmapDescriptor.defaultMarker,
    );

    googleMapController?.animateCamera(CameraUpdate.newLatLngZoom(target, 15));
  }

  void onMapCreated(GoogleMapController controller) {
    googleMapController = controller;
  }

  // LatLng center() {
  //   return center;
  // }

  Future<List<String>> fetchSuggestions(String input) async {
    final url =
        'https://nominatim.openstreetmap.org/search?q=$input&format=json&addressdetails=1&limit=5';
    final response = await http.get(
      Uri.parse(url),
      headers: {'User-Agent': 'vendo_bill/1.0 omkarkulkarni958@gmail.com'},
    );
    this.data = json.decode(response.body);
    List<String> data = this.data
        .map((item) => item['display_name'] as String)
        .toList();
    return data;
  }

  Future<void> getCityFromLatLng(LatLng argument, {name}) async {
    final url =
        'https://nominatim.openstreetmap.org/reverse?lat=${argument.latitude}&lon=${argument.longitude}&format=json&addressdetails=1';

    final response = await http.get(
      Uri.parse(url),
      headers: {
        'User-Agent':
            'vendo_bill/1.0 omkarkulkarni958@gmail.com', // Required by Nominatim
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final address = data['address'];
      String? name =
          address['village'] ??
          address['hamlet'] ??
          address['city'] ??
          address['town'] ??
          address['state'] ??
          "Selected location";
      onTap(argument, name: name);
      Get.dialog(
        AlertDialog(
          title: Stack(
            children: [
              Text("Selected location Info"),
              Positioned(
                top: -10,
                right: 0,
                child: IconButton(
                  icon: Icon(Icons.cancel_outlined),
                  onPressed: () {
                    Get.close(1);
                  },
                ),
              ),
            ],
          ),
          content: SizedBox(
            height: 60,
            child: Stack(
              clipBehavior: Clip.none,
              children: [Text(data['display_name'])],
            ),
          ),
        ),
        barrierDismissible: false,
      ); // fallback
    } else {
      print('Failed to fetch city');
      return null;
    }
  }
}
