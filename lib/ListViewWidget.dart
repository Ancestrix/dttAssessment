import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dtt_assessment/HousesClass.kts';

class ListViewWidget extends StatelessWidget {
  late Future<List<Houses>> futureHouses;
  late List<Houses> items;

  ListViewWidget({super.key, required this.futureHouses, required this.items});

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return ListEmpty();
    } else {
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

class ListEmpty extends StatelessWidget {
  ListEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Expanded(child:Column(children: const [
        Spacer(),
        Image(
            image: AssetImage("assets/images/undraw_empty_xct9-2.png"),
            width: 250),
        Spacer(),
        Text(
          "No result found !\nPerhaps try another search ?",
          textAlign: TextAlign.center,
          style: TextStyle(color: Color(0x33000000)),
        ),
        Spacer(),
      ])),
    );
  }
}
