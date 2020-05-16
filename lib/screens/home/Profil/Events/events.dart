import 'package:cscevsev/app_state.dart';
import 'package:cscevsev/screens/home/Profil/Events/event_details_with_three/event_details_page.dart';
import 'package:cscevsev/screens/home/Profil/Events/events_deatils_with_four/event_detail.dart';
import 'package:cscevsev/screens/home/Profil/Events/events_deatils_with_four/event_widget.dart';
import 'package:cscevsev/screens/home/Profil/Events/events_deatils_with_four/events_background.dart';
import 'package:cscevsev/screens/home/Profil/styleguide.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cscevsev/screens/home/Profil/Events/category_details/category.dart';
import 'package:cscevsev/screens/home/Profil/Events/category_details/category_widget.dart';
class Events extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider<AppState>(
        create: (_) => AppState(),
        child: Stack(
          children: <Widget>[
            EventsBackground(
              screenHeight: MediaQuery.of(context).size.height,
            ),
            SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 10.0),
                      child: Row(
                        children: <Widget>[
                          SizedBox(height: 10.0),
                          Text(
                            "LOCAL EVENTS",
                            style: fadedTextStyle,
                          ),
                          Spacer(),
                          Icon(
                            Icons.person_outline,
                            color: Color(0x99FFFFFF),
                            size: 30,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32.0),
                      child: Text(
                        "My Events",
                        style: whiteHeadingTextStyle,
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 24.0),
                      child: Consumer<AppState>(
                        builder: (context, appState, _) => SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: <Widget>[for (final category in categories) CategoryWidget(category: category)],
                          ),
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Consumer<AppState>(
                        builder: (context, appState, _) => Column(
                          children: <Widget>[
                            for (final event in events.where((e) => e
                                .categoryIds
                                .contains(appState.selectedCategoryId)))
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          EventDetailsPage(event: event),
                                    ),
                                  );
                                },
                                child: EventWidget(
                                  event: event,
                                ),
                              )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}