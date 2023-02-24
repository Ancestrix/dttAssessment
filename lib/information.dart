import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

/// Store the url
final Uri _url = Uri.parse('https://www.d-tt.nl/');

/// Define the About page widget
class Information extends StatelessWidget {
  const Information({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 25),
                child: Text(
                  "ABOUT",
                  style: TextStyle(
                      color: const Color(0xCC000000),
                      fontSize: MediaQuery.of(context).size.height * 0.03,
                      height: 1,
                      fontFamily: "Gotham SSm-Bold"),
                ),
              ),
            ),
            Text(
                "Lorem ipsum dolor sit amet, consectetur adipiscing"
                "elit, sed do eiusmod tempor incididunt ut labore et"
                "dolore magna aliqua. Ut enim ad minim veniam,"
                "quis nostrud exercitation ullamco laboris nisi ut"
                "aliquip ex ea commodo consequat. Duis aute irure"
                "dolor in reprehenderit in voluptate velit esse cillum"
                "dolore eu fugiat nulla pariatur. Excepteur sint"
                "occaecat cupidatat non proident, sunt in culpa qui"
                "officia deserunt mollit anim id est laborum. Lorem"
                "ipsum dolor sit amet, consectetur adipiscing elit,"
                "sed do eiusmod tempor incididunt ut labore et"
                "dolore magna aliqua. Ut enim ad minim veniam,"
                "quis nostrud exercitation ullamco laboris nisi ut"
                "aliquip ex ea commodo consequat. Duis aute irure"
                "dolor in reprehenderit in voluptate velit esse cillum"
                "dolore eu fugiat nulla pariatur. Excepteur sint"
                "occaecat cupidatat non proident.",
                style: TextStyle(
                    color: const Color(0x66000000),
                    fontSize: MediaQuery.of(context).size.height * 0.018,
                    height: 1.2,
                    fontFamily: "Gotham SSm-Book")),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 25, 0, 25),
                child: Text(
                  "Design and Development",
                  style: TextStyle(
                      color: const Color(0xCC000000),
                      fontSize: MediaQuery.of(context).size.height * 0.03,
                      height: 1,
                      fontFamily: "Gotham SSm-Bold"),
                ),
              ),
            ),
            Row(
              children: [
                const Image(
                  image: AssetImage("assets/images/dtt_logo.png"),
                  width: 120,
                ),
                Padding(
                    padding: const EdgeInsets.fromLTRB(25, 0, 0, 0),
                    child: Column(
                      children: [
                        const Text(
                          "by DTT",
                          style: TextStyle(fontFamily: "Gotham SSm-Book"),
                        ),
                        Align(
                            alignment: Alignment.centerLeft,

                            ///  Url clickable text
                            child: RichText(
                                text: TextSpan(
                                    text: "d-tt.nl",
                                    style: const TextStyle(
                                      color: Colors.blue,
                                      decoration: TextDecoration.underline,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () async {
                                        if (!await launchUrl(_url)) {
                                          /// Throw exception if it cannot
                                          /// launch the url
                                          throw 'Could not launch $_url';
                                        }
                                      }))),
                      ],
                    )),
              ],
            )
          ],
        ));
  }
}
