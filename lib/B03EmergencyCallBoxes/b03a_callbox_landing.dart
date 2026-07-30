/*
  This feature was programmed by Dr. Ekong
 */

import 'package:flutter/material.dart';
import '../01Widgets/w1_app_theme.dart';
import '../01Widgets/w2_globals.dart';
import '../01Widgets/w3_bottom_nav_bar.dart';
import '../01Widgets/w4_select_campus_body.dart';

const String  _appBarTitle = 'Select a Campus';

class EmergencyCallBoxLandingPage extends StatelessWidget {

  const  EmergencyCallBoxLandingPage({super.key});

  @override
  Widget build(BuildContext context) {

    String imgLoc      = "assets/images/mu3.png";
    String txtUnderImg = '\nSearch for call boxes at \none of these campuses';

    return PopScope(

      canPop: false, // Prevents the route from popping automatically

      onPopInvokedWithResult: (bool didPop, Object? result)  {
        if (didPop) {
          return; // If it already popped (e.g., via another action), do nothing
        }
        backNavToHomepage(context);
      },     // onPopInvokedWithResult

      child: Scaffold(
                      appBar: AppBar( foregroundColor: Colors.white,
                                      title: const Text(_appBarTitle),
                                      backgroundColor: mercerBlack,
                              ),
                      bottomNavigationBar: bottomNavBar (context, _itemsList),

                      // body:  const  _SelectCampusBody( ),
                      body: selectCampusBody(context, callBoxesStr, imgLoc,
                                             txtUnderImg, null),
            ),  // Scaffold
    );   // PopScope

    /*
    return WillPopScope(

      onWillPop: ()=>backNavToHomepage(context),

      child: Scaffold(
                      appBar: AppBar(title:           const Text(_appBarTitle),
                                     backgroundColor: mercerBlack,
                            ),
                      bottomNavigationBar: bottomNavBar (context, _itemsList),
                      // body:  const  _SelectCampusBody( ),
                      body: selectCampusBody(context, callBoxesStr, imgLoc,
                                             txtUnderImg, null),
      ),  // Scaffold
    );    // WillPopScope
    */

  }  // build

}


List<BottomNavigationBarItem> _itemsList = [_homeItem,  _callMerpoItem,
                                         _incidentReportItem, _safeJourneyItem];
BottomNavigationBarItem _homeItem = bottomNavBarItemBuilder(homeIcon,
                                                            homeIconLabel);

BottomNavigationBarItem _incidentReportItem =
           bottomNavBarItemBuilder(incidentReportIcon, incidentReportIconLabel);

BottomNavigationBarItem _callMerpoItem =
                     bottomNavBarItemBuilder(callMerpoIcon, callMerpoIconLabel);

BottomNavigationBarItem _safeJourneyItem =
                 bottomNavBarItemBuilder(safeJourneyIcon, safeJourneyIconLabel);