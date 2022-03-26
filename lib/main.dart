import 'dart:io';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:jra_app/screens/LoggedIssuesPages/GeneralIssues.dart';
import 'package:jra_app/screens/LoggedIssuesPages/PotholeIssues.dart';
import 'package:jra_app/screens/LoggedIssuesPages/SignageIssues.dart';
import 'package:jra_app/screens/LoggedIssuesPages/TrafficSignalIssues.dart';
import 'package:jra_app/screens/ReportPages/generalreport.dart';
import 'package:jra_app/screens/TicketsLogged/TicketLoggedPage.dart';
import 'package:jra_app/screens/TicketsLogged/TicketsLogged.dart';
import 'package:jra_app/screens/homepage.dart';
import 'package:jra_app/screens/loginpage.dart';
import 'package:jra_app/screens/mainpage.dart';
import 'package:jra_app/screens/ReportPages/potholereport.dart';
import 'package:jra_app/screens/newmainpage.dart';
import 'package:jra_app/screens/profile.dart';
import 'package:jra_app/screens/profilepagefirebase.dart';
import 'package:jra_app/screens/registerpage.dart';
import 'package:jra_app/screens/ReportPages/signagereport.dart';
import 'package:jra_app/screens/ReportPages/trafficlightreport.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
//KII[import 'package:agconnect_crash/agconnect_crash.dart';

import 'constants.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  final FirebaseApp app = await Firebase.initializeApp();

  currentFirebaseUser = await FirebaseAuth.instance.currentUser;

  var userEmail = await FirebaseAuth.instance.currentUser?.email.toString();
  runApp(MyApp());


}


class MyApp extends StatelessWidget{


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(

      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: new SplashScreen(
          seconds: 8,
          navigateAfterSeconds: (currentFirebaseUser == null) ? LoginPage() : NewMainpage(),
          /*title: new Text('Welcome to Roade App',
            style: new TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0
            ),),*/
          image: new Image.asset('assets/images/logo.png'),
          backgroundColor: Colors.white,
          styleTextUnderTheLoader: new TextStyle(),
          photoSize: 100.0,
          onClick: ()=>print("Flutter Egypt"),
          loaderColor: Colors.amber
      ),
      //home: (currentFirebaseUser == null) ? LoginPage() : NewMainpage(),
      debugShowCheckedModeBanner: false,
      routes: {
        RegisterPage.id: (context) => RegisterPage(),
        LoginPage.id: (context) => LoginPage(),
        MainPage.id: (context) => MainPage(),
        HomePage.id: (context) => HomePage(),
        ProfilePageFirebase.id: (context) => ProfilePageFirebase(),
        NewMainpage.id: (context) => NewMainpage(),
        ProfilePage.id: (context) => ProfilePage(),
        GeneralPage.id: (context) => GeneralPage(),
        SignagePage.id: (context) => SignagePage(),
        PotholePage.id: (context) => PotholePage(),
        TrafficPage.id: (context) => TrafficPage(),


        TrafficSignalIssues.id: (context) => TrafficSignalIssues(),
        PotholeIssues.id: (context) => PotholeIssues(),
        SignageIssues.id: (context) => SignageIssues(),
        GeneralIssues.id: (context) => GeneralIssues(),

        TicketsLogged.id: (context) => TicketsLogged(),
        TicketLoggedPage.id: (context) => TicketLoggedPage(),
      },
    );
  }

}

