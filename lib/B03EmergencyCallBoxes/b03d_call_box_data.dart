import 'package:flutter/material.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:mercersafe/01Widgets/w1_app_theme.dart';
import 'dart:io';

import '../01Widgets/w2_globals.dart';

const double callBoxRadius = 2.01; // 2 miles

class CallBox{
  final String  name;
        String? callBoxNumber;
  final double  lat;
  final double  lng;
  final String? plusCode;
        double? distance;   // in miles

  CallBox( {required this.name, this.callBoxNumber, required this.lat, required this.lng,
            this.plusCode, this.distance});
}

/*
    ******************* callBoxDisplay (...) *******************
*/
Widget callBoxDisplay (CallBox callBox){

  return Padding(

    padding: const EdgeInsets.only(left:5.0, top: 5.0),

    child: _callBoxCard(callBox),
  );
}

/*
    ******************* _callBoxCard (...) *******************
*/
Widget _callBoxCard (CallBox callBox){

  String callBoxName = callBox.name;
  double distance    = callBox.distance!;
  String distStr     = '${distance.toStringAsFixed(2)} miles';

  if (callBox.callBoxNumber != null){
    String cBxNum = callBox.callBoxNumber!;
    distStr = '$cBxNum - $distStr';
  }

  return GestureDetector(

    onTap: () => _openCallBoxMap(callBox),

    child: Card (

      borderOnForeground: true,

      elevation: 7,

      child: Padding (

        padding: const EdgeInsets.all(5.0),

        child: SingleChildScrollView(

                scrollDirection: Axis.horizontal,

                child: Column(

                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: <Widget>[

                    Text('\n$callBoxName',
                         // textAlign: TextAlign.center,
                         style:  const TextStyle(fontSize: 17,
                                                 fontWeight: FontWeight.w800,
                                                 color: mercerOrange //Colors.deepOrangeAccent,
                                ),
                       ),


                    Text('$distStr\n',
                          // textAlign: TextAlign.center,
                          style:     const TextStyle(fontSize: 17,
                                                     fontWeight: FontWeight.w800,
                                              // color: Colors.deepOrangeAccent,
                                    ),
                    ),

                  ],
                ),

        ),

      ),

    ),

  );

}     // end of _callBoxCard

/*
    ******************* _openCallBoxMap (...) *******************
*/
void _openCallBoxMap (CallBox callBox) {

  double lat = callBox.lat;
  double lng = callBox.lng;

  if (Platform.isIOS){
    String latStr    = lat.toString();
    String lngStr    = lng.toString();
    String mapUrlStr = 'maps:ll=$latStr,$lngStr&q=Call+Box';

    launchMapOrBrowserURL(mapUrlStr);
  }
  else {

    MapsLauncher.launchCoordinates(lat, lng, 'Call Box');
  }
}


/*
    ******************* showAlertDialog (...) *******************
*/
void showAlertDialog(BuildContext context, String alrtTitle, String alrtContent) {

  // set up the button
  Widget okButton = TextButton(
                                child: const Text("OK",
                                  style: TextStyle(fontWeight: FontWeight.bold,),
                                ),
                                onPressed: () => Navigator.pop(context),
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
                                  title: Text(alrtTitle,
                                              textAlign: TextAlign.center,
                                         ),
                                  content: Text(alrtContent,
                                                textAlign: TextAlign.center,
                                           ),
                                 actions: [okButton,],
                      );

  // show the dialog
  showDialog(
              context: context,
              builder: (BuildContext context) {
                          return alert;
                        },
  );

}     // end of _showAlertDialog



