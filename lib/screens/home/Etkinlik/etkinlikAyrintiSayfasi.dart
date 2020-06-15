import 'dart:io';
import 'package:cscevsev/screens/home/Profil/TabBarDemo.dart';
import 'package:cscevsev/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
//import 'package:intl/intl.dart';
//import 'package:date_format/date_format.dart';


void main() {
  runApp(new MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "Camera Page",
    home: EtkinlikAyrinti(),
  ));
}

class EtkinlikAyrinti extends StatefulWidget {
  @override
  _EtkinlikAyrintiState createState() => _EtkinlikAyrintiState();
}

class _EtkinlikAyrintiState extends State<EtkinlikAyrinti> {
  File imageFile;
  String error = '';
  //bool _agreedToTOS = true;
  //final _formKey = GlobalKey<FormState>();


  _openGallery(BuildContext context) async {
    var picture = await ImagePicker.pickImage(source: ImageSource.gallery);
    this.setState(() {
      imageFile = picture;
    });
    Navigator.of(context).pop();
  }

  _openCamera(BuildContext context) async {
    var picture = await ImagePicker.pickImage(source: ImageSource.camera);
    this.setState(() {
      imageFile = picture;
    });
    Navigator.of(context).pop();
  }

  DateTime selectedDate = DateTime.now();
  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }






  Future<void> _showChoiceDialog(BuildContext context) {
    //_openCamera(context);
    //_openGallery(context);


/*
    return showDialog(context: context, builder: (BuildContext context){
      return AlertDialog(
        title: Text("Make a Choice!"),
        content: SingleChildScrollView(
          child: ListBody(
            children: [
              GestureDetector(
                child: Text("Gallery"),
                onTap: () {
                  _openGallery(context);
                },
              ),
              Padding(padding: EdgeInsets.all(8.0)),
              GestureDetector(
                child: Text("Camera"),
                onTap: () {
                  _openCamera(context);
                },
              ),
            ],
          ),
        ),
      );
    });
    */
    return showDialog(
      context: context,
      builder: (BuildContext context) => AssetGiffyDialog(
        image: Image.asset(
          "images/kameraGif.gif",
          fit: BoxFit.cover,
        ),
        title: Text('You Chose Camera!',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600)),
        description: Text(
          'Are you sure you want to take pictures with the camera?',
          textAlign: TextAlign.center,
          style: TextStyle(),
        ),
        onOkButtonPressed: () {
          _openCamera(context);
        },
      ),
    );
  }


  Future<void> _showChoiceGalleryDialog(BuildContext context) {
    //_openCamera(context);
    //_openGallery(context);
/*
    return showDialog(context: context, builder: (BuildContext context){
      return AlertDialog(
        title: Text("Make a Choice!"),
        content: SingleChildScrollView(
          child: ListBody(
            children: [
              GestureDetector(
                child: Text("Gallery"),
                onTap: () {
                  _openGallery(context);
                },
              ),
              Padding(padding: EdgeInsets.all(8.0)),
              GestureDetector(
                child: Text("Camera"),
                onTap: () {
                  _openCamera(context);
                },
              ),
            ],
          ),
        ),
      );
    });
    */
    return showDialog(
      context: context,
      builder: (BuildContext context) => AssetGiffyDialog(
        image: Image.asset(
          "images/galleryGif.gif",
          fit: BoxFit.cover,
        ),
        title: Text("You Chose Gallery!",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600)),
        description: Text(
          'Are you sure you want to take your photo with the gallery?',
          textAlign: TextAlign.center,
          style: TextStyle(),
        ),
        onOkButtonPressed: () {
          _openGallery(context);
        },
      ),
    );
  }

  Widget _decideImageView() {
    if (imageFile == null) {
      return Center(
        child: Image(image: AssetImage('images/emptyGif.gif')),
      );
    } else {
      Image.file(imageFile, width: 400, height: 400);
    }
    return Image.file(imageFile);
  }

  String dropdownValue = '1';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _decideImageView(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RaisedButton.icon(
                    onPressed: () {
                      _showChoiceDialog(context);
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    label: Text(
                      '',
                    ),
                    icon: Icon(
                      Icons.camera_alt,
                      color: Colors.white,
                      size: 30.0,
                    ),
                    textColor: Colors.white,
                    splashColor: Colors.lightBlue,
                    color: Colors.red,
                  ),

                  RaisedButton.icon(
                    onPressed: () {
                      _showChoiceGalleryDialog(context);
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    label: Text(
                      '',
                    ),
                    icon: Icon(
                      Icons.image,
                      color: Colors.white,
                      size: 30.0,
                    ),
                    textColor: Colors.white,
                    splashColor: Colors.red,
                    color: Colors.lightBlue,
                  )
                ],
              ),
              SizedBox(height: 20.0),
              Text(
                "${selectedDate.toLocal()}".split(' ')[0],
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
              RaisedButton.icon(
                onPressed: () => _selectDate(context),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                label: Text(
                  'Select date',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                  ),
                ),
                icon: Icon(
                  Icons.date_range,
                  color: Colors.white,
                  size: 25.0,
                ),
                textColor: Colors.white,
                splashColor: Colors.red,
                color: Colors.blueAccent,
              ),


              SizedBox(height: 10.0),

              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,

                children: <Widget>[
                  Image.network(
                      'https://coastlinemarketinggroup.com/wp-content/uploads/local-map-icon-mapicon-300x169.png',
                      width: 150,
                      height: 100,
                    //fit:BoxFit.fill
                  ),
                  ListTile(
                    title: Text(
                        'Seçilen Alan',
                      textAlign: TextAlign.center,
                    ),
                    subtitle: Text(
                        'Pendik / İstanbul',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),

          DropdownButton<String>(
            value: dropdownValue,
            icon: Icon(Icons.accessibility),
            iconSize: 24,
            elevation: 16,
            style: TextStyle(color: Colors.deepPurple),
            underline: Container(
              height: 2,
              color: Colors.deepPurpleAccent,
            ),
            onChanged: (String newValue) {
              setState(() {
                dropdownValue = newValue;
              });
            },

            items: <String>['1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),


              SizedBox(height: 30.0),
              RaisedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Home(),
                    ),
                  );
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                label: Text(
                  'Approve',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25.0,
                  ),
                ),
                icon: Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 25.0,
                ),
                textColor: Colors.white,
                splashColor: Colors.red,
                color: Colors.green,
              ),
              //onPressed: _submittable() ? _submit : null,

              SizedBox(height: 5.0),
              Text(
                error,
                style: TextStyle(color: Colors.red, fontSize: 16.0),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 30.0, bottom: 0.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
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
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16.0))),
              backgroundColor: Colors.blueAccent,
            )
          ],
        ),
      ),
    );
  }
}

/*
import 'dart:io';
import 'package:cscevsev/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(new EtkinlikAyrinti());
}

class EtkinlikAyrinti extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new UserOptions(),
    );
  }
}

class UserOptions extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new UserOptionsState();
  }
}

class UserOptionsState extends State<UserOptions> {
  File galleryFile;
  File cameraFile;

  @override
  Widget build(BuildContext context) {
    imageSelectorGallery() async {
      galleryFile = await ImagePicker.pickImage(
        source: ImageSource.gallery,
      );
      print("You selected gallery image : " + galleryFile.path);
      setState(() {});
    }

    //display image selected from camera
    imageSelectorCamera() async {
      cameraFile = await ImagePicker.pickImage(
        source: ImageSource.camera,
        //maxHeight: 50.0,
        //maxWidth: 50.0,
      );
      print("You selected camera image : " + cameraFile.path);
      setState(() {});
    }
/*
    bool rememberMe = false;

    void _onRememberMeChanged(bool newValue) => setState(() {
          rememberMe = newValue;

          if (rememberMe) {
            // TODO: Here goes your functionality that remembers the user.
          } else {
            // TODO: Forget the user
          }
        });
*/

    bool _value = true;

    return new Scaffold(
      body: new Builder(builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 50.0),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Row(
                    children: <Widget>[
                      SizedBox(
                        height: 5.0,
                      ),
                      displaySelectedFile(cameraFile),
                      SizedBox(
                        height: 5.0,
                      ),
                      displaySelectedFile(galleryFile),
                    ],
                  ),
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.symmetric(vertical: 330.0, horizontal: 110.0),
                child: Row(
                  children: [
                    new RaisedButton(
                      child: new Text('Gallery'),
                      onPressed: imageSelectorGallery,
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    RaisedButton(
                      child: new Text('Camera'),
                      onPressed: imageSelectorCamera,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 100, top: 500),
                child: Row(
                  children: <Widget>[
                    Text(
                      "Etkinlik:",
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.green.shade700,
                      ),
                    ),
                    Checkbox(
                      value: _value,
                      onChanged: (bool newValue) {
                        setState(() {
                          _value = newValue;
                        });
                      },
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 160, top: 580),
                child: Row(
                  children: <Widget>[
                    FlatButton(
                      child: Icon(
                        Icons.check,
                        color: Colors.green,
                        size: 60.0,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Home(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget displaySelectedFile(File file) {
    return new SizedBox(
      height: 250.0,
      width: 200.0,
      child: new Card(
        child: file == null
          ? new Image.asset(
        'images/firstLook.png',
        fit: BoxFit.contain,
      )
          : Image.file(file)),

    );
  }
}
/*
              child: new Padding(
              padding: EdgeInsets.only(top: 50),
              //mainAxisAlignment: MainAxisAlignment.spaceAround,
              child: Center(
                child: Wrap(
                  children: <Widget>[
                    Expanded(
                      child: displaySelectedFile(galleryFile),
                    ),
                    Expanded(
                      child: displaySelectedFile(cameraFile),
                    ),
                    new RaisedButton(
                      child: new Text('Gallery'),
                      onPressed: imageSelectorGallery,
                    ),
                    RaisedButton(
                      child: new Text('Camera'),
                      onPressed: imageSelectorCamera,
                    ),
                  ],
                ),
              ),
            ),
            */

*/
