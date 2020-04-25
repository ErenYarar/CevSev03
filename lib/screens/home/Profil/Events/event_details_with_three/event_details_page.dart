import 'package:cscevsev/screens/home/Profil/Events/event_details_with_three/event_details_content.dart';
import 'package:cscevsev/screens/home/Profil/Events/events_deatils_with_four/event_detail.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cscevsev/screens/home/Profil/Events/event_details_with_three/event_details_background.dart';


class EventDetailsPage extends StatelessWidget {

  final Event event;

  const EventDetailsPage({Key key, this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Provider<Event>.value(
        value: event,
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            EventDetailsBackground(),
            EventDetailsContent(),
          ],
        ),
      ),
    );
  }
}