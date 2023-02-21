import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dtt_assessment/ListViewWidget.dart';
import 'package:http/http.dart' as http;

import 'package:dtt_assessment/HousesClass.kts';

//Fetching the data from the API
Future<String> loadHousesAsset() async {
  final response = await http.get(Uri.parse('https://intern.d-tt.nl/api/house'),
      headers: {"Access-Key": "98bww4ezuzfePCYFxJEWyszbUXc7dxRx"});
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return response.body;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load houses');
  }
}

Future<List<Houses>> loadHouses() async {
  String jsonString = await loadHousesAsset();
  final List<dynamic> parsedJson = json.decode(jsonString);
  return parsedJson.map((json) => Houses.fromJson(json)).toList();
}

class Overview extends StatefulWidget {
  const Overview({super.key});

  @override
  State<StatefulWidget> createState() => _Overview();
}

class _Overview extends State<Overview> {
  final editingController = TextEditingController();
  late ImageIcon iconSearch ;
  late Future<List<Houses>> futureHouses;
  var items = <Houses>[];

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
              Expanded(
                flex: 0,
                child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 30),
                    child: TextField(
                      onChanged: (value) {
                        filterSearchResults(value);
                        iconSearch = const ImageIcon( AssetImage("assets/images/close-2.png"));
                      },
                      onSubmitted: (val) {
                        filterSearchResults(val);
                      },
                      controller: editingController,
                      decoration: InputDecoration(
                        filled: true,
                          fillColor: const Color(0xffebebeb),
                          hintText: "Search for a home",
                          suffixIcon: editingController.text.isNotEmpty ? IconButton(
                              onPressed: () {
                                editingController.clear();
                                filterSearchResults("");
                                setState(() {iconSearch = const ImageIcon( AssetImage("assets/images/search.png") );});

                              },
                              icon: iconSearch)
                              : null,
                          border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5))))),
                    )),
              Expanded(
                  child:
                      ListViewWidget(futureHouses: futureHouses, items: items)),
            ])));
  }
}
