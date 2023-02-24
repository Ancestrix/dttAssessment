import 'package:dtt_assessment/information.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:dtt_assessment/overview.dart';

void main() {
  /// Ensure that the splash screen is held during the intialization
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  /// Initialize
  runApp(const MyApp());

  /// Remove the splash screen after the app init
  FlutterNativeSplash.remove();
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  /// Declaring the index to know which page is selected
  int _selectedIndex = 0;

  Color color = const Color(0xCC000000);

  /// Declaring the widget that is shown by the navigation bar
  static const List<Widget> _widgetOptions = <Widget>[
    Overview(),
    Information()
  ];

  /// Change the page when a navigation bar items is selected
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_selectedIndex == 1) {
      color = Colors.transparent;
    } else {
      color = const Color(0xCC000000);
    }

    return MaterialApp(
      title: 'DTT REAL ESTATE',
      theme: ThemeData(
          appBarTheme: const AppBarTheme(
              color: Colors.transparent, shadowColor: Colors.transparent)),
      home: Scaffold(
        appBar: AppBar(
          title: Align(
              alignment: Alignment.centerLeft,

              /// Head Title
              child: Text('DTT REAL ESTATE',
                  style: TextStyle(
                      color: color,
                      fontSize: 20,
                      height: 2,
                      fontFamily: "Gotham SSm-Bold"))),
        ),
        body: SafeArea(
            child: Column(children: [
          Expanded(
            /// Select the right widget according to the Navigation bar
            child: Center(child: _widgetOptions.elementAt(_selectedIndex)),
          ),
        ])),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home), label: ""),
            BottomNavigationBarItem(icon: Icon(Icons.info), label: "")
          ],
          currentIndex: _selectedIndex,
          unselectedItemColor: const Color(0x33000000),
          selectedItemColor: Colors.black,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
