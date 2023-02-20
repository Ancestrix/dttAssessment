
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dtt_assessment/HousesClass.kts';

class ListViewWidget extends StatelessWidget {
  late Future<List<Houses>> futureHouses;
  late List<Houses> items;
  ListViewWidget({super.key, required this.futureHouses, required this.items});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Houses>>(
      future: futureHouses,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final houses = snapshot.data!;
          if(items.isEmpty){items=houses;}
          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              final house = items[index];
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
                  title: Text(house.city),
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
    );
  }
}
