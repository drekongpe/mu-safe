import 'package:flutter/material.dart';
import 'package:mercersafe/01Widgets/w1_app_theme.dart';

class ThemeClass{

  static ThemeData lightTheme =

                    ThemeData(
                              primarySwatch: mercerOrange,

                              scaffoldBackgroundColor: mercerWhite,

                              colorScheme: const ColorScheme.light(),

                              appBarTheme: AppBarTheme(
                                                backgroundColor: mercerBlack,
                                           ),

                              elevatedButtonTheme:
                                  ElevatedButtonThemeData(
                                      style: ElevatedButton.styleFrom(
                                                backgroundColor: mercerOrange,
                                      ),
                                  ),
                    );

  static ThemeData darkTheme = ThemeData(
                                          primarySwatch: mercerOrange,

                                          scaffoldBackgroundColor: mercerBlack,

                                          colorScheme: const ColorScheme.dark(),

                                          appBarTheme: AppBarTheme(
                                                backgroundColor: mercerBlack,
                                          ),

                                          elevatedButtonTheme:
                                            ElevatedButtonThemeData(
                                              style: ElevatedButton.styleFrom(
                                                  backgroundColor: mercerOrange,
                                              ),
                                            ),
                               );
}