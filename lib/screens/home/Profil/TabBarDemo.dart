import 'package:flutter/material.dart';
import './profile.dart' as profile;
import './most_environmentalists.dart' as most;
import 'Events/events.dart' as events;

void main() {
  runApp(TabBarDemo());
}

class TabBarDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(55.0),
            child: AppBar(
              //backgroundColor: Colors.lightBlue,
              bottom: TabBar(
                tabs: <Widget>[
                  new Tab(
                    text: 'Profil',
                  ),
                  new Tab(
                    text: 'Etkinliklerim',
                  ),
                  new Tab(
                    text: 'En Çevreciler',
                  ),
                ],
              ),
            ),
          ),

          body: TabBarView(
            children: <Widget>[
              new profile.Profil(),
              new events.Events(),
              new most.Most(),
            ],
          ),
        ),
      ),
    );
  }
}
