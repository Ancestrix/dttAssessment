import 'package:flutter/material.dart';

/// Defining the Empty result widget used in the ListViewWidget
class ListEmpty extends StatelessWidget {
  late bool isDarkMode;
  ListEmpty(this.isDarkMode,{super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Expanded(
            child: Column(children:  [
          Spacer(),
          Image(
            image: AssetImage(
              "assets/images/undraw_empty_xct9-2.png",
            ),
          ),
          Spacer(),
          Text(
            "No result found !\nPerhaps try another search ?",
            textAlign: TextAlign.center,
            style: TextStyle(color: isDarkMode
                ? Color(0xffebebeb)
                : Color(0x33000000)),
          ),
          Spacer(),
        ])),
      ),
    );
  }
}
