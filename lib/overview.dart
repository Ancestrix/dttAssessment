import 'dart:async';
import 'dart:convert';

import 'package:dtt_assessment/House.kts';
import 'package:dtt_assessment/list_view_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

/// Fetching the data from the API
Future<String> loadHousesAsset() async {
  final response = await http.get(Uri.parse('https://intern.d-tt.nl/api/house'),
      headers: {"Access-Key": "98bww4ezuzfePCYFxJEWyszbUXc7dxRx"});
  if (response.statusCode == 200) {
    /// If the server did return a 200 OK response, then parse the JSON.
    return response.body;
  } else {
    /// If the server did not return a 200 OK response, then throw an exception.
    throw Exception('Failed to load houses');
  }
}

/// Load the houses from the response and parse the JSON data
Future<List<House>> loadHouses() async {
  String jsonString = await loadHousesAsset();
  final List<dynamic> parsedJson = json.decode(jsonString);
  return parsedJson.map((json) => House.fromJson(json)).toList();
}

/// Overview widget that will be use by the navigation bar
class Overview extends StatefulWidget {
  late bool isDarkMode;

  Overview(this.isDarkMode, {super.key});

  @override
  State<StatefulWidget> createState() => _Overview();
}

class _Overview extends State<Overview> {
  final editingController = TextEditingController();

  bool servicestatus = false;
  bool haspermission = false;
  late LocationPermission permission;
  late Position position;
  double long = 0, lat = 0;
  late StreamSubscription<Position> positionStream;

  /// Houses supposed to be instanced during the FutureBuilder
  late Future<List<House>> futureHouses;

  /// Items shown in the result listview
  var items = <House>[];

  /// Filter the ListView depending on the searchbar query
  void filterSearchResults(String query) {
    futureHouses.then((data) => {
          setState(() {
            items = data
                .where((element) => ("${element.zip} ${element.city}")
                    .toLowerCase()
                    .contains(query.toLowerCase()))
                .toList();
          })
        });
  }

  /// Initiate the state of the Houses and the result listview
  @override
  void initState() {
    super.initState();
    futureHouses = loadHouses();
    filterSearchResults("");
    checkGps();
  }

  /// Ensure the permission status concerning the device location
  checkGps() async {
    servicestatus = await Geolocator.isLocationServiceEnabled();
    if (servicestatus) {
      permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          if (kDebugMode) {
            print('Location permissions are denied');
          }
        } else if (permission == LocationPermission.deniedForever) {
          if (kDebugMode) {
            print("'Location permissions are permanently denied");
          }
        } else {
          haspermission = true;
        }
      } else {
        haspermission = true;
      }

      if (haspermission) {
        setState(() {
          //refresh the UI
        });

        getLocation();
      }
    } else {
      if (kDebugMode) {
        print("GPS Service is not enabled, turn on GPS location");
      }
    }

    setState(() {
      //refresh the UI
    });
  }

  /// Get the user position by storing longitude and latitude
  getLocation() async {
    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    long = position.longitude;
    lat = position.latitude;

    setState(() {
      ///refresh UI
    });
  }

  ImageIcon iconSearch = ImageIcon(
    AssetImage("assets/images/search.png"),
  );
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Padding(
            padding: const EdgeInsets.all(25),
            child: Column(children: [
              /// Searchbar
              Expanded(
                  flex: 0,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 25),
                    child: TextField(
                        style: TextStyle(
                            fontFamily: "Gotham SSm-Light",
                            fontSize: 12,
                            color: widget.isDarkMode
                                ? Color(0xffe65541)
                                : Colors.black),

                        /// Filter every time a character is typed in TextField
                        onChanged: (value) {
                          filterSearchResults(value);
                          setState(() {
                            iconSearch = ImageIcon(
                              AssetImage("assets/images/close-2.png"),
                              color: widget.isDarkMode
                                  ? Color(0xffe65541)
                                  : Colors.black,
                            );
                          });
                        },

                        /// Filter once again when the query is submitted
                        onSubmitted: (val) {
                          filterSearchResults(val);
                        },
                        controller: editingController,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: const Color(0xffebebeb),
                            hintText: "Search for a home",
                            hintStyle: const TextStyle(
                                fontSize: 12,
                                color: Color(0x66000000),
                                fontFamily: "Gotham SSm-Book"),
                            suffixIcon: IconButton(

                                /// Clear the input when clicking the icon
                                onPressed: () {
                                  editingController.clear();
                                  filterSearchResults("");
                                  setState(() {
                                    iconSearch = ImageIcon(
                                      AssetImage("assets/images/search.png"),
                                      color: widget.isDarkMode
                                          ? Color(0xffe65541)
                                          : Colors.black,
                                    );
                                  });
                                },
                                icon: iconSearch),
                            border: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))))),
                  )),

              /// Listview widget containing the search result
              Expanded(
                  child: ListViewWidget(
                widget.isDarkMode,
                futureHouses: futureHouses,
                items: items,
                lat: lat,
                long: long,
              )),
            ])));
  }
}
