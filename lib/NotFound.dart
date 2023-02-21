
import 'package:flutter/cupertino.dart';

/// Defining the Empty result widget used in the ListViewWidget
class ListEmpty extends StatelessWidget {
  ListEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Expanded(
          child: Column(children: const [
            Spacer(),
            Image(
                fit: BoxFit.cover,
                image: AssetImage(
                  "assets/images/undraw_empty_xct9-2.png",
                ),
                width: 200),
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