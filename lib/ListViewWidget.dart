import 'dart:math';

import 'package:flutter/material.dart';
import 'package:dtt_assessment/NotFound.dart';
import 'package:dtt_assessment/House.kts';
import 'package:haversine_distance/haversine_distance.dart';

/// Widget that will show the search result and the list of
/// houses before the search query
class ListViewWidget extends StatelessWidget {
  /// Giving the widget the needed parameters to build the listview
  late Future<List<House>> futureHouses;
  late List<House> items;
  late double long, lat;

  ListViewWidget({super.key, required this.futureHouses, required this.items, required this.long, required this.lat});

  @override
  Widget build(BuildContext context) {
    /// Returns the empty search result if no houses in Items
    if (items.isEmpty) {
      return Scaffold(resizeToAvoidBottomInset: false, body: ListEmpty());
    } else {
      /// Returns the ListView  by building the Future list
      /// of houses first and then building the listview cards
      /// containing the JSON data stored previously
      return FutureBuilder<List<House>>(
        future: futureHouses,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final houses = snapshot.data!;
            if (items.isEmpty) {
              items = houses;
            }
            return ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                items.sort((a, b) => a.price.compareTo(b.price));
                final house = items[index];
                final startCoordinate = Location(house.longitude.toDouble(),house.latitude.toDouble());
                final endCoordinate = Location(long,lat);
                final haversineDistance = HaversineDistance();
                final distance =
                haversineDistance.haversine(startCoordinate, endCoordinate, Unit.KM).toStringAsFixed(2);
                return Card(
                  elevation: 5,
                  child: ListTile(
                    leading: AspectRatio(
                        aspectRatio: 1,
                        child: Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                          fit: BoxFit.cover,
                          alignment: FractionalOffset.topCenter,
                          image: NetworkImage(house.image),
                        )))),
                    title: Column(
                      children: [
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                                '£${house.price}'.replaceAll(
                                    RegExp(r'\B(?=(\d{3})+(?!\d))'), ','),
                                style: const TextStyle(
                                    fontFamily: "Gotham SSm-Bold"))),
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Text("${house.zip} ${house.city}",
                                style: const TextStyle(
                                    fontSize: 12,
                                    color: Color(0x33000000),
                                    fontFamily: "Gotham SSm-Book")))
                      ],
                    ),
                    subtitle: Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Row(children: [
                          const ImageIcon(
                              AssetImage("assets/images/bed-2@2x.png"),
                              size: 15),
                          Text(' ${house.bedrooms}'),
                          const Spacer(),
                          const ImageIcon(
                              AssetImage("assets/images/shower@2x.png"),
                              size: 15),
                          Text(' ${house.bathrooms}'),
                          const Spacer(),
                          const ImageIcon(
                              AssetImage(
                                  "assets/images/square-measument@2x.png"),
                              size: 15),
                          Text(' ${house.size}'),
                          const Spacer(),
                          const ImageIcon(
                              AssetImage("assets/images/pin@2x.png"),
                              size: 15),
                          Text('$distance km')
                        ])),
                    trailing: Text('${house.bathrooms}'),
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
      );
    }
  }
}
