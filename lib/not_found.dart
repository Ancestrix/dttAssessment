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
            child: Column(children:  [
          const Spacer(),
          const Image(
            image: AssetImage(
              "assets/images/undraw_empty_xct9-2.png",
            ),
          ),
          const Spacer(),
          Text(
            "No result found !\nPerhaps try another search ?",
            textAlign: TextAlign.center,
            style: TextStyle(color: isDarkMode
                ? const Color(0xffebebeb)
                : const Color(0x33000000)),
          ),
          const Spacer(),
        ]),
      ),
    );
  }
}
