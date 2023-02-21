import 'dart:convert';

import 'package:dtt_assessment/House.kts';
import 'package:dtt_assessment/ListViewWidget.dart';
import 'package:flutter/material.dart';
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
  const Overview({super.key});

  @override
  State<StatefulWidget> createState() => _Overview();
}

class _Overview extends State<Overview> {
  final editingController = TextEditingController();

  ImageIcon iconSearch =
      const ImageIcon(AssetImage("assets/images/search.png"));

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
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: const Color(0xfff7f7f7),
        child: Padding(
            padding: const EdgeInsets.all(25),
            child: Column(children: [
              /// Searchbar
              Expanded(
                  flex: 0,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 30),
                    child: TextField(

                        /// Filter every time a character is typed in TextField
                        onChanged: (value) {
                          filterSearchResults(value);
                          iconSearch = const ImageIcon(
                              AssetImage("assets/images/close-2.png"));
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
                            suffixIcon: IconButton(

                                /// Clear the input when clicking the icon
                                onPressed: () {
                                  editingController.clear();
                                  filterSearchResults("");
                                  setState(() {
                                    iconSearch = const ImageIcon(
                                        AssetImage("assets/images/search.png"));
                                  });
                                },
                                icon: iconSearch),
                            border: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))))),
                  )),

              /// Listview widget containing the search result
              Expanded(
                  child:
                      ListViewWidget(futureHouses: futureHouses, items: items)),
            ])));
  }
}
