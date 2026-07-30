//IMPORTS///////////////////////////////////////////////////////////////////////
import 'package:flutter/material.dart';

// Creates the official Mercer Orange swatch
// swatch was generated at https://maketintsandshades.com
const mercerOrangeHex            = 0xFFF76800;
const MaterialColor mercerOrange =
                      MaterialColor(mercerOrangeHex,  // 0% comes in here,
                                                      // this will be
                                                      // color picked if
                                            // no shade is selected when
                                            // defining Color property which
                                            // doesn’t require a swatch.
   <int, Color>{
                 50:  Color(0xFFDE5E00 ),   //  10%
                100:  Color(0xFFC65300),    //  20%
                200:  Color(0xFFAD4900),    //  30%
                300:  Color(0xFF943E00),    //  40%
                400:  Color(0xFF7C3400),    //  50%
                500:  Color(0xFF632A00),    //  60%
                600:  Color(0xFF4A1F00),    //  70%
                700:  Color(0xFF311500),    //  80%
                800:  Color(0xFF190A00),    //  90%
                900:  Color(0xFF000000),    // 100%
              },
);


//creates the official Mercer black
MaterialColor mercerBlack       = MaterialColor(mercerBlackHex, mercerBlackMap);
const         mercerBlackHex    = 0xFF222222;
const         mercerBlackColor  = Color(0xFF222222);

/*
Map <int, Color> mercerBlackMap = {
                                      50:  mercerBlackColor.withOpacity(0.1),
                                      100: mercerBlackColor.withOpacity(0.2),
                                      200: mercerBlackColor.withOpacity(0.3),
                                      300: mercerBlackColor.withOpacity(0.4),
                                      400: mercerBlackColor.withOpacity(0.5),
                                      500: mercerBlackColor.withOpacity(0.6),
                                      600: mercerBlackColor.withOpacity(0.7),
                                      700: mercerBlackColor.withOpacity(0.8),
                                      800: mercerBlackColor.withOpacity(0.9),
                                      900: mercerBlackColor.withOpacity(1.0),
                                  };

*/

Map <int, Color> mercerBlackMap = {
                                    50:  mercerBlackColor.withValues(alpha: 0.1),
                                    100: mercerBlackColor.withValues(alpha: 0.2),
                                    200: mercerBlackColor.withValues(alpha: 0.3),
                                    300: mercerBlackColor.withValues(alpha: 0.4),
                                    400: mercerBlackColor.withValues(alpha: 0.5),
                                    500: mercerBlackColor.withValues(alpha: 0.6),
                                    600: mercerBlackColor.withValues(alpha: 0.7),
                                    700: mercerBlackColor.withValues(alpha: 0.8),
                                    800: mercerBlackColor.withValues(alpha: 0.9),
                                    900: mercerBlackColor.withValues(alpha: 1.0),
};


//creates the official Mercer white
int mercerWhiteHex = 0xffffffff;
Map <int, Color> mercerWhiteMap = {
                                    50: const Color.fromRGBO(255,255,255, .1),
                                    100: const Color.fromRGBO(255,255,255, .2),
                                    200: const Color.fromRGBO(255,255,255, .3),
                                    300: const Color.fromRGBO(255,255,255, .4),
                                    400: const Color.fromRGBO(255,255,255, .5),
                                    500: const Color.fromRGBO(255,255,255, .6),
                                    600: const Color.fromRGBO(255,255,255, .7),
                                    700: const Color.fromRGBO(255,255,255, .8),
                                    800: const Color.fromRGBO(255,255,255, .9),
                                    900: const Color.fromRGBO(255,255,255, 1),
                                 };

MaterialColor mercerWhite = MaterialColor(mercerWhiteHex, mercerWhiteMap);



/*
MaterialColor mercerBlack =  MaterialColor(mercerBlackHex, <int, Color>{
      50:  mercerBlackColor.withOpacity(0.1),
      100: mercerBlackColor.withOpacity(0.2),
      200: mercerBlackColor.withOpacity(0.3),
      300: mercerBlackColor.withOpacity(0.4),
      400: mercerBlackColor.withOpacity(0.5),
      500: mercerBlackColor.withOpacity(0.6),
      600: mercerBlackColor.withOpacity(0.7),
      700: mercerBlackColor.withOpacity(0.8),
      800: mercerBlackColor.withOpacity(0.9),
      900: mercerBlackColor.withOpacity(1.0),
    },
);
*/

/*
int mercerOrangeHex = 0xfff76800;

Map <int, Color> mercerOrangeMap = {
  50: const Color.fromRGBO(97,41,0, .1),
  100: const Color.fromRGBO(97,41,0, .2),
  200: const Color.fromRGBO(97,41,0, .3),
  300: const Color.fromRGBO(97,41,0, .4),
  400: const Color.fromRGBO(97,41,0, .5),
  500: const Color.fromRGBO(97,41,0, .6),
  600: const Color.fromRGBO(97,41,0, .7),
  700: const Color.fromRGBO(97,41,0, .8),
  800: const Color.fromRGBO(97,41,0, .9),
  900: const Color.fromRGBO(97,41,0, 1),
};
MaterialColor mercerOrange = MaterialColor(mercerOrangeHex, mercerOrangeMap);

int mercerBlackHex = 0xff222222;

Map <int, Color> mercerBlackMap = {
  50: const Color.fromRGBO(34,34,34, .1),
  100: const Color.fromRGBO(34,34,34, .2),
  200: const Color.fromRGBO(34,34,34, .3),
  300: const Color.fromRGBO(34,34,34, .4),
  400: const Color.fromRGBO(34,34,34, .5),
  500: const Color.fromRGBO(34,34,34, .6),
  600: const Color.fromRGBO(34,34,34, .7),
  700: const Color.fromRGBO(34,34,34, .8),
  800: const Color.fromRGBO(34,34,34, .9),
  900: const Color.fromRGBO(34,34,34, 1),
};
MaterialColor mercerBlack = MaterialColor(mercerBlackHex, mercerBlackMap);

*/

//creates dark orange
int darkOrangeHex = 0xff8f3c00;
Map <int, Color> darkOrangeMap = {
  50: const Color.fromRGBO(143, 60, 0, .1),
  100: const Color.fromRGBO(143, 60, 0, .2),
  200: const Color.fromRGBO(143, 60, 0, .3),
  300: const Color.fromRGBO(143, 60, 0, .4),
  400: const Color.fromRGBO(143, 60, 0, .5),
  500: const Color.fromRGBO(143, 60, 0, .6),
  600: const Color.fromRGBO(143, 60, 0, .7),
  700: const Color.fromRGBO(143, 60, 0, .8),
  800: const Color.fromRGBO(143, 60, 0, .9),
  900: const Color.fromRGBO(143, 60, 0, 1),
};
MaterialColor darkOrange = MaterialColor(darkOrangeHex, darkOrangeMap);


//creates the official Mercer green
int mercerGreenHex = 0xff6db644;
Map <int, Color> mercerGreenMap = {
  50: const Color.fromRGBO(109,182,68, .1),
  100: const Color.fromRGBO(109,182,68, .2),
  200: const Color.fromRGBO(109,182,68, .3),
  300: const Color.fromRGBO(109,182,68, .4),
  400: const Color.fromRGBO(109,182,68, .5),
  500: const Color.fromRGBO(109,182,68, .6),
  600: const Color.fromRGBO(109,182,68, .7),
  700: const Color.fromRGBO(109,182,68, .8),
  800: const Color.fromRGBO(109,182,68, .9),
  900: const Color.fromRGBO(109,182,68, 1),
};
MaterialColor mercerGreen = MaterialColor(mercerGreenHex, mercerGreenMap);

//creates the official Mercer red
int mercerRedHex = 0xfff9314a;
Map <int, Color> mercerRedMap = {
  50: const Color.fromRGBO(249,49,74, .1),
  100: const Color.fromRGBO(249,49,74, .2),
  200: const Color.fromRGBO(249,49,74, .3),
  300: const Color.fromRGBO(249,49,74, .4),
  400: const Color.fromRGBO(249,49,74, .5),
  500: const Color.fromRGBO(249,49,74, .6),
  600: const Color.fromRGBO(249,49,74, .7),
  700: const Color.fromRGBO(249,49,74, .8),
  800: const Color.fromRGBO(249,49,74, .9),
  900: const Color.fromRGBO(249,49,74, 1),
};
MaterialColor mercerRed = MaterialColor(mercerRedHex, mercerRedMap);
//END OF colors_mercer_official.dart////////////////////////////////////////////




