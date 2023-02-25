import 'package:flutter/material.dart';
import 'package:dtt_assessment/not_found.dart';
import 'package:dtt_assessment/House.kts';
import 'package:animate_do/animate_do.dart';
import 'package:dtt_assessment/detail.dart';
import 'package:haversine_distance/haversine_distance.dart';

/// Widget that will show the search result and the list of
/// houses before the search query
class ListViewWidget extends StatelessWidget {
  late bool isDarkMode;

  /// Giving the widget the needed parameters to build the listview
  late Future<List<House>> futureHouses;
  late List<House> items;
  late double long, lat;

  ListViewWidget(bool this.isDarkMode,
      {super.key,
      required this.futureHouses,
      required this.items,
      required this.long,
      required this.lat});

  @override
  Widget build(BuildContext context) {
    /// Returns the empty search result if no houses in Items
    if (items.isEmpty) {
      return Scaffold(
          resizeToAvoidBottomInset: false, body: ListEmpty(isDarkMode));
    } else {
      /// Returns the ListView  by building the Future list
      /// of houses first and then building the listview cards
      /// containing the API data stored previously
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

                final startCoordinate = Location(
                    house.longitude.toDouble(), house.latitude.toDouble());

                final endCoordinate = Location(long, lat);

                final haversineDistance = HaversineDistance();

                final distance = haversineDistance
                    .haversine(startCoordinate, endCoordinate, Unit.KM)
                    .toStringAsFixed(2);

                return ElasticInLeft(
                    delay: Duration(milliseconds: index * 100),
                    child: Card(
                      elevation: 4,
                      child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                          child: ListTile(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DetailPage(isDarkMode,
                                        house: items[index],
                                        distance: distance))),
                            leading: AspectRatio(
                                aspectRatio: 1,
                                child: Container(
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                  fit: BoxFit.cover,
                                  alignment: FractionalOffset.topCenter,
                                  image: NetworkImage(
                                      'https://intern.d-tt.nl${house.image}',
                                      headers: {
                                        "Access-Key":
                                            "98bww4ezuzfePCYFxJEWyszbUXc7dxRx"
                                      }),
                                )))),
                            title: Column(
                              children: [
                                Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                        '£${house.price}'.replaceAll(
                                            RegExp(r'\B(?=(\d{3})+(?!\d))'),
                                            ','),
                                        style: TextStyle(
                                            color: isDarkMode
                                                ? Color(0xffe65541)
                                                : Colors.black,
                                            fontFamily: "Gotham SSm-Bold"))),
                                Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text("${house.zip} ${house.city}",
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: isDarkMode
                                                ? Color(0xffebebeb)
                                                : Color(0x66000000),
                                            fontFamily: "Gotham SSm-Book")))
                              ],
                            ),
                            subtitle: Padding(
                                padding: const EdgeInsets.only(top: 20),
                                child: Row(children: [
                                  const ImageIcon(
                                      AssetImage("assets/images/bed-2@2x.png"),
                                      size: 15),
                                  Text('  ${house.bedrooms}',
                                      style: TextStyle(
                                          fontSize: 10,
                                          color: isDarkMode
                                              ? Color(0xffebebeb)
                                              : Color(0x66000000),
                                          fontFamily: "Gotham SSm-Book")),
                                  const Spacer(),
                                  const ImageIcon(
                                      AssetImage("assets/images/shower@2x.png"),
                                      size: 15),
                                  Text('  ${house.bathrooms}',
                                      style: TextStyle(
                                          fontSize: 10,
                                          color: isDarkMode
                                              ? Color(0xffebebeb)
                                              : Color(0x66000000),
                                          fontFamily: "Gotham SSm-Book")),
                                  const Spacer(),
                                  const ImageIcon(
                                      AssetImage(
                                          "assets/images/square-measument@2x.png"),
                                      size: 15),
                                  Text('  ${house.size}',
                                      style: TextStyle(
                                          fontSize: 10,
                                          color: isDarkMode
                                              ? Color(0xffebebeb)
                                              : Color(0x66000000),
                                          fontFamily: "Gotham SSm-Book")),
                                  const Spacer(),
                                  const ImageIcon(
                                      AssetImage("assets/images/pin@2x.png"),
                                      size: 15),
                                  Text('  $distance km',
                                      style: TextStyle(
                                          fontSize: 10,
                                          color: isDarkMode
                                              ? Color(0xffebebeb)
                                              : Color(0x66000000),
                                          fontFamily: "Gotham SSm-Book"))
                                ])),
                            // trailing: const IconButton(
                            //     onPressed: null,
                            //     icon: Icon(
                            //       Icons.favorite,
                            //       color: Colors.amberAccent,
                            //     )),
                          )),
                    ));
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
