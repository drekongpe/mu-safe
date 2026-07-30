import 'dart:io';
import 'package:flutter/material.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:url_launcher/url_launcher.dart';
import 'w1_app_theme.dart';
import 'w2_globals.dart';
import '../B03EmergencyCallBoxes/b03b_fetch_campus_callboxes.dart';
import '../B03EmergencyCallBoxes/b03d_call_box_data.dart';
import '../b3_safe_journey_button.dart';

const double  _txtFontSize = 18;

const    double _topPadding   = 20.0;
const    double _leftPadding  = 20.0;
const    double _rightPadding = 20.0;

int _lastItem = campusList.length - 1;

Widget selectCampusBody(BuildContext context, String appBarTitle,
                        String imgLoc,        String txtUnderImg,
                        bool? showSafeJourneyButton) {

  return Padding(

    padding: const EdgeInsets.only(top:   _topPadding, left: _leftPadding,
                                   right: _rightPadding),

    child: ListView.builder(

      itemCount: campusList.length + 1, // includes image

      itemBuilder: (context, index) =>
          _selectCampusListViewBuilder(context, index, appBarTitle, imgLoc,
                                       txtUnderImg,    showSafeJourneyButton),
    ),

  );

} // End of _selectCampusBody


Widget _selectCampusListViewBuilder (BuildContext context, int index,
                                     String appBarTitle,   String imgLoc,
                              String txtUnderImg, bool? showSafeJourneyButton) {

  Widget listItem ;

  if (index != 0){
    listItem = _buttonListTile(context, index-1, appBarTitle,
                               showSafeJourneyButton);
  } else {
    listItem = _selectCampusPageImage(imgLoc, txtUnderImg);
  }

  return listItem;
}

Widget _selectCampusPageImage (String imgLoc, String txtUnderImg){

  return Padding(
      padding: const EdgeInsets.all(5.0),

      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,

          children: <Widget>[

            Container(
              height:200,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(imgLoc),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            Text(txtUnderImg,
              textAlign: TextAlign.center,
              style:  TextStyle(fontSize: _txtFontSize,
                color:  isDarkMode ? Colors.white : mercerBlack,
                fontWeight: FontWeight.bold,
              ),
            ),

          ]
      )
  );

}

Widget _buttonListTile (BuildContext context, int campusListIndex,
                        String appBarTitle,
                        bool? displaySafeJourneyButton){

  return Column(

        crossAxisAlignment: CrossAxisAlignment.center,

        children: <Widget>[

          _selectCampusButton(context, campusListIndex, appBarTitle),

          (displaySafeJourneyButton == true) && (_lastItem == campusListIndex) ?
          _goBackToSafeJourneyButton(context) : const SizedBox.shrink(),

        ],

  );

}

Widget _selectCampusButton (BuildContext context, int index,
                            String appBarTitle) {

  String bttnText = campusList[index].campusName;

  return Padding (
    padding: const EdgeInsets.all(5.0),

    child: ElevatedButton (
      style: ElevatedButton.styleFrom(
        // The width will be 100% of the parent widget
        // The height will be 80
        minimumSize: const Size.fromHeight(80),
        // shape: const StadiumBorder(),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
          side:  BorderSide(width: 3,
              color: mercerBlack
          ),
        ),
          backgroundColor: mercerOrange,
      ),

      onPressed: () =>
          _onBttnClicked(context, index, appBarTitle),

      child: Text(bttnText,
        textAlign: TextAlign.center,
        style:  TextStyle(fontSize:   _txtFontSize,
                          color:      mercerBlack,
                          fontWeight: FontWeight.bold,
                ),
      ),
    ),
  );
}


void _onBttnClicked (BuildContext context, int index, String appBarTitle) {

  saveSharedPrefs(index);

  switch (appBarTitle){

    case callMerpoStr:
      _callMerpo(context, index);
      break;

    case incidentReportStr:
      _sendEmailToMerpo(context, index);
      break;

    case callBoxesStr:
      _navigateToNextPage(context, index);
      break;

    case merpoStationsStr:
      _openMerpoStationMap(index);
      break;
  }

}



// Call Merpo
void _callMerpo (BuildContext context, int index) {

  String campusNumber = campusList[index].merpoNumber;

  Uri urlUri = Uri.parse(campusNumber);

  _launchURL(context, urlUri, 'Could not call Merpo phone number');

}   // end of _callMerpo


void _sendEmailToMerpo(BuildContext context, int index) {

  String addr        = campusList[index].merpoEmail;
  String addrUriStr  = Uri.encodeComponent(addr);

  String subjUriStr = Uri.encodeComponent("Incident report: ");

  String body       = 'Name: '
                      '\n\nPhone number: '
                      '\n\nLocation: '
                      '\n\nWrite incident report below.'
                      '\n(Attach pictures if available).';

  String bodyUriStr = Uri.encodeComponent(body);

  Uri mailUri =
           Uri.parse("mailto:$addrUriStr?subject=$subjUriStr&body=$bodyUriStr");

  _launchURL(context, mailUri, 'Could not open email app');

}

void _launchURL (BuildContext context, Uri uri, String errMsg) async{

  try {
                await launchUrl(uri);

  } catch (ex) {
                if (context.mounted){
                  showAlertDialog(context, errMsg, '');
                }
                throw errMsg;
  }

}    // end of launchURL

void _openMerpoStationMap (int index) {

  MercerCampus campus = campusList[index];

  double lat = campus.merpoLat;
  double lng = campus.merpoLng;

  if (Platform.isIOS){
    String latStr    = lat.toString();
    String lngStr    = lng.toString();
    String mapUrlStr = 'maps:ll=$latStr,$lngStr&q=Mercer+Police+Station';

    launchMapOrBrowserURL(mapUrlStr);
  }
  else {
    MapsLauncher.launchCoordinates(lat, lng, 'Mercer Police Station');
  }
}


void _navigateToNextPage (BuildContext context, int selectedCampus) {

  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) =>
                          FetchCampusCallBoxes(selectedCampus: selectedCampus),
    ),
  );

}


Widget _goBackToSafeJourneyButton (BuildContext context) {

  String bttnText   = 'Or go back to\nSafe Journey';

  return Padding (
    padding: const EdgeInsets.only(top: 20, left: 5.0, right: 5),

    child: ElevatedButton (
      style: ElevatedButton.styleFrom(
        // The width will be 100% of the parent widget
        // The height will be 80
        minimumSize: const Size.fromHeight(80),
        backgroundColor: Colors.blueAccent, // mercerGreen,
        // shape: const StadiumBorder(),
        shape: BeveledRectangleBorder(
          side: const BorderSide(width: 2,
            //   color: mercerOrangeColor
          ),
          borderRadius: BorderRadius.circular(20),

        ),

        /*
        RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                      side: const BorderSide(width: 3,
                                                         color: mercerBlackColor
                                                  ),
        ),
        */
      ),

      onPressed: () =>
          _navigateToSafeJourney(context),

      child: Text(bttnText,
        textAlign: TextAlign.center,
        style:  TextStyle(fontSize: _txtFontSize,
          color:    mercerBlack,
          fontWeight:    FontWeight.bold,
        ),
      ),
    ),
  );
}

void _navigateToSafeJourney (BuildContext context){

  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => const SafeJourneyButton()),
  );

}