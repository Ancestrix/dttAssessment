import 'dart:io';

import 'package:dtt_assessment/information.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'dart:async';
import 'dart:convert';

import 'package:dtt_assessment/overview.dart';
import 'package:http/http.dart' as http;

void main() {
  // Ensure that the splash screen is held during the intialization
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  // Initialize
  runApp(const MyApp());
  // Remove the splash screen after the app init
  FlutterNativeSplash.remove();
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    Overview(),
    Information()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DTT REAL ESTATE',
      theme: ThemeData(
          appBarTheme: const AppBarTheme(
              color: Colors.transparent, shadowColor: Colors.transparent)),
      home: Scaffold(
        appBar: AppBar(
          title: const Align(
              alignment: Alignment.centerLeft,
              child: Text('DTT REAL ESTATE',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      height: 2,
                      fontFamily: "Gotham SSm-Bold"))),
        ),
        body: SafeArea(
            child: Column(children: [
          Expanded(
            child: Center(child: _widgetOptions.elementAt(_selectedIndex)),
          ),
        ])),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home), label: ""),
            BottomNavigationBarItem(icon: Icon(Icons.info), label: "")
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.black,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
