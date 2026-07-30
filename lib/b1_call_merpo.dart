import 'package:flutter/material.dart';
import 'package:mercersafe/01Widgets/w4_select_campus_body.dart';
import '01Widgets/w1_app_theme.dart';
import '01Widgets/w2_globals.dart';
import '01Widgets/w3_bottom_nav_bar.dart';

const String  _appBarTitle = callMerpoStr;

class CallMerpo extends StatelessWidget {

  const CallMerpo({super.key, this.showSafeJourneyButton});

  final bool? showSafeJourneyButton;

  @override
  Widget build(BuildContext context) {

    String imgLoc = "assets/images/mu4.png";

    String txtUnderImg = '\nCall Merpo at \none of these campuses';

    return PopScope(

              canPop: false, // Prevents the route from popping automatically

              onPopInvokedWithResult: (bool didPop, Object? result)  {
                if (didPop) {
                  return; // If it already popped (e.g., via another action),
                          // do nothing
                }
                backNavToHomepage(context);
              },     // onPopInvokedWithResult

              child: Scaffold(

                        appBar: AppBar(
                                        foregroundColor: Colors.white,
                                        title: const Text(_appBarTitle),
                                        backgroundColor: mercerBlack,
                                ),

                        bottomNavigationBar: bottomNavBar(context, _itemsList),

                        // body: _callMerpoBody(context),

                        body: selectCampusBody(context, _appBarTitle, imgLoc,
                                           txtUnderImg, showSafeJourneyButton),
                    ),   // Scaffold

    );   // PopScope

    /*
    return WillPopScope(

        onWillPop: ()=>backNavToHomepage(context),

        child: Scaffold(

          appBar: AppBar(title: const Text(_appBarTitle),
                                           backgroundColor: mercerBlack,
          ),

          bottomNavigationBar: bottomNavBar(context, _itemsList),

          // body: _callMerpoBody(context),

          body: selectCampusBody(context, _appBarTitle, imgLoc, txtUnderImg,
                                 showSafeJourneyButton),
        ),   // Scaffold

    );  // WillPopScope
    */

  }

}


List<BottomNavigationBarItem> _itemsList = [_homeItem,      _incidentReportItem,
                                            _callBoxesItem, _safeJourneyItem];

BottomNavigationBarItem _homeItem = bottomNavBarItemBuilder(homeIcon,
                                                            homeIconLabel);

BottomNavigationBarItem _incidentReportItem =
           bottomNavBarItemBuilder(incidentReportIcon, incidentReportIconLabel);

BottomNavigationBarItem _callBoxesItem =
                     bottomNavBarItemBuilder(callBoxesIcon, callBoxesIconLabel);

BottomNavigationBarItem _safeJourneyItem =
                 bottomNavBarItemBuilder(safeJourneyIcon, safeJourneyIconLabel);
