import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

void main() {
  // Ensure that the splash screen is held during the intialization
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  // Initialize
  runApp(const MyApp());
  // Remove the splash screen after the app init
  FlutterNativeSplash.remove();
}



//Fetching the data from the API
Future<Houses> loadHousesAsset() async {
  /// Since the URL given doesn't work, I will use a local JSON file

  final response = await http
      .get(Uri.parse('https://intern.d-tt.nl/api/house'),
          headers:{HttpHeaders.authorizationHeader: "98bww4ezuzfePCYFxJEWyszbUXc7dxRx"});
  //if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Houses.fromJson(jsonDecode(response.body));
  /* } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load houses');
  }
  return await rootBundle.loadString("assets/houses.json");
}

Future<List<Houses>> loadHouses() async {
  String jsonString = await loadHousesAsset();
  final List<dynamic> parsedJson = json.decode(jsonString);
  return parsedJson.map((json) => Houses.fromJson(json)).toList();*/
}

class Houses {
  final int id;
  final String image;
  final int price;
  final int bedrooms;
  final int bathrooms;
  final int size;
  final String description;
  final String zip;
  final String city;
  final int latitude;
  final int longitude;
  final String createdDate;

  const Houses({
    required this.id,
    required this.image,
    required this.price,
    required this.bedrooms,
    required this.bathrooms,
    required this.size,
    required this.description,
    required this.zip,
    required this.city,
    required this.latitude,
    required this.longitude,
    required this.createdDate,
  });

  factory Houses.fromJson(Map<String, dynamic> json) {
    return Houses(
      id: json['id'],
      image: json['image'],
      price: json['price'],
      bedrooms: json['bedrooms'],
      bathrooms: json['bathrooms'],
      size: json['size'],
      description: json['description'],
      zip: json['zip'],
      city: json['city'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      createdDate: json['createdDate'],
);
  }
}


class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<Houses> futureHouses;

  @override
  void initState() {
    super.initState();
    futureHouses = loadHousesAsset();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DTT REAL ESTATE',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
            color: Colors.transparent,
            shadowColor: Colors.transparent)
      ),
      home: Scaffold(
        /*appBar: AppBar(
          title: const Text('DTT REAL ESTATE',
          style: TextStyle(color: Colors.black),),
        ),*/
        body: SafeArea(
            child:Column (
        children : [
          const Text('DTT REAL ESTATE',
            style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                height: 2,
                fontFamily: "Gotham SSm"
            )
          ),
          Expanded(
          child: Center(
            child: FutureBuilder<Houses>(
              future: futureHouses,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final houses=snapshot.data!;
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          leading: Image.network(houses.image),
                          title: Text(houses.city),
                          subtitle: Text(houses.description),
                          trailing: Text('${houses.price} €'),
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
            )
          ),
        ),
        ])
        )
      ),
    );
  }
}