import 'package:flutter/material.dart';
import 'package:mercersafe/01Widgets/w1_app_theme.dart';
import 'package:mercersafe/b2_incident_report.dart';

import '../B03EmergencyCallBoxes/b03a_callbox_landing.dart';
import '../b0a_homepage.dart';
import '../b1_call_merpo.dart';
import '../b3_safe_journey_button.dart';

const String homeIconLabel           = 'Home\n ';
const String callMerpoIconLabel      = 'Call Merpo\n';
const String incidentReportIconLabel = 'Report\nIncident';
const String callBoxesIconLabel      = 'Emergency\nCall Boxes';
const String safeJourneyIconLabel    = 'Safe Journey\n';

Widget bottomNavBar (BuildContext context,
                     List<BottomNavigationBarItem> itemsList) {

  return BottomNavigationBar(items: itemsList,

                   landscapeLayout: BottomNavigationBarLandscapeLayout.spread,
                   type:                 BottomNavigationBarType.fixed,
                   showSelectedLabels:   true,
                   showUnselectedLabels: true,

                   backgroundColor:     mercerBlack,
                   selectedItemColor:   Colors.white,
                   unselectedItemColor: Colors.white,

                   onTap: (index)=>onBottomNavItemTapped(context, index,
                                                         itemsList),
         ); // BottomNavigationBar
}

BottomNavigationBarItem bottomNavBarItemBuilder (IconData navIcon,
                                                 String iconLabel) {

  return BottomNavigationBarItem(icon: Icon(navIcon,
                                            color: Colors.white,
                                            // size: _iconSize,
                                       ),
                                 label: iconLabel,
         );
}



void onBottomNavItemTapped (BuildContext context, int index,
                            List<BottomNavigationBarItem> itemsList){

  String iconName = itemsList[index].label!;

  switch (iconName){

    case homeIconLabel:
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>  const HomePage(),
        ),
      );
      break;

    case callMerpoIconLabel:
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>  const CallMerpo( ),
        ),
      );
      break;

    case incidentReportIconLabel:
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>  const ReportIncident( ),
        ),
      );
      break;

    case callBoxesIconLabel:
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>  const EmergencyCallBoxLandingPage( ),
        ),
      );
      break;

    case safeJourneyIconLabel:
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const SafeJourneyButton()),
      );
      break;
  }

}

