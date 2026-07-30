
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mercersafe/01Widgets/w2_globals.dart';

import '../01Widgets/w1_app_theme.dart';
import 'b03c_callbox_display_page.dart';
import 'b03d_call_box_data.dart';

// Fetches the list of emergency call boxes at a campus
// Displays the list of five of the nearest call boxes
class FetchCampusCallBoxes extends StatelessWidget {

  const FetchCampusCallBoxes ({super.key, required this.selectedCampus}) ;

  final int selectedCampus;

  /*
    ******************* buid (...) *******************
   */
  @override
  Widget build (BuildContext context) {

    String firebaseCollectionName = campusList[selectedCampus].fbCollectionName;

    return Scaffold(

      appBar: AppBar(
        foregroundColor: Colors.white,
        title:           const Text("Emergency Call Boxes"),
        backgroundColor: mercerBlack,
      ),

      body: StreamBuilder<QuerySnapshot>(

        stream: FirebaseFirestore.instance
                                .collection(firebaseCollectionName).snapshots(),
        builder: _buildBody,
      ), // StreamBuilder
    );   // Scaffold
  }

  /*
    ******************* _buidBody (...) *******************
   */
  Widget _buildBody(BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {

    Widget body;

    if (snapshot.hasData ){

      List<CallBox> allCallBoxesAtSelectedCampus = []; // list of all call boxes at
                                                       // the selected campus
      // Download list of Firebase documents
      List<DocumentSnapshot> documentsList = snapshot.data!.docs;

      // extract data from Firebase documents
      for (int i = 0; i < documentsList.length; i++){
        DocumentSnapshot ds = documentsList[i];
        bool? callBoxIsActive;

        try {
              callBoxIsActive = ds['04active'];

              if (callBoxIsActive == true){

                String   callBoxName     = ds['01name'];
                GeoPoint gpoint          = ds['02geopoint'];
                double   callBoxLat      = gpoint.latitude;
                double   callBoxLng      = gpoint.longitude;
                String   callBoxPlusCode = ds['03plusCode'];

                const String   line2Field  = '01nameLine2'; // Firebase doc field
                const String   cBxField    = '02callBox';   // Firebase doc field

                CallBox  callBox;


                if( (ds.data() as Map)[line2Field] != null ){  // field exists
                  String line2Str = ds[line2Field];

                  if (line2Str.isNotEmpty){
                    callBoxName  = '$callBoxName\n$line2Str';
                  }
                }


                callBox = CallBox(name:      callBoxName,
                                  lat:       callBoxLat, lng: callBoxLng,
                                   plusCode: callBoxPlusCode);


                if( (ds.data() as Map)[cBxField] != null  ){  // doc field exisits
                  String cBxNumStr = ds[cBxField];

                  if (cBxNumStr.isNotEmpty) {
                    callBox.callBoxNumber  = cBxNumStr;
                  }
                }


                allCallBoxesAtSelectedCampus.add(callBox);
              }

        } catch (e){
                  String campusName = campusList[selectedCampus].campusName;
                  body = _errMsgBody(
                            'Error in $campusName campus call box data($i)');
                  return body;
        }

      }

      body =
       DisplayNearbyCallBoxes(campusName: campusList[selectedCampus].campusName,
                            allCallBoxesAtCampus: allCallBoxesAtSelectedCampus);

    } else {

      body = const Center (
                              child: CircularProgressIndicator(),
            );
    }

    return body;

  }      // end of _buildBody(...)

}  // end of FetchCampusCallBoxes


/*
    ******************* _msgBody (...) *******************
*/
Widget _errMsgBody(String msgStr){

  return  Center(
                child: Text(msgStr,
                            //  textScaleFactor: 1.5,   // deprecated
                            textScaler: const TextScaler.linear(1.5),
                       ),   // Text
  );
}
