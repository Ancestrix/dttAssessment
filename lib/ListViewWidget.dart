import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dtt_assessment/NotFound.dart';
import 'package:dtt_assessment/HousesClass.kts';

///
class ListViewWidget extends StatelessWidget {
  /// Giving the widget the needed parameters to build the listview
  late Future<List<Houses>> futureHouses;
  late List<Houses> items;

  ListViewWidget({super.key, required this.futureHouses, required this.items});

  @override
  Widget build(BuildContext context) {
    /// Returns the empty search result if no houses in Items
    if (items.isEmpty) {
      return Scaffold(resizeToAvoidBottomInset: false, body: ListEmpty());
    } else {
      /// Returns the ListView  by building the Future list
      /// of houses first and then building the listview cards
      /// containing the JSON data stored previously
      return FutureBuilder<List<Houses>>(
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
                final house = items[index];
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
                    title: Text('${house.price} €'),
                    subtitle: Text("${house.zip} ${house.city}"),
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
