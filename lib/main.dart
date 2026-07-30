import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import '01Widgets/w1b_theme_class.dart';
import 'b0a_homepage.dart';
import 'firebase_options.dart';

const      String _appTitle = 'Mercer Safe';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget{

  const  MyApp ({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(

      debugShowCheckedModeBanner: false,
      title: _appTitle,   //  used by the OS task switcher

      /*
      theme: ThemeData(
        primarySwatch: mercerOrange, // Colors.blue,
        appBarTheme:   const AppBarTheme(
                           // iconTheme: IconThemeData(color: mercerBlackColor),
                          //  backgroundColor: mercerBlackColor,
                       ),
      ),
      */
      theme: ThemeClass.lightTheme,

      // darkTheme: ThemeData.dark(), // standard dark theme
      darkTheme: ThemeClass.darkTheme,

      themeMode: ThemeMode.system, // device controls theme

      home: const HomePage (),
    );
  }

}
