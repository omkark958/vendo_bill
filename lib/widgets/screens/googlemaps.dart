import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:vendo_bill/widgets/controllers/googlemaps.controller.dart';
import 'package:vendo_bill/widgets/fetch_possible_places.dart';

class GoogleMapsSceern extends GetView<GooglemapsController> {
  @override
  Widget build(BuildContext context) {
    Set<Marker> allMarkers = {};
    if (controller.currentLocationMarker.value != null) {allMarkers.add(controller.currentLocationMarker.value!);}
    return Scaffold(
      body: Obx(() {
        Set<Marker> allMarkers = {};
        if (controller.currentLocationMarker.value != null) {
          allMarkers.add(controller.currentLocationMarker.value!);
        }

        return Stack(children:[
          GoogleMap(
            mapType: MapType.hybrid,
          onMapCreated: controller.onMapCreated,
          onTap: controller.getCityFromLatLng,
          initialCameraPosition: CameraPosition(target: controller.center, zoom: 12),
          myLocationEnabled: true,
          myLocationButtonEnabled: true,
          markers: allMarkers,

        ),
          Positioned(
            top: 10,
            left: 10,
            right: 10,
            child: Card(
              elevation: 5,
              child: Row(
                children: [
                  Expanded(
                    child: 
                    // TextField(
                    //   controller: controller.searchController,
                    //   decoration: InputDecoration(
                    //     hintText: "Search location",
                    //     contentPadding: EdgeInsets.symmetric(horizontal: 15),
                    //     border: InputBorder.none,
                    //   ),
                    // ),
                    GooglePlacesSearch((x,suggestion){
                      controller.searchController.text=suggestion;
                      controller.onTap(LatLng(double.parse(x.first["lat"]), double.parse(x.first["lon"])),name:x.first['name']);
                      log('***** \n ${x.first} \n ****************');
                    })
                  ),
                  IconButton(onPressed: (){
                    controller.searchController.text="";
                  }, icon: Icon(Icons.cancel)),
                  IconButton(
                    icon: Icon(Icons.search),
                    onPressed: controller.searchLocation,
                  ),
        ])))]);
      }),
       
    );
  }
}


