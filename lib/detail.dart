import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:dtt_assessment/House.kts';
import 'package:animate_do/animate_do.dart';

class DetailPage extends StatefulWidget {
  late bool isDarkMode;

  final House house;
  final String distance;

  DetailPage(bool this.isDarkMode,{super.key, required this.house, required this.distance});

  @override
  State<StatefulWidget> createState() => _DetailPage();
}

class _DetailPage extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    /// Declaring and initializing variables and function for google map
    late GoogleMapController mapController;

    final LatLng center = LatLng(
        widget.house.latitude.toDouble(), widget.house.longitude.toDouble());

    void onMapCreated(GoogleMapController controller) {
      mapController = controller;
    }

    Set<Marker> createMarker() {
      return {
        Marker(
            markerId: const MarkerId("marker_1"),
            position: center,
            infoWindow: const InfoWindow(title: "House's location")),
      };
    }

    return MaterialApp(home: Scaffold(
      resizeToAvoidBottomInset: false,
      body: BounceInDown(
        child: Stack(children: [

          /// Positioning the top content containing the house's image
          /// in background
          Positioned.fill(
              top: 0,
              left: 0,
              right: 0,
              bottom: 0,
              child: Stack(
                children: <Widget>[
                  Container(
                    height: MediaQuery
                        .of(context)
                        .size
                        .height * 0.25,
                    padding: const EdgeInsets.all(40.0),
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(
                                'https://intern.d-tt.nl${widget.house.image}',
                                headers: {
                                  "Access-Key":
                                  "98bww4ezuzfePCYFxJEWyszbUXc7dxRx"
                                }),
                            fit: BoxFit.fill,
                            alignment: Alignment.topCenter)),
                    child: const Center(
                      child: null,
                    ),
                  ),
                  Positioned(
                    left: 8.0,
                    top: 60.0,
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(Icons.arrow_back,
                          size: 40,
                          color: Colors.white,
                          shadows: [
                            Shadow(color: Colors.black, blurRadius: 15)
                          ]),
                    ),
                  )
                ],
              )),

          /// Implementing and positioning the bottom content containing
          /// the house information
          Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                decoration: BoxDecoration(
                    color: widget.isDarkMode
                        ? Theme.of(context).cardColor
                        : Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
                height: MediaQuery
                    .of(context)
                    .size
                    .height * 0.8,
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                // color: Theme.of(context).primaryColor,
                child: Center(
                  child: Container(
                      padding: EdgeInsets.fromLTRB(
                          25, 30, 25, MediaQuery
                          .of(context)
                          .size
                          .height * 0.3),
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: [
                              FadeInDownBig(from: MediaQuery
                                  .of(context)
                                  .size
                                  .width * 0.2,
                                  child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                          '£${widget.house.price}'.replaceAll(
                                              RegExp(r'\B(?=(\d{3})+(?!\d))'),
                                              ','),
                                          style:  TextStyle(
                                              fontSize: 20,color: widget.isDarkMode
                                              ? Color(0xffe65541)
                                              : Color(0xcc000000),
                                              fontFamily: "Gotham SSm-Bold")))),
                              const Spacer(flex: 10),
                              FadeInDownBig(delay: Duration(seconds: 1),
                                  duration: Duration(milliseconds:500),
                                  from: MediaQuery
                                      .of(context)
                                      .size
                                      .width * 0.2,
                                  child:  ImageIcon(
                                      AssetImage("assets/images/bed-2@2x.png"),
                                      size: 15,color: widget.isDarkMode
                                      ? Color(0xffebebeb)
                                      : Color(0x66000000),)),
                              FadeInDownBig(delay: Duration(seconds: 1,milliseconds: 100),
                                  duration: Duration(milliseconds:500),from: MediaQuery
                                      .of(context)
                                      .size
                                      .width * 0.2,
                                  child: Text('  ${widget.house.bedrooms}',
                                      style:  TextStyle(
                                          fontSize: 10,
                                          color: widget.isDarkMode
                                              ? Color(0xffebebeb)
                                              : Color(0x66000000),
                                          fontFamily: "Gotham SSm-Book"))),
                              const Spacer(),
                              FadeInDownBig(delay: Duration(seconds: 1,milliseconds: 200),
                                  duration: Duration(milliseconds:500),from: MediaQuery
                                      .of(context)
                                      .size
                                      .width * 0.2,
                                  child:  ImageIcon(
                                      AssetImage("assets/images/shower@2x.png"),color: widget.isDarkMode
                                      ? Color(0xffebebeb)
                                      : Color(0x66000000),
                                      size: 15)),
                              FadeInDownBig(delay: Duration(seconds: 1,milliseconds: 300),
                                  duration: Duration(milliseconds:500),from: MediaQuery
                                      .of(context)
                                      .size
                                      .width * 0.2,
                                  child: Text('  ${widget.house.bathrooms}',
                                      style:  TextStyle(
                                          fontSize: 10,
                                          color: widget.isDarkMode
                                          ? Color(0xffebebeb)
                                          : Color(0x66000000),
                                          fontFamily: "Gotham SSm-Book"))),
                              const Spacer(),
                              FadeInDownBig(delay: Duration(seconds: 1,milliseconds: 400),
                                  duration: Duration(milliseconds:500),from: MediaQuery
                                      .of(context)
                                      .size
                                      .width * 0.2,
                                  child:  ImageIcon(
                                      AssetImage(
                                          "assets/images/square-measument@2x.png"),color: widget.isDarkMode
                                      ? Color(0xffebebeb)
                                      : Color(0x66000000),
                                      size: 15)),
                              FadeInDownBig(delay: Duration(seconds: 1,milliseconds: 500),
                                  duration: Duration(milliseconds:500),from: MediaQuery
                                      .of(context)
                                      .size
                                      .width * 0.2,
                                  child: Text('  ${widget.house.size}',
                                      style:  TextStyle(
                                          fontSize: 10,
                                          color: widget.isDarkMode
                                              ? Color(0xffebebeb)
                                              : Color(0x66000000),
                                          fontFamily: "Gotham SSm-Book"))),
                              const Spacer(),
                              FadeInDownBig(delay: Duration(seconds: 1,milliseconds: 600),
                                  duration: Duration(milliseconds:500),
                                  from: MediaQuery
                                      .of(context)
                                      .size
                                      .width * 0.2,
                                  child:  ImageIcon(
                                      AssetImage("assets/images/pin@2x.png"),color: widget.isDarkMode
                                      ? Color(0xffebebeb)
                                      : Color(0x66000000),
                                      size: 15)),
                              FadeInDownBig(delay: Duration(seconds: 1,milliseconds: 700),
                                  duration: Duration(milliseconds:500),from: MediaQuery
                                      .of(context)
                                      .size
                                      .width * 0.2,
                                  child: Text('  ${widget.distance} km',
                                      style:  TextStyle(
                                          fontSize: 10,
                                          color: widget.isDarkMode
                                              ? Color(0xffebebeb)
                                              : Color(0x66000000),
                                          fontFamily: "Gotham SSm-Book")))
                            ],
                          ),
                          const Spacer(),
                          FadeInLeftBig(
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Description",
                                    style: TextStyle(
                                        color: widget.isDarkMode
                                            ? Color(0xffe65541)
                                            : Color(0xcc000000),
                                        fontSize:
                                        MediaQuery
                                            .of(context)
                                            .size
                                            .width *
                                            0.045,
                                        height: 1,
                                        fontFamily: "Gotham SSm-Bold"),
                                  ))),
                          const Spacer(),FadeInLeftBig(delay: Duration(milliseconds: 700),child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
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
                                    color: widget.isDarkMode
                                        ? Color(0xffebebeb)
                                        : Color(0x66000000),
                                    fontSize:
                                    MediaQuery
                                        .of(context)
                                        .size
                                        .width *
                                        0.028,
                                    height: 1.2,
                                    fontFamily: "Gotham SSm-Book")),
                          ))
                          ,
                          const Spacer(),FadeInLeftBig(child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Location",
                                style: TextStyle(
                                    color: widget.isDarkMode
                                        ? Color(0xffe65541)
                                        : Color(0xcc000000),
                                    fontSize:
                                    MediaQuery
                                        .of(context)
                                        .size
                                        .width *
                                        0.045,
                                    height: 1,
                                    fontFamily: "Gotham SSm-Bold"),
                              )))
                          ,
                          Spacer(),
                        ],
                      )),
                ),
              )),

          /// Positioning the map widget to fill with his belong size
          Positioned(
              top: MediaQuery
                  .of(context)
                  .size
                  .height * 0.7,
              left: MediaQuery
                  .of(context)
                  .size
                  .width * 0.1,
              right: MediaQuery
                  .of(context)
                  .size
                  .width * 0.1,
              bottom: MediaQuery
                  .of(context)
                  .size
                  .width * 0.1,
              child: FadeInLeftBig(delay: Duration(milliseconds: 700),child: GoogleMap(
                myLocationButtonEnabled: false,
                myLocationEnabled: true,
                onMapCreated: onMapCreated,
                initialCameraPosition: CameraPosition(
                  target: center,
                  zoom: 11.0,
                ),
                markers: createMarker(),
              ),))
        ]),
      ),
    ));
  }
}
