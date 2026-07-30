import 'package:flutter/material.dart';
import 'package:mercersafe/01Widgets/w2_globals.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '01Widgets/w1_app_theme.dart';
import 'B03EmergencyCallBoxes/b03a_callbox_landing.dart';
import 'b0b_nav_drawer.dart';
import 'b1_call_merpo.dart';
import 'b2_incident_report.dart';
import 'b3_safe_journey_button.dart';

const    String _appBarTitle = 'MU Safe';

const    double _horizPadding = 30;
const    double _vertPadding = 15;
const    double _leftPadding = 30;
const    double _rightPadding = 30;

const double _iconSize    = 37;
const double _txtFontSize = 18;

int _selectedCampus = 0;

final GlobalKey<ScaffoldState> _key = GlobalKey(); // Create a key

class HomePage extends StatefulWidget {

  const  HomePage ({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{

  @override
  void initState() {
    super.initState();
    _loadSharedPrefs();
  }

  //Loading sharedpreferences on start

  Future<void> _loadSharedPrefs() async {

    final prefs = await SharedPreferences.getInstance();

    setState(() {
      _selectedCampus =  prefs.getInt(campusIndexKey) ?? 0;
    });
  }


  /*
    ******************* buid (...) *******************
   */
  @override
  Widget build (BuildContext context) {

    if( Theme.of(context).brightness ==  Brightness.dark   ){
       isDarkMode = true;
    }

    return Scaffold(

      key: _key,     // assign key to Scaffold

      drawer: const NavDrawer(),

     // backgroundColor: mercerBlackColor,

      appBar: AppBar(
                      foregroundColor: Colors.white,
                      title: const Text(_appBarTitle),
      ),

      body:  _homepageBody(context), // StreamBuilder
    );
  }

}  // end of _HomePageState


Widget _homepageBody(BuildContext context)  {

    return ListView(

      children:    <Widget>[

        _homepageImage(),

        _homepageListTile (context,
                           callMerpoIcon, _iconSize,
                           callMerpoStr, _txtFontSize),

        _homepageListTile (context,
                           incidentReportIcon, _iconSize,
                           incidentReportStr, _txtFontSize),

        _homepageListTile (context,
                           callBoxesIcon, _iconSize,
                           callBoxesStr, _txtFontSize),

        _homepageListTile (context,
                           othersIcon, _iconSize,
                           othersStr, _txtFontSize),
      ],

    );

}


Widget _homepageImage ( ){

  String imgLoc;

  if (_selectedCampus == 1){
    imgLoc = "assets/images/mu1.png";
  } else if (_selectedCampus == 2) {
    imgLoc = "assets/images/mu2.png";
  } else {
    imgLoc = "assets/images/mu0.png";
  }

  return Padding(
    padding: const EdgeInsets.only(top: _vertPadding, left: _leftPadding,
                                   right: _rightPadding),
    child: Container(
      height:200,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(imgLoc),
          fit: BoxFit.cover,
        ),
      ),
    ),
  );

}

Widget _homepageListTile (BuildContext context,
                          IconData     leadingIcon, double iconSize,
                          String       titleText,   double txtSize)  {
  return Padding(

    padding: const EdgeInsets.only(top:   _vertPadding,
                                   left:  _leftPadding,
                                   right: _rightPadding),

    child: ListTile(

      shape: BeveledRectangleBorder(
        side: const BorderSide(width: 2,
                            //   color: mercerOrangeColor
        ),
        borderRadius: BorderRadius.circular(20),

      ),

      tileColor: mercerOrange,

      leading: Icon(leadingIcon,
                     color: mercerBlack,
                     size:  iconSize,
              ),

      title: Text(titleText,
                  textAlign: TextAlign.center,
                  style:     TextStyle(fontSize:   txtSize,
                                       fontWeight: FontWeight.bold,
                                       color: mercerBlack,
                             ),
             ),

      trailing: Icon(rightArrowIcon,
                     color: mercerBlack,
                     size:  iconSize,
                ),

      onTap: ()=> _navigateFromHomePage(context, titleText),

      contentPadding: const EdgeInsets.symmetric(horizontal: _horizPadding,
                                                  vertical:   _vertPadding),
    ),
  );
}


void _navigateFromHomePage (BuildContext context, String listTileTitle){

  switch (listTileTitle){

    case callMerpoStr:
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const CallMerpo()),
      );
      break;

    case incidentReportStr:
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const ReportIncident()),
      );
      break;

    case callBoxesStr:
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) =>
                    const EmergencyCallBoxLandingPage()),
      );
      break;

    case othersStr:      // opens Navigation drawer
      _key.currentState!.openDrawer();
      break;

    case safeJourneyStr:
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const SafeJourneyButton()),
      );
      break;
  }

}
