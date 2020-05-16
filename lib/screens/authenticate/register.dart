import 'package:cscevsev/services/auth.dart';
import 'package:cscevsev/shared/constants.dart';
import 'package:cscevsev/shared/loading.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  //final FirebaseAuthService _auth = FirebaseAuthService();
  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;
  bool _agreedToTOS = true;
  bool _obscureText = true;

  // text field state
  String email = '';
  String password = '';
  String name = '';

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
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
                      Image.asset(
                        "images/original.png",
                        width: 170.0,
                        height: 170.0,
                      ),
                      SizedBox(height: 20.0),
                      TextFormField(
                        decoration: textInputDecoration.copyWith(
                          labelText: "User name",
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: BorderSide(
                              color: Colors.blue.shade700,
                              width: 2.0,
                            ),
                          ),
                          prefixIcon: Padding(
                            padding: EdgeInsets.only(left: 8), // add padding to adjust icon
                            child: Icon(
                              Icons.person,
                              color: Colors.green.shade400,
                            ),
                          ),
                        ),
                        validator: (val) => val.length > 10
                            ? 'Enter a name less than 10 chars short'
                            : null,
                        onChanged: (val) {
                          setState(() => name = val);
                        },
                      ),
                      SizedBox(height: 20.0),
                      TextFormField(
                        decoration: textInputDecoration.copyWith(
                          labelText: "Email",
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: BorderSide(
                              color: Colors.blue.shade700,
                              width: 2.0,
                            ),
                          ),
                          prefixIcon: Padding(
                            padding: EdgeInsets.only(left: 8), // add padding to adjust icon
                            child: Icon(
                              Icons.mail_outline,
                              color: Colors.green.shade400,
                            ),
                          ),
                        ),
                        validator: (val) =>
                            val.isEmpty ? 'Enter an email' : null,
                        onChanged: (val) {
                          setState(() => email = val);
                        },
                      ),
                      SizedBox(height: 20.0),
                      TextFormField(
                        obscureText: _obscureText,
                        decoration: textInputDecoration.copyWith(
                          labelText: "Password",
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: BorderSide(
                              color: Colors.blue.shade700,
                              width: 2.0,
                            ),
                          ),
                          prefixIcon: Padding(
                            padding: EdgeInsets.only(left: 8),
                            child: Icon(
                              Icons.https,
                              color: Colors.green.shade400,
                            ),
                          ),
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            },
                            child: Icon(
                              _obscureText
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                          ),
                        ),
                        validator: (val) => val.length < 6
                            ? 'Enter a password 6+ chars long'
                            : null,
                        onChanged: (val) {
                          setState(() => password = val);
                        },
                      ),
                      SizedBox(height: 5.0),
                      SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Checkbox(
                                value: _agreedToTOS,
                                onChanged: _setAgreedToTOS,
                              ),
                              GestureDetector(
                                onTap: () => _setAgreedToTOS(!_agreedToTOS),
                                child: const Text(
                                  'I agree to the T&C',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 10.0),
                      RaisedButton(
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0),
                          //side: BorderSide(color: Colors.red)
                        ),
                        color: Colors.blueAccent,
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 80),
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                            color: Colors.white,
                            //fontFamily: "DancingScript",
                            fontSize: 20.0,
                          ),
                        ),
                        onPressed: _submittable() ? _submit : null,
                      ),
                      SizedBox(height: 5.0),
                      Text(
                        error,
                        style: TextStyle(color: Colors.red, fontSize: 14.0),
                      ),
                      SizedBox(height: 5.0),
                      SingleChildScrollView(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "Already have an account?",
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 18.0,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            FlatButton(
                              child: Text(
                                "Sign in",
                                style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              onPressed: () => widget.toggleView(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }

  bool _submittable() {
    return _agreedToTOS;
  }

  void _submit() async {
    if (_formKey.currentState.validate()) {
      setState(() => loading = true);
      dynamic result =
          await _auth.registerWithEmailAndPassword(email, password, name);
      if (result == null) {
        setState(() {
          loading = false;
          error = 'Please supply a valid email';
        });
      }
    }
  }

  void _setAgreedToTOS(bool newValue) {
    setState(() {
      _agreedToTOS = newValue;
    });
  }
}
