import 'package:flutter/material.dart';
// import 'dart:io';
import 'package:open_store/open_store.dart';

import '01Widgets/w1_app_theme.dart';
import '01Widgets/w2_globals.dart';
import 'b3_safe_journey_button.dart';
import 'package:mercersafe/b4_merpo_stations.dart';

const double _iconSize = 35;
const double _txtSize1  = 20;
const double _txtSize2  = 17;

/*
class NavDrawer extends StatelessWidget {

  const NavDrawer0({super.key});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        //  This will change the
        //  drawer background color
        canvasColor: mercerOrangeColor, // Colors.white
      ),
      child: const Drawer(
        // ...
      ),
    );
  }
}
*/

class NavDrawer extends StatelessWidget {

  const NavDrawer({super.key});

  @override
  Widget build(BuildContext context) {

    return Drawer(

      child: ListView(

        padding: EdgeInsets.zero,

        children:  <Widget>[

          _drawerHeader(_txtSize1),

          _navDrawerListTile(context, safeJourneyIcon, _iconSize,
                             safeJourneyStr, _txtSize2),

          _navDrawerListTile(context, merpoStationsIcon, _iconSize,
                             merpoStationsStr, _txtSize2),

          _navDrawerListTile(context, muAppIcon, _iconSize,
                             muAppStr, _txtSize2),
        ],

      ),

    );

  }
}

DrawerHeader _drawerHeader (double txtSize){
  return    DrawerHeader(

    decoration:  const BoxDecoration(
      color: mercerOrange,
    ),
    child: CircleAvatar(
      backgroundColor: Colors.white,
      radius: 20,
      child: Text('Others',
        style: TextStyle(fontSize:   txtSize,
          fontWeight: FontWeight.bold,
          color: mercerBlack,
        ),
      ),
    ),

  );
}


Widget _navDrawerListTile (BuildContext context,
                           IconData     leadingIcon, double iconSize,
                           String       titleText,   double txtSize) {
  return Container(

      decoration: const BoxDecoration(border: Border(
                                                      bottom: BorderSide(),
                                              ),
                  ),
      child: ListTile(

        leading: Icon(leadingIcon,
                      size:  iconSize,
                      color: isDarkMode ? mercerOrange : mercerBlack,
        ),

        title: Text(titleText,
                    style: TextStyle(fontSize:   txtSize,
                                     fontWeight: FontWeight.bold,
                    ),
        ),

        onTap: ()=> _navigateFromNavDrawer(context, titleText),

      ),
  );
}


void _navigateFromNavDrawer (BuildContext context, String listTileTitle) {

  switch (listTileTitle){

    case safeJourneyStr:

      Navigator.pop(context);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const SafeJourneyButton()),
      );

       /*
      // Remove all routes before pushing the Call Boxes Page
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          // settings: RouteSettings(name: globals.homePageRoute),
          builder: (context) => const SelectCampus(),
        ),

        (route) => false,
      );
      */
      break;


    case merpoStationsStr:

      Navigator.pop(context);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MerpoStations()),
      );

      break;

    case muAppStr:

      /*
      String browserUrlStr;
      if (Platform.isIOS){
        browserUrlStr = 'https://apps.apple.com/us/app/mercer-university/id890911970';
      } else {
        browserUrlStr = 'https://play.google.com/store/apps/details?id=com.dub.app.mercer';
      }
      launchMapOrBrowserURL(browserUrlStr);
      */

      Navigator.pop(context);

      OpenStore.instance.open(
        appStoreId: '890911970',
        androidAppBundleId: 'com.dub.app.mercer',
      );

      break;
  }

}



/*
ListTile _listTile (BuildContext context,   Widget tileIcon,
                    String       tileTitle, Widget tileNavPage) {

  return ListTile(
    leading: tileIcon,
    title: Text(tileTitle,
      style: TextStyle(color: Colors.black),
    ),

    onTap: () {
      // remove all routes until Home Page route
      Navigator.popUntil(context,
          ModalRoute.withName(globals.homePageRoute)
      );

      if (Platform.isIOS)
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => tileNavPage,
          ),
        );

      else
        Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.rightToLeft,
            child: tileNavPage,
          ),
        );
    },
  );

}
*/