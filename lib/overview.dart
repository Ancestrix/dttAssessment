import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:dtt_assessment/HousesClass.kts';

//Fetching the data from the API
Future<String> loadHousesAsset() async {
  /// Since the URL given doesn't work, I will use a local JSON file
  /*
  final response = await http
      .get(Uri.parse('https://intern.d-tt.nl/api/house'),
          headers:{HttpHeaders.authorizationHeader: "98bww4ezuzfePCYFxJEWyszbUXc7dxRx"});
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Houses.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load houses');
  }*/
  return await rootBundle.loadString("assets/houses.json");
}


Future<List<Houses>> loadHouses() async {
  String jsonString = await loadHousesAsset();
  final List<dynamic> parsedJson = json.decode(jsonString);
  return parsedJson.map((json) => Houses.fromJson(json)).toList();
}

Future<Iterable<Houses>> loadHouses2() async {
  String jsonString = await loadHousesAsset();
  final List<dynamic> parsedJson = json.decode(jsonString);
  return parsedJson.map((json) => Houses.fromJson(json));
}

class Overview extends StatefulWidget {
  const Overview({super.key});

  @override
  State<StatefulWidget> createState() => _Overview();
}

class _Overview extends State<Overview> {
  TextEditingController editingController = TextEditingController();
  late Future<List<Houses>> futureHouses;
  String search ="";


  late Widget fun;

  var items = <String>[];

  void filterSearchResults(String query,List<String> duplicateItems) {
    List<String> dummySearchList = <String>[];
    dummySearchList=duplicateItems;
    if(query.isNotEmpty) {
      List<String> dummyListData = <String>[];
      dummySearchList.forEach((item) {
        if(item.toLowerCase().contains(query)) {
          dummyListData.add(item);
        }
      });
      setState(() {
        items.clear();
        items.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        items.clear();
        items=duplicateItems;
      });
    }

  }
  @override
  void initState() {
    super.initState();
    futureHouses = loadHouses();
  }



  final List<String> duplicateItems = loadHouses().asStream().toString().split(" ");
  
  @override
  Widget build(BuildContext context) {
    return Container(
        color: const Color(0x00f7f7f7),
        child: Padding(
            padding: const EdgeInsets.all(25),
            child: Column(children: [
              Expanded(
                child: TextField(
                  onChanged: (value) {
                    search=value;
                    filterSearchResults(value,duplicateItems);
                  },
                  controller: editingController,
                  decoration: const InputDecoration(
                      labelText: "Search",
                      hintText: "Search",
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25.0)))),
                ),
              ),
              Expanded(
                  child: FutureBuilder<List<Houses>>(
                    future: futureHouses,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        int count;
                        final houses = snapshot.data!;
                        if(items.isEmpty){count=houses.length;}
                        else{count=items.length;}
                        return ListView.builder(
                          itemCount: houses.length,
                          itemBuilder: (context, index) {
                            final house = houses[index];
                            duplicateItems.add(house.city);
                            return Card(
                              child: ListTile(
                                leading: AspectRatio(
                                    aspectRatio: 1,
                                    child: Container(
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                      fit: BoxFit.cover,
                                      alignment: FractionalOffset.topCenter,
                                      image: NetworkImage(house.image),
                                    )
                                        )
                                    )
                                ),
                                title: Text(items[index]),
                                subtitle: Text(house.description),
                                trailing: Text('${house.price} €'),
                              ),
                            );
                          },
                        );
                      } else if (snapshot.hasError) {
                        return Text('${snapshot.error}');
                      }

                      // By default, show a loading spinner.
                      return const CircularProgressIndicator();
                },
              )),
            ])));
  }
}
