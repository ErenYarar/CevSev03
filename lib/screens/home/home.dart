import 'package:cscevsev/screens/home/Etkinlik/etkinlikAyrintiSayfasi.dart';
import 'package:cscevsev/screens/home/Profil/TabBarDemo.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Home extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  Completer<GoogleMapController> _controller = Completer();

  @override
  void initState() {
    super.initState();
  }
  double zoomVal=5.0;
  static const LatLng _center = const LatLng(41.015137, 28.979530);
  final Set<Marker> _markers = {};
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




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _buildGoogleMap(context),
          _buildContainer(),
        ],
      ),
    );
  }

  Widget _buildContainer() {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20.0),
        height: 150.0,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            SizedBox(width: 10.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _boxes(
                  "https://www.sakaryahalk.com/resimler/haberler/d_fbd118f97984d254a087b0fdb77d613c.jpg",
                  41.1623, 29.0474,"Sarıyer"),
            ),
            SizedBox(width: 10.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _boxes(
                  "https://www.mus.gen.tr/resimler/haber/piknik_alanlari_copten_gecilmiyor_h8696.jpg",
                  41.0422, 29.0067,"Beşiktaş"),
            ),
            SizedBox(width: 10.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _boxes(
                  "https://lh3.googleusercontent.com/proxy/9nYjhjpgBxYK919TcL4esMi4O2ITaZwl26CcFUtdx060idjhY-1BnKeblarB2d26AxroeftWbN3FUZtB7rdtFR5gz0Tx_LMv498uiBVnQs6s1aXh",
                  40.9819, 29.0576,"Kadıköy"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _boxes(String _image, double lat,double long,String restaurantName) {
    return  GestureDetector(
      onTap: () {
        _gotoLocation(lat,long);
      },
      child:Container(
        child: new FittedBox(
          child: Material(
              color: Colors.white,
              elevation: 14.0,
              borderRadius: BorderRadius.circular(24.0),
              shadowColor: Color(0x802196F3),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    width: 180,
                    height: 200,
                    child: ClipRRect(
                      borderRadius: new BorderRadius.circular(24.0),
                      child: Image(
                        fit: BoxFit.fill,
                        image: NetworkImage(_image),
                      ),
                    ),),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: myDetailsContainer1(restaurantName),
                    ),
                  ),

                ],)
          ),
        ),
      ),
    );
  }

  Widget myDetailsContainer1(String restaurantName) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Container(
              child: Text(restaurantName,
                style: TextStyle(
                    color: Color(0xff6200ee),
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold),
              )),
        ),
        SizedBox(height:5.0),

        Container(
            child: Text(
              "İstanbul  Acil!",
              style: TextStyle(
                color: Colors.black54,
                fontSize: 18.0,
              ),
            )),
        SizedBox(height:5.0),
        Container(
            child: Text(
              "Fotoğraf \u00B7 17.04.2020\n Tarihinde çekildi.",
              style: TextStyle(
                  color: Colors.black54,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold),
            )),
      ],
    );
  }

  Widget _buildGoogleMap(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: GoogleMap(
            mapType: _currentMapType,
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: _center,
              zoom: 11.0,
            ),
            markers: _markers,
            onCameraMove: _onCameraMove,
          ),
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
        Padding(
          padding: EdgeInsets.all(16.0),
          child: Align(
            alignment: Alignment.topLeft,
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 20.0,
                ),
                FloatingActionButton(
                  heroTag: null,
                  onPressed: () { Navigator.push(context, MaterialPageRoute(builder: (context) => EtkinlikAyrinti()));},
                  child: Icon(
                    Icons.camera,
                    size: 35.0,
                    color: Colors.green,
                  ),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16.0))),
                  backgroundColor: Colors.white54,
                ),
                SizedBox(
                  height: 16.0,
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
                    color: Colors.green,
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16.0))),
                  backgroundColor: Colors.white54,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _gotoLocation(double lat,double long) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(lat, long), zoom: 15,tilt: 50.0,
      bearing: 45.0,)));
  }
}

Marker sariyer = Marker(
  markerId: MarkerId('Sariyer'),
  position: LatLng(41.1623, 29.0474),
  infoWindow: InfoWindow(title: 'Sariyer'),
  icon: BitmapDescriptor.fromAsset('images/mapMarkerGif.gif'),
);

Marker besiktas = Marker(
  markerId: MarkerId('Besiktas'),
  position: LatLng(41.0422, 29.0067),
  infoWindow: InfoWindow(title: 'Besiktas'),
  icon: BitmapDescriptor.fromAsset('images/mapMarkerGif.gif'),
);
Marker kadikoy = Marker(
  markerId: MarkerId('Kadikoy'),
  position: LatLng(40.9819, 29.0576),
  infoWindow: InfoWindow(title: 'Kadikoy'),
  icon: BitmapDescriptor.fromAsset('images/mapMarkerGif.gif'),
);