/*
  Programming of this feature was by Taiyahh Lockett and Dr. Ekong
 */


//IMPORT////////////////////////////////////////////////////////////////////////
import 'package:flutter/material.dart';
import '01Widgets/w1_app_theme.dart';
import '01Widgets/w2_globals.dart';
import '01Widgets/w3_bottom_nav_bar.dart';
import 'b1_call_merpo.dart';

const double  _txtFontSize = 18;

//CLASSES///////////////////////////////////////////////////////////////////////
class SafeJourneyButton extends StatefulWidget {
  const SafeJourneyButton({super.key});

  final String title="Safe Journey Button";

  @override
  State<SafeJourneyButton> createState() => _SafeJourneyButtonState();
}

class _SafeJourneyButtonState extends State<SafeJourneyButton> {

  int _counter = 30;
  String buttonMessage = 'Tap the button to start!';
  final Color _buttonColor = mercerOrange;
  bool _buttonUnpressed = false;
  bool _merpoCalled = false;
  // Row myButtons = const Row();

  void _decreaseCounter() async {

   // Route routeArgs = ModalRoute.of(context)!;

    while (_buttonUnpressed && !_merpoCalled)                           //  && routeArgs.isCurrent)
                            {     // user is NOT touching button
      if (mounted) {
        setState(() {
          buttonMessage = 'Hold down until you reach your destination.';
          // _buttonColor = mercerOrangeColor;
          if (_counter > 0) {
            _counter--;
          }
          if (_counter == 0) {
            _merpoCalled = true;
            _callMerpo(context);
          }
        });
      }

      // wait a second
      await Future.delayed(const Duration(milliseconds: 1000));
    }      // end of first While loop

    while (!_buttonUnpressed) {        // 2nd while loop
                                // user IS touching button

      if (mounted) {
        setState(() {
          buttonMessage = "You are holding the button.";
          // _buttonColor=darkOrange;
        });
      }
      // wait a second
      await Future.delayed(const Duration(milliseconds: 1000));
    }     // end of 2nd while loop
  }      // end of _decreaseCounter

  /*
  Row  makeButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget> [
      Padding(padding: const EdgeInsets.all(15),
              child: ElevatedButton(
                      onPressed: () => _callMerpo(context),
                      style: ElevatedButton.styleFrom(backgroundColor: mercerGreen),
                      child: const Text('CALL MERPO'),
              )),
      Padding(padding: const EdgeInsets.all(15),
            child: ElevatedButton(
              onPressed: () =>  _returnToHomepage(context),
              style: ElevatedButton.styleFrom(backgroundColor: mercerRed),
              child: const Text('Return to Home Page'),
            )),
      ],
    );
  }
  */
  

  @override
  Widget build(BuildContext context) {

    //myButtons=makeButtons();

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

                                appBar: AppBar( foregroundColor: Colors.white,
                                                title: Text(widget.title),
                                        ),
                              // backgroundColor: mercerBlackColor,

                              body: _buildBody(),

                              bottomNavigationBar: bottomNavBar (context,
                                                                _itemsList),
                    )  // Scaffold

    );   // PopScope

    /*
    return WillPopScope(

        onWillPop: ()=>backNavToHomepage(context),

        child: Scaffold(
                        appBar: AppBar(
                                        title: Text(widget.title),
                                ),
                        // backgroundColor: mercerBlackColor,

                        body: _buildBody(),

                        bottomNavigationBar: bottomNavBar (context, _itemsList),

        )  // Scaffold
    );    // WillPopScope
    */

  }  // build

  Widget _buildBody ( ) {

    double contSize = 300;

    return SingleChildScrollView(

      child: Center(
          child: Column(
              children: <Widget>[
                Padding(
                    padding: const EdgeInsets.all(20),
                    child: Text('Seconds: $_counter',
                        style: const TextStyle(fontSize: 40.0,
                          //      color: mercerWhite
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center
                    )
                ),
                Listener(
                  onPointerDown: (details) { // user touches button
                    _buttonUnpressed = false;
                    _counter = 30; //reset timer when user presses down
                  },
                  onPointerUp: (
                      details) { // user is no longer in contact with button
                    _buttonUnpressed = true;
                    _decreaseCounter();
                  },

                  child: Container(
                    width: contSize,
                    height: contSize,
                    decoration: BoxDecoration(
                        color: _buttonColor, shape: BoxShape.circle),
                    padding: const EdgeInsets.all(16.0),
                    child: Align(
                        alignment: Alignment.center,
                        child: Text(buttonMessage,
                            style:  TextStyle(fontSize: 20.0,
                              color: mercerBlack, // mercerWhite
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center
                        )
                    ),
                  ),
                ),

                const Padding(padding: EdgeInsets.all(15)),

                _buttonUnpressed ? Visibility(
                    visible: true, child: _callMerpoBttn(context)) : Visibility(
                    visible: false, child: _callMerpoBttn(context)), //ternary

              ]
          )
      ),

    );
  }

}

List<BottomNavigationBarItem> _itemsList = [_homeItem,          _callMerpoItem,
                                           _incidentReportItem, _callBoxesItem];

BottomNavigationBarItem _homeItem      = bottomNavBarItemBuilder(homeIcon,
                                                                 homeIconLabel);

BottomNavigationBarItem _callMerpoItem =
                     bottomNavBarItemBuilder(callMerpoIcon, callMerpoIconLabel);

BottomNavigationBarItem _incidentReportItem =
           bottomNavBarItemBuilder(incidentReportIcon, incidentReportIconLabel);

BottomNavigationBarItem _callBoxesItem =
                     bottomNavBarItemBuilder(callBoxesIcon, callBoxesIconLabel);


Widget _callMerpoBttn (BuildContext context) {

  String bttnText   = 'CALL MERPO';

  return Padding (
    padding: const EdgeInsets.only(top: 20, left: 10.0, right: 10),

    child: ElevatedButton (
      style: ElevatedButton.styleFrom(
        // The width will be 100% of the parent widget
        // The height will be 80
        minimumSize: const Size.fromHeight(80),
        backgroundColor: Colors.blueAccent,  // mercerGreen,
        shape: BeveledRectangleBorder(
          side: const BorderSide(width: 2,
            //   color: mercerOrangeColor
          ),
          borderRadius: BorderRadius.circular(20),

        ),

      ),

      onPressed: () => _callMerpo(context),

      child: Text(bttnText,
        textAlign: TextAlign.center,
        style:   TextStyle(fontSize: _txtFontSize,
          color:  isDarkMode ?  Colors.white : mercerBlack,
          fontWeight:    FontWeight.bold,
        ),
      ),
    ),
  );
}

void _callMerpo (BuildContext context) {
  // makingCall();
  // _merpoCalled = true;
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (context) =>  const CallMerpo(showSafeJourneyButton: true),
    ),
  );
}


//END OF safe_journey_button.dart///////////////////////////////////////////////