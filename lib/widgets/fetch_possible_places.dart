
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:vendo_bill/widgets/controllers/googlemaps.controller.dart';

class GooglePlacesSearch extends GetView<GooglemapsController> {
  Function onSelect = (Map? x) {};
  GooglePlacesSearch(this.onSelect, {super.key});
  // final String googleApiKey = 'AIzaSyCZp2xLKfp2hmPM6QR2oFArzbD-glPICeE';

  // Future<List<String>> fetchSuggestions(String input) async {
  //   if (input.isEmpty) return [];

  //   final String url =
  //       'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&key=$googleApiKey&types=geocode';

  //   final response = await http.get(Uri.parse(url));
  //   if (response.statusCode == 200) {
  //     final data = json.decode(response.body);
  //     final predictions = data['predictions'] as List;
  //     return predictions.map((p) => p['description'] as String).toList();
  //   } else {
  //     throw Exception('Failed to fetch suggestions');
  //   }
  // }
  // Future<List<String>> fetchSuggestions(String input) async {
  //   final url =
  //       'https://nominatim.openstreetmap.org/search?q=$input&format=json&addressdetails=1&limit=5';
  //   final response = await http.get(
  //     Uri.parse(url),
  //     headers: {'User-Agent': 'vendo_bill/1.0 omkarkulkarni958@gmail.com'},
  //   );
  //   controller.data = json.decode(response.body);
  //   List<String> data = controller.data
  //       .map((item) => item['display_name'] as String)
  //       .toList();
  //   return data;
  // }

  onSelectItem(String suggestion) async{
    print(controller.data);
    dynamic x=controller.data.where((item){
      return item['display_name'] == suggestion;
    });
    onSelect(x);
    
  }

  @override
  Widget build(BuildContext context) {
    return TypeAheadField<String>(
      suggestionsCallback: (pattern) async {
        return await controller.fetchSuggestions(pattern);
      },
      itemBuilder: (context, String suggestion) {
        return ListTile(title: Text(suggestion));
      },
      onSelected: (String suggestion) {
        onSelectItem(suggestion);
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Selected: $suggestion')));
        // You can also geocode this suggestion and move the map camera
      },
    );
  }
}
