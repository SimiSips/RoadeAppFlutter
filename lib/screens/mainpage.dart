import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:jra_app/screens/MapMarkers.dart';
import 'package:jra_app/screens/TicketsLogged/TicketsLogged.dart';
import 'package:jra_app/screens/loginpage.dart';
import 'package:jra_app/screens/profile.dart';
import 'package:jra_app/screens/publicissues.dart';
import 'package:jra_app/screens/settings.dart';

import 'ImageUpload.dart';
import 'homepage.dart';
import 'mapPage.dart';
import 'otherpage.dart';

///Signout button code
//await FirebaseAuth.instance.signOut();
//Navigator.pushNamedAndRemoveUntil(context, LoginPage.id, (route) => false);

class MainPage extends StatefulWidget {
  static const String id = 'mainpage';

  @override
  _MainPageState createState() => _MainPageState();
}

/*class _MainPageState extends State<MainPage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("JRA APP"),),
      body: Center(
        child: MaterialButton(
          height: 50,
          minWidth: 300,
          color: Colors.amber,
          onPressed: () async {
            DatabaseReference dbref = FirebaseDatabase.instance.reference().child("Test");
            dbref.set("IsConnected");
            await FirebaseAuth.instance.signOut();
            Navigator.pushNamedAndRemoveUntil(context, LoginPage.id, (route) => false);
          },
          child: Text("Test Connection"),
        ),


      ),
    );
  }

}*/

class _MainPageState extends State<MainPage> {
  int pageIndex = 0;

  //GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  final SettingsPage _settings = new SettingsPage();
  final ProfilePage _profile = new ProfilePage();
  //final OtherPage _otherPage = new OtherPage();
  final HomePage _home = HomePage();
  final MapPage _map = new MapPage();
  final PublicPage _public = new PublicPage();
  //final ImageUpload _imageUpload = new ImageUpload();
  //final MapMarkers _mapMarkers = new MapMarkers();
  final TicketsLogged _ticketsPage = new TicketsLogged();

  Widget _showPage = new HomePage();

  Widget _pagePicker(int page) {
    switch (page) {
      case 0:
        return _home;
      case 1:
        return _profile;
      case 2:
        return _settings;
      case 3:
        return _public;
      case 4:
        return _map;
      /*case 5:
        return _imageUpload;*/
      case 5:
        return _ticketsPage;
      default:
        return new Container(
          child: new Center(
            child: new Text(
              "No page found by page picker",
              style: new TextStyle(
                fontSize: 30,
              ),
            ),
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        index: pageIndex,
        height: 60.0,
        items: <Widget>[
          Icon(Icons.add, size: 25),
          Icon(Icons.person, size: 25),
          //Icon(Icons.report_gmailerrorred_outlined, size: 30),
          Icon(Icons.report, size: 25),
          Icon(Icons.public, size: 25),
          //Icon(Icons.map, size: 25),
          //Icon(Icons.image, size: 25,),
          Icon(Icons.pages, size: 25,),
        ],
        color: Colors.amber,
        buttonBackgroundColor: Colors.amber,
        backgroundColor: Colors.white,
        animationCurve: Curves.bounceInOut,
        animationDuration: Duration(milliseconds: 200),
        onTap: (int tappedIndex) {
          setState(() {
            _showPage = _pagePicker(tappedIndex);
          });
        },
        letIndexChange: (index) => true,
      ),
      body: Container(
        //color: Colors.blueAccent,
        child: Center(
          child: _showPage,
        ),
      ),
    );
  }
}
/*child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                //Text(_page.toString(), textScaleFactor: 10.0),

                *//*
*/
/*ElevatedButton(
                  child: Text('Go To Page of index 1'),
                  onPressed: () {
                    *//*
*/
/**//*
*/
/*final CurvedNavigationBarState? navBarState =
                        _bottomNavigationKey.currentState;
                    navBarState?.setPage(HomePage());*//*
*/
/**//*
*/
/*
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()),
                    );
                  },
                )*//*
*/
/*
              ],
            ),*//*

          ),
        ));
  }
}*/
