import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:dtt_assessment/House.kts';

class DetailPage extends StatefulWidget {
  final House house;
  final String distance;

  const DetailPage({super.key, required this.house, required this.distance});

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

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(children: [
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
                  height: MediaQuery.of(context).size.height * 0.25,
                  padding: const EdgeInsets.all(40.0),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(
                              'https://intern.d-tt.nl${widget.house.image}',
                              headers: {
                                "Access-Key": "98bww4ezuzfePCYFxJEWyszbUXc7dxRx"
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
                        shadows: [Shadow(color: Colors.black, blurRadius: 15)]),
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
                  color: Colors.white,
                  border: Border.all(),
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              height: MediaQuery.of(context).size.height * 0.8,
              width: MediaQuery.of(context).size.width,
              // color: Theme.of(context).primaryColor,
              child: Center(
                child: Container(
                    padding: const EdgeInsets.fromLTRB(25, 40, 25, 0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Row(
                          children: [
                            Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                    '£${widget.house.price}'.replaceAll(
                                        RegExp(r'\B(?=(\d{3})+(?!\d))'), ','),
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontFamily: "Gotham SSm-Bold"))),
                            const Spacer(flex: 10),
                            const ImageIcon(
                                AssetImage("assets/images/bed-2@2x.png"),
                                size: 15),
                            Text('  ${widget.house.bedrooms}',
                                style: const TextStyle(
                                    fontSize: 10,
                                    color: Color(0x66000000),
                                    fontFamily: "Gotham SSm-Book")),
                            const Spacer(),
                            const ImageIcon(
                                AssetImage("assets/images/shower@2x.png"),
                                size: 15),
                            Text('  ${widget.house.bathrooms}',
                                style: const TextStyle(
                                    fontSize: 10,
                                    color: Color(0x66000000),
                                    fontFamily: "Gotham SSm-Book")),
                            const Spacer(),
                            const ImageIcon(
                                AssetImage(
                                    "assets/images/square-measument@2x.png"),
                                size: 15),
                            Text('  ${widget.house.size}',
                                style: const TextStyle(
                                    fontSize: 10,
                                    color: Color(0x66000000),
                                    fontFamily: "Gotham SSm-Book")),
                            const Spacer(),
                            const ImageIcon(
                                AssetImage("assets/images/pin@2x.png"),
                                size: 15),
                            Text('  ${widget.distance} km',
                                style: const TextStyle(
                                    fontSize: 10,
                                    color: Color(0x66000000),
                                    fontFamily: "Gotham SSm-Book"))
                          ],
                        ),
                        const Spacer(),
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Description",
                              style: TextStyle(
                                  color: const Color(0xCC000000),
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.045,
                                  height: 1,
                                  fontFamily: "Gotham SSm-Bold"),
                            )),
                        const Spacer(),
                        Align(
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
                                  color: const Color(0x66000000),
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.03,
                                  height: 1.2,
                                  fontFamily: "Gotham SSm-Book")),
                        ),
                        const Spacer(),
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Location",
                              style: TextStyle(
                                  color: const Color(0xCC000000),
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.045,
                                  height: 1,
                                  fontFamily: "Gotham SSm-Bold"),
                            )),
                        const Spacer(flex: 30),
                      ],
                    )),
              ),
            )),

        /// Positioning the map widget to fill with his belong size
        Positioned(
            top: MediaQuery.of(context).size.width * 1.35,
            left: MediaQuery.of(context).size.width * 0.1,
            right: MediaQuery.of(context).size.width * 0.1,
            bottom: MediaQuery.of(context).size.width * 0.1,
            child: GoogleMap(
              myLocationEnabled: true,
              onMapCreated: onMapCreated,
              initialCameraPosition: CameraPosition(
                target: center,
                zoom: 11.0,
              ),
              markers: createMarker(),
            ))
      ]),
    );
  }
}
