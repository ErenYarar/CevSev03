import 'package:cscevsev/screens/authenticate/sign_in.dart';
import 'package:cscevsev/screens/home/home.dart';
import 'package:cscevsev/screens/wrapper.dart';
import 'package:cscevsev/services/auth.dart';
import 'package:cscevsev/shared/constants.dart';
import 'package:cscevsev/shared/loading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgetScreen extends StatefulWidget {
  @override
  _ForgetScreenState createState() => _ForgetScreenState();
}

class _ForgetScreenState extends State<ForgetScreen> {
  final AuthService _auth = AuthService();
  //final FirebaseAuthService _auth = FirebaseAuthService();
  final _formKey = GlobalKey<FormState>();

  String error = '';
  bool loading = false;

  bool _obscureText = true;

  // text field state
  String email = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Forgot Password?"),
          leading: GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Wrapper()));
            },
            child: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
      ),
      body: Container(
        height: 800.0,
        color: Colors.white70,
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(height: 50.0),
                Image.asset("images/worldMapGif.gif", ),
                SizedBox(height: 40.0),
                TextFormField(
                  decoration: textInputDecoration.copyWith(
                    labelText: "email",
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide(
                        color: Colors.blue.shade700,
                        width: 2.0,
                      ),
                    ),
                  ),
                  validator: (val) => val.isEmpty ? 'Enter an email' : null,
                  onChanged: (val) {
                    setState(() => email = val);
                  },
                ),
                SizedBox(height: 40.0),
                RaisedButton(
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0),
                      //side: BorderSide(color: Colors.red)
                    ),
                    color: Colors.green.shade400,
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 80),
                    child: Text(
                      'Send Email',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                      ),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        FirebaseAuth.instance
                            .sendPasswordResetEmail(email: email)
                            .then((value) => Text("Check your Email address"));
                      }
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
