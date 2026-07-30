
// List of Mercer University's campuses
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../b0a_homepage.dart';

bool isDarkMode = false;

List<MercerCampus> campusList = [ _maconMainCampus,
                                  _lawCampus,
                                  _atlCampus,
                                ];

final _maconMainCampus = MercerCampus(campusName:       "Macon",
                                      fbCollectionName: '110_mcnCallBoxes',
                                      merpoNumber:      "tel:4783012911",
                                  merpoEmail:        "mercerpolice@mercer.edu",
                     merpoLat: 32.83099048337138, merpoLng: -83.65300297561569);

final _lawCampus =      MercerCampus(campusName:        "Law",
                                     fbCollectionName:  '115_lawCallBoxes',
                                     merpoNumber:       "tel:4783012911",
                                 merpoEmail:        "mercerpolice@mercer.edu",
                     merpoLat: 32.83099048337138, merpoLng: -83.65300297561569);

final _atlCampus =      MercerCampus(campusName:       "Atlanta",
                                     fbCollectionName: '120_atlCallBoxes',
                                     merpoNumber:      "tel:6785476358",
                                     merpoEmail:       "atlpolice@mercer.edu",
                     merpoLat: 33.87437628604706, merpoLng: -84.2628495576704);

// Key for Shared Preferences storage
const String campusIndexKey       = 'CAMPUS_INDEX_KEY';

class MercerCampus{
  final String  campusName;
  final String  fbCollectionName;
  final String  merpoNumber;
  final String  merpoEmail;
  final double  merpoLat;
  final double  merpoLng;

  MercerCampus( {required this.campusName,  required this.fbCollectionName,
                 required this.merpoNumber, required this.merpoEmail,
                 required this.merpoLat,    required this.merpoLng});
}

const String homeStr           = 'Home';
const String callMerpoStr      = 'Call Merpo';
const String incidentReportStr = 'Report an \nIncident';
const String callBoxesStr      = 'Emergency \nCall Boxes';
const String othersStr         = 'Others';
const String safeJourneyStr    = 'Safe Journey';
const String merpoStationsStr  = 'Merpo Stations';
const String muAppStr          = 'MU App';
const String mercerWebsiteStr  = 'MU Website';

const IconData homeIcon           = Icons.home_filled;
const IconData rightArrowIcon     = Icons.keyboard_arrow_right;
const IconData callMerpoIcon      = Icons.local_phone_rounded;
const IconData incidentReportIcon = Icons.email;
const IconData callBoxesIcon      = Icons.outbox;
const IconData othersIcon         = Icons.format_list_bulleted;
const IconData safeJourneyIcon    = Icons.safety_check;
const IconData merpoStationsIcon  = Icons.map;
const IconData muAppIcon          = Icons.get_app;
const IconData merpoWebsiteIcon   = Icons.open_in_browser;

// Saves updated information in shared preferences
void saveSharedPrefs(int index) async{

  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setInt(campusIndexKey, index);
}

/*
    ******************* launchMapURL (...) *******************
*/
void launchMapOrBrowserURL (String urlStr) async{

  Uri urlUri = Uri.parse(urlStr);

  try{
    await launchUrl(urlUri);
  } catch (ex) {
    throw 'Could not launch map or browser';
  }

}   // end of launchMaporBrowserURL


/*
    ******************* backNavToHomepage (...) *******************
*/
void backNavToHomepage(BuildContext context) async{
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (context) =>  const HomePage(),
    ),
  );
}


