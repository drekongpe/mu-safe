import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import '../01Widgets/w1_app_theme.dart';
import 'b03d_call_box_data.dart';

Position?  _curPosition;   // current position of the user

const double _txtSize = 15;
const double _txtUnderBttnSize = 15;

List<CallBox> _nearbyCallBoxes = [];

String _txtUnderBttn = '';

class DisplayNearbyCallBoxes extends StatefulWidget{

   const DisplayNearbyCallBoxes ({super.key, required this.campusName,
                                      required this.allCallBoxesAtCampus});

   final String campusName;
   final List<CallBox> allCallBoxesAtCampus;   // all the call boxes at a campus

  @override
  State<DisplayNearbyCallBoxes> createState() => _CallBoxDisplayState();

}   // End of DisplayNearbyCallBoxes

class _CallBoxDisplayState extends State<DisplayNearbyCallBoxes> {

  /*
    ******************* initState () *******************
   */
  @override
  void initState() {
    super.initState();
    _nearbyCallBoxes.clear();
  }

  /*
    ******************* build (...) *******************
   */
  @override
  Widget build(BuildContext context) {

    int numDisplayItems;

    if (_curPosition == null || _nearbyCallBoxes.isEmpty) {

      numDisplayItems = 1;
      _txtUnderBttn = '';

    } else if (_nearbyCallBoxes.length < 5){
      numDisplayItems = _nearbyCallBoxes.length + 1;
    } else {
      numDisplayItems = 6;
    }

    return Padding(
      padding: const EdgeInsets.all(15),

      child: ListView.builder(
        itemCount:   numDisplayItems,
        itemBuilder: _callBoxDisplayBuilder,
      ),

    );

  }	// build

  /*
    ******************* callBoxDisplayBuilder () *******************
   */
  Widget _callBoxDisplayBuilder (BuildContext context, int index) {

    Widget listItem;

    if (index != 0){
      var callBox = _nearbyCallBoxes[index-1];
      listItem    = callBoxDisplay(callBox);
    }
    else {
      listItem = _buttonDisplay(context);
    }

    return listItem;
  }

  /*
    ******************* _buttonDisplay (...) *******************
   */
  Widget _buttonDisplay (BuildContext context){

    String bttnText = '\nClick button to get or refresh'
                      '\ncall box locations at the'
                      '\n${widget.campusName} campus\n';

    return SizedBox (

      width: double.infinity,

      child: Card (

        elevation: 0,

        child: Padding (

          padding: const EdgeInsets.all(5.0),

          child: Column(

            crossAxisAlignment: CrossAxisAlignment.center,

            children: <Widget>[

              Container(
                height: 280,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/mu5.png"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              const Text(''),

              ElevatedButton (
                style: ElevatedButton.styleFrom(
                  // The width will be 100% of the parent widget
                  // The height will be 40
                  minimumSize: const Size.fromHeight(40),

                  // shape: const StadiumBorder(),
                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                      side: BorderSide(width: 3,
                                                        color: mercerBlack,
                                      ),
                          ),
                ),

                onPressed: () {
                  _nearbyCallBoxes.clear();
                  _getCurrentPosition(context);
                },

                child:  Text(bttnText,
                             textAlign: TextAlign.center,
                             style: TextStyle(fontSize: _txtSize,
                                                fontWeight: FontWeight.bold,
                                                    color: mercerBlack,
                             ),
                ),

              ),

              Text (_txtUnderBttn,
                    textAlign: TextAlign.start,
                    style: const TextStyle(fontSize: _txtUnderBttnSize,
                                            fontWeight: FontWeight.bold,
                                            // color: Colors.deepOrangeAccent,
                           ),
              ),
            ],
          ),

        ),

      ),

    );
  }                  // end of buttonDisplay

  /*
    ******************* _getCurrentPosition (...) *******************
    Determine the current position of the device, and then
    find nearby emergency call boxes
    *****************************************************************
   */
  Future<void> _getCurrentPosition(BuildContext context) async {

    final hasPermission = await _getDeviceLocationPermission(context);

    if (hasPermission == false) return;

    final LocationSettings locationSettings =
                              LocationSettings(accuracy: LocationAccuracy.high);

    await Geolocator.getCurrentPosition(locationSettings: locationSettings)
                                   //  (desiredAccuracy: LocationAccuracy.high)
                    .then ( (Position? position) {
                              _curPosition = position;

                              if (context.mounted){
                                _findNearbyCallBoxes(context,
                                                     widget.allCallBoxesAtCampus,
                                                     position!.latitude,
                                                     position.longitude);
                              }

                              // redraw screen
                              setState( ( ) {
                              } );
                          }
                   )
                   .catchError( (e) {
                                debugPrint(e);
                             }
                  );
  }                   // end of _getCurrentPosition


  /*
    ******************* _getDeviceLocationPermission (...) *******************
   */
  Future<bool> _getDeviceLocationPermission(BuildContext context) async {

    // When the device's location services are not enabled or permissions
    // are denied the `Future` will return false

    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (serviceEnabled == false) {
      // Location services are not enabled don't continue
      // return false
      String alrtTitle   = 'Location services are disabled';
      String alrtContent = 'Please enable the services';

      if (context.mounted){
        _txtUnderBttn = '';
        showAlertDialog(context, alrtTitle, alrtContent);
      } else {
        _txtUnderBttn  = '\n$alrtTitle. \n$alrtContent.';
      }

      setState( ( ) {
      } ) ;
      return false;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        String alrtTitle   = 'Location permissions are denied';
        String alrtContent = '';

        if (context.mounted){
          _txtUnderBttn = '';
          showAlertDialog(context, alrtTitle, alrtContent);
        } else {
          _txtUnderBttn  = '\n$alrtTitle.';
        }
        setState( ( ) {
        } ) ;

        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      String alrtTitle   = 'Location permissions are permanently disabled';
      String alrtContent = 'We cannot request permissions';

      if (context.mounted){
        _txtUnderBttn = '';
        showAlertDialog(context, alrtTitle, alrtContent);
      } else {
        _txtUnderBttn  = '\n$alrtTitle. \n$alrtContent.';
      }

      setState( ( ) {
      } ) ;
      return false;
    }

    // When we reach here, permissions are granted
    return true;
  }               // end of _getDeviceLocationPermission

}   // end of _CallBoxDisplayState


/*
  *****************  _findNearbyCallBoxes  (...) ***************************************
    - Checks user's campus
    - Computes user's distance from campus call boxes
    - Selects call boxes that are within a 2-mile radius
  ************************************************************
*/
void _findNearbyCallBoxes(BuildContext context,
                          List<CallBox> allCallBoxesAtCampus,
                          double deviceLat, deviceLng) {

  double distanceInMeters;
  double distanceInMiles;

  _txtUnderBttn = '';

  for (int i = 0; i < allCallBoxesAtCampus.length; i++){

    var campusCallBox = allCallBoxesAtCampus[i];

    distanceInMeters =
        Geolocator.distanceBetween(deviceLat, deviceLng,
            campusCallBox.lat, campusCallBox.lng);

    distanceInMiles = distanceInMeters / 1609.34;

    if (distanceInMiles < callBoxRadius){
      campusCallBox.distance = distanceInMiles;
      _nearbyCallBoxes.add(campusCallBox);
    }
  }

  if (_nearbyCallBoxes.isNotEmpty){

    if (_nearbyCallBoxes.length > 1){     // sort call boxes according to distance
        _nearbyCallBoxes.sort( (a, b) => a.distance!.compareTo(b.distance!) );
    }

    _txtUnderBttn = '\nTap call box name for directions\n';

  } else {
    showAlertDialog(context,
        "There are no \nemergency call boxes nearby",
        "Please dial 911 for your emergency"
    );
  }

}        // end of _findNearbyCallBoxes
