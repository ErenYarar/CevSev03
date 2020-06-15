import 'dart:io';
import 'package:cscevsev/screens/home/Etkinlik/etkinlikAyrintiSayfasi.dart';
import 'package:cscevsev/screens/home/Profil/TabBarDemo.dart';
import 'package:cscevsev/screens/home/Profil/settings.dart';
import 'package:cscevsev/screens/home/home.dart';
import 'package:cscevsev/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_share_me/flutter_share_me.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' show join;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "User Profile",
      debugShowCheckedModeBanner: false,
      home: Profil(),
    );
  }
}

class Profil extends StatelessWidget
{

  final AuthService _auth = AuthService();
  final String _fullName = "Alson Frost";
  final String _status = "Software Developer";
  final String _bio =
      "\"Hi, My name is Alson Frost. Let's solve the environmental pollution in Istanbul together. If you want to organize events together, you can contact me.\"";


  Widget _buildCoverImage(Size screenSize) {
    return Container(
      height: screenSize.height / 3.5,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('images/cop3.jpg'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildProfileImage() {
    return Center(
      child: Container(
        width: 140.0,
        height: 140.0,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/guest6.jpg'),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(80.0),
          border: Border.all(
            color: Colors.white,
            width: 10.0,
          ),
        ),
      ),
    );
  }

  Widget _buildFullName() {
    TextStyle _nameTextStyle = TextStyle(
      //fontFamily: 'Roboto',
      color: Colors.black,
      fontSize: 28.0,
      fontWeight: FontWeight.w700,
    );

    return Text(
      _fullName,
      style: _nameTextStyle,
    );
  }

  Widget _buildStatus(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 6.0),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Text(
        _status,
        style: TextStyle(
          //fontFamily: 'Spectral',
          color: Colors.black,
          fontSize: 20.0,
          fontWeight: FontWeight.w300,
        ),
      ),
    );
  }

  Widget _buildBio(BuildContext context) {
    TextStyle bioTextStyle = TextStyle(
      //fontFamily: 'Spectral',
      fontWeight: FontWeight.w400, //try changing weight to w500 if not thin
      fontStyle: FontStyle.italic,
      color: Color(0xFF799497),
      fontSize: 16.0,
    );

    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      padding: EdgeInsets.all(8.0),
      margin: EdgeInsets.all(15.0),
      child: Text(
        _bio,
        textAlign: TextAlign.center,
        style: bioTextStyle,
      ),
    );
  }

  Widget _buildSeparator(Size screenSize) {
    return Container(
      width: screenSize.width / 1.6,
      height: 2.0,
      color: Colors.black54,
      margin: EdgeInsets.only(top: 4.0),
    );
  }

  Widget _buildGetInTouch(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      padding: EdgeInsets.only(top: 8.0),
      child: Text(
        "Get in Touch with ${_fullName.split(" ")[0]}",
        style: TextStyle(
            //fontFamily: 'Roboto',
            fontSize: 16.0),
      ),
    );
  }


  @override
  Widget _buttons(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            children: [
              FloatingActionButton(
                heroTag: null,
                onPressed: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => Home()));
                },
                child: Icon(
                  Icons.map,
                  size: 35.0,
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16.0))),
                backgroundColor: Colors.pinkAccent,
              ),
              SizedBox(width: 267),
              FloatingActionButton(
                heroTag: null,
                onPressed: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => Settings()));
                },
                child: Icon(
                  Icons.settings,
                  size: 35.0,
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16.0))),
                backgroundColor: Colors.blue,
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _buildCoverImage(screenSize),
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(height: screenSize.height / 6.4),
                  _buildProfileImage(),
                  _buildFullName(),
                  _buildStatus(context),
                  _buildBio(context),
                  _buildSeparator(screenSize),
                  SizedBox(height: 10.0),
                  _buildGetInTouch(context),
                  SizedBox(height: 58.0),
                  _buttons(context),
                  //_footer(context),
                  //_buildButtons(context),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}


@override
Widget _footerMedia(BuildContext context) {
  return Scaffold(
    floatingActionButton: Padding(
      padding: const EdgeInsets.only(left: 30.0,bottom:0.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          FloatingActionButton(
            heroTag: null,
            onPressed: () { Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));},
            child: Icon(
              Icons.map,
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
                  builder: (context) => EtkinlikAyrinti(),
                ),
              );
            },
            child: Icon(
              Icons.camera,
              size: 35.0,
            ),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16.0))),
            backgroundColor: Colors.blueAccent,
          )
        ],
      ),
    ),
  );
}


/*
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

*/

/*
class Profil extends StatefulWidget {
  const Profil({Key key, @required this.user}) : super(key: key);

  final FirebaseUser user;

  @override
  _ProfilState createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {
  int currentTab = 1; // to keep track of active tab index
  final List<Widget> screens = [
    Home(),
    Camera(),
    Profil(),
  ]; // to store nested tabs
  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = Profil();

  File imageFile;

  Future getImage(bool isCamera) async {
    File image;
    if (isCamera) {
      image = await ImagePicker.pickImage(source: ImageSource.camera);
    }
    setState(() {
      imageFile = image;
    });
    //Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.blueGrey[100],
      body: Container(
        color: Colors.black,
        child: Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors:[
                    Colors.red,
                    Colors.blue,
                  ],
                ),
              ),
            ),
            SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(top: 50.0,left: 30.0,right: 30.0),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 5.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: 150.0,
                          height: 150.0,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                  color: Colors.white, width: 8.0)),
                          padding: EdgeInsets.all(8.0),
                          child: Image.asset("images/anonim2.png",
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      'Kullanıcı Adı',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22.0,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      "Professional",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment(1.4, -1.2),
              child: Container(
                width: 150.0,
                height: 150.0,
                padding: EdgeInsets.all(8.0),
                child: IconButton(
                  icon: Icon(Icons.settings),
                  color: Colors.black45,
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Settings()));
                  },
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 260.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        foregroundColor: Colors.grey,
        splashColor: Colors.green[500],
        onPressed: () {
          getImage(true);
        },
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
                          size: 35.0,
                          color: currentTab == 0 ? Colors.green[500] : Colors.grey,
                        ),
                        /*Text(
                          'Map',
                          style: TextStyle(
                            color: currentTab == 0 ? Colors.green[500] : Colors.grey,
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
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Profil()));
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.perm_identity,
                          size: 35.0,
                          color: currentTab == 1 ? Colors.green[500] : Colors.grey,
                        ),
                        /*Text(
                          'Profile',
                          style: TextStyle(
                            color: currentTab == 1 ? Colors.green[500] : Colors.grey,
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
    );
  }
}
*/
