import 'dart:io';
import 'package:cscevsev/screens/home/Profil/TabBarDemo.dart';
import 'package:cscevsev/screens/home/Profil/profile.dart';
import 'package:cscevsev/screens/home/camera.dart';
import 'package:cscevsev/services/auth.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'Etkinlik/etkinlikAyrintiSayfasi.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  Home() : super();

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  //File imageFile;
  //final AuthService _auth = AuthService();

  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;

  //////////////////

  Completer<GoogleMapController> _controller = Completer();
  static const LatLng _center = const LatLng(41.015137, 28.979530);
  final Set<Marker> _markers = {};
  //final Map<String, Marker> _markers = {};
  LatLng _lastMapPosition = _center;
  MapType _currentMapType = MapType.normal;

  static final CameraPosition _position1 = CameraPosition(
    bearing: 192.833,
    target: LatLng(41.015137, 28.979530),
    tilt: 59.440,
    zoom: 11.0,
  );

  Future<void> _goToPosition1() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_position1));
  }

  _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  _onCameraMove(CameraPosition position) {
    _lastMapPosition = position.target;
  }

  _onMapTypeButtonPressed() {
    setState(() {
      _currentMapType = _currentMapType == MapType.normal
          ? MapType.satellite
          : MapType.normal;
    });
  }

  _onAddMarkerButtonPressed() async {
    setState(() {
      _markers.add(Marker(
        markerId: MarkerId(_lastMapPosition.toString()),
        position: _lastMapPosition,
        infoWindow: InfoWindow(
          title: "Kirli alan",
          snippet: "Temizlenmesi gereken yer",
        ),
        //icon: BitmapDescriptor.defaultMarker,
        icon: BitmapDescriptor.fromAsset('images/mapMarkerGif.gif'),
      ));
    });
  }



  Widget button(Function function, IconData icon) {
    return FloatingActionButton(
      heroTag: null,
      onPressed: function,
      materialTapTargetSize: MaterialTapTargetSize.padded,
      backgroundColor: Colors.white24,
      //foregroundColor: Colors.white,
      child: Icon(icon, size: 36.0),
    );
  }

  /////////////////////

  int currentTab = 0; // to keep track of active tab index
  final List<Widget> screens = [
    Home(),
    Camera(),
    TabBarDemo(),
  ]; // to store nested tabs
  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = Home();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: Colors.blueGrey[100],
        body: Stack(
          children: <Widget>[
            GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: _center,
                zoom: 11.0,
              ),
              mapType: _currentMapType,
              markers: _markers,
              onCameraMove: _onCameraMove,
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Align(
                alignment: Alignment.topRight,
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 16.0,
                    ),
                    button(_onMapTypeButtonPressed, Icons.public),
                    SizedBox(
                      height: 16.0,
                    ),
                    button(_onAddMarkerButtonPressed, Icons.add_location),
                    SizedBox(
                      height: 16.0,
                    ),
                    button(_goToPosition1, Icons.location_searching),
                  ],
                ),
              ),
            ),

          ],
        ),

///////////////////////
        /*
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white,
          foregroundColor: Colors.grey,
          splashColor: Colors.green[500],
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EtkinlikAyrinti(),
              ),
            );
          },
          tooltip: 'Pick Image',
          child: Icon(
            Icons.camera_alt,
            size: 35.0,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBar(
          shape: CircularNotchedRectangle(),
          notchMargin: 8,
          child: Container(
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    MaterialButton(
                      minWidth: 40,
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Home()));
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.map,
                            size: 40.0,
                            color: currentTab == 0
                                ? Colors.green[500]
                                : Colors.grey,
                          ),
                          /*Text(
                            'Map',
                            style: TextStyle(
                              color:
                                  currentTab == 0 ? Colors.green[500] : Colors.grey,
                            ),
                          ),*/
                        ],
                      ),
                    ),
                  ],
                ),

                // Right Tab bar icons

                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    MaterialButton(
                      minWidth: 40,
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TabBarDemo()));
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.perm_identity,
                            size: 40.0,
                            color: currentTab == 2
                                ? Colors.green[500]
                                : Colors.grey,
                          ),
                          /*Text(
                            'Profile',
                            style: TextStyle(
                              color:
                                  currentTab == 2 ? Colors.green[500] : Colors.grey,
                            ),
                          ),*/
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        */
        /*
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white,
          foregroundColor: Colors.grey,
          splashColor: Colors.green[500],
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EtkinlikAyrinti(),
              ),
            );
          },
          child: Icon(
            Icons.camera_alt,
            size: 35.0,
          ),
        ),

        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EtkinlikAyrinti(),
              ),
            );
          },
          label: Text(
              'Camera',
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
          icon: Icon(
              Icons.camera,
              size: 30.0,
          ),
          backgroundColor: Colors.pink,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          */
/*
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.pink,
          child: Icon(
            Icons.camera,
            size: 35.0,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EtkinlikAyrinti(),
              ),
            );
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
*/
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(left: 30.0,bottom:0.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              FloatingActionButton(
                heroTag: null,
                onPressed: () { Navigator.push(context, MaterialPageRoute(builder: (context) => EtkinlikAyrinti()));},
                child: Icon(
                  Icons.camera,
                  size: 35.0,
                ),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16.0))),
                backgroundColor: Colors.pinkAccent,
              ),
              FloatingActionButton(
                heroTag: null,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TabBarDemo(),
                    ),
                  );
                },
                child: Icon(
                  Icons.person,
                  size: 35.0,
                ),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16.0))),
                backgroundColor: Colors.blueAccent,
              )
            ],
          ),
        ),
      ),
    );
  }
}
