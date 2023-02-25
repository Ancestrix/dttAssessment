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

// Define the theme data for the app
  final darkTheme = ThemeData(
    brightness: Brightness.dark,
    appBarTheme: const AppBarTheme(
      color: Colors.transparent,
      shadowColor: Colors.transparent,
    ),
  );

  final lightTheme = ThemeData(
    textTheme: TextTheme(
        headline1: TextStyle(
            fontSize: 12,
            color: Color(0x66000000),
            fontFamily: "Gotham SSm-Book")),
    brightness: Brightness.light,
    appBarTheme: const AppBarTheme(
      color: Colors.transparent,
      shadowColor: Colors.transparent,
    ),
  );
  bool isDarkMode = false;

  /// Declaring the index to know which page is selected
  int _selectedIndex = 0;

  Color color = const Color(0xCC000000);





  // Toggle the theme mode between light and dark
  void _toggleThemeMode() {
    setState(() {
      isDarkMode = !isDarkMode;
    });
  }


  /// Change the page when a navigation bar items is selected
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    if(_selectedIndex==0){
      color = isDarkMode ? Color(0xffe65541) : Colors.black;
    }else{
      color = Colors.transparent;
    }
    /// Declaring the widget that is shown by the navigation bar
    List<Widget> _widgetOptions = <Widget>[
      Overview(isDarkMode),
      Information(isDarkMode)
    ];
    return MaterialApp(
      title: 'DTT REAL ESTATE',
      theme: isDarkMode ? darkTheme : lightTheme,
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Align(
            alignment: Alignment.centerLeft,

            /// Head Title
            child: Text(
              'DTT REAL ESTATE',
              style: TextStyle(
                color: color,
                fontSize: 20,
                height: 2,
                fontFamily: 'Gotham SSm-Bold',
              ),
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(
                isDarkMode ? Icons.wb_sunny : Icons.nightlight_round,
                color: isDarkMode ? Colors.white : Colors.black,
              ),
              onPressed: _toggleThemeMode,
            ),
          ],
        ),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                /// Select the right widget according to the Navigation bar
                child: Center(
                  child: _widgetOptions.elementAt(_selectedIndex),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home), label: ""),
            BottomNavigationBarItem(icon: Icon(Icons.info), label: "")
          ],
          currentIndex: _selectedIndex,
          unselectedItemColor: isDarkMode
              ? Color(0xffebebeb)
              : Color(0x33000000),
          selectedItemColor: isDarkMode ? Color(0xffe65541) : Colors.black,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
