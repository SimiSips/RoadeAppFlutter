import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:jra_app/constants.dart';
import 'package:jra_app/screens/TicketsLogged/TicketsLogged.dart';
import 'package:jra_app/screens/homepage.dart';
import 'package:jra_app/screens/profile.dart';
import 'package:jra_app/screens/profilepagefirebase.dart';
import 'package:jra_app/screens/publicissues.dart';
import 'package:jra_app/screens/settings.dart';
import 'package:jra_app/widgets/Dialog.dart';

import '../Admobhelper.dart';

class NewMainpage extends StatelessWidget {
  static const String id = 'newmainpage';
  const NewMainpage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:Scaffold(
        backgroundColor: Colors.amber,
        appBar: AppBar(
          backgroundColor: Colors.amber,
          elevation: 0,
          title: Text('Home', style: TextStyle(color: Colors.black),),
        ),
        drawer: Drawer(

          child: ListView(
            children: [
              Container(
                color: Colors.amber,
                height: 140,
                child: DrawerHeader(
                  decoration: BoxDecoration(
                      color: Colors.amber
                  ),
                  child: Row(
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[

                          Text("Welcome - \n${currentFirebaseUser?.email}",
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'Brand-Bold',
                            ),
                          ),
                          SizedBox(height: 20.0,),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                color: Colors.black,
                child: Column(
                  children: [
                    ListTile(
                      leading: Icon(Icons.person, color: Colors.white,),
                      title: GestureDetector(
                        onTap: () {
                          if(currentFirebaseUser?.email == null){
                            showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (BuildContext context) => WaitDialog(
                                  heading: 'Profile not loaded',
                                  status: 'Please restart the app',)
                            );
                          } else {
                            Navigator.push(context, new MaterialPageRoute(
                                builder: (context) =>
                                new ProfilePage())
                            );
                          }

                        },
                        child: Text(
                          'Profile',
                          style: TextStyle(
                              color: Colors.white
                          ),
                        ),
                      ),
                    ),
                    ListTile(
                      leading: Icon(Icons.report, color: Colors.white,),
                      title: GestureDetector(
                        onTap: () {
                          if(currentFirebaseUser?.email == null){
                            showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (BuildContext context) => WaitDialog(
                                  heading: 'Profile not loaded',
                                  status: 'Please restart the app',)
                            );
                          } else {
                            Navigator.push(context, new MaterialPageRoute(
                                builder: (context) =>
                                new SettingsPage())
                            );
                          }

                        },
                        child: Text(
                          'Your logged issues',
                          style: TextStyle(
                            color: Colors.white
                          ),
                        ),
                      ),
                    ),
                    ListTile(
                      leading: Icon(Icons.public, color: Colors.white,),
                      title: GestureDetector(
                        onTap: () {
                          if(currentFirebaseUser?.email == null){
                            showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (BuildContext context) => WaitDialog(
                                  heading: 'Profile not loaded',
                                  status: 'Please restart the app',)
                            );
                          } else {
                            Navigator.push(context, new MaterialPageRoute(
                                builder: (context) =>
                                new PublicPage())
                            );
                          }

                        },
                        child: Text(
                          'All reported issues',
                          style: TextStyle(
                              color: Colors.white
                          ),
                        ),
                      ),
                    ),
                    ListTile(
                      leading: Icon(Icons.pages, color: Colors.white,),
                      title: GestureDetector(
                        onTap: () {
                          if(currentFirebaseUser?.email == null){
                            showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (BuildContext context) => WaitDialog(
                                  heading: 'No tickets found',
                                  status: 'Please restart the app',)
                            );
                          } else {
                            Navigator.push(context, new MaterialPageRoute(
                                builder: (context) =>
                                new TicketsLogged())
                            );
                          }

                        },
                        child: Text(
                          'Logged tickets',
                          style: TextStyle(
                              color: Colors.white
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Container(
                color: Colors.black,
                height: 600,
                child: Column(
                  children: [
                    RaisedButton(
                      padding: const EdgeInsets.only(
                        left: 90, right: 90,),
                      onPressed: (){
                        SystemNavigator.pop();
                      },
                      elevation: 4,
                      color: Colors.amber,

                      child: Container(
                        margin: EdgeInsets.only(top: 10),
                        height: 30,
                        child: Text("Close App",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight
                              .bold),),
                      ),
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30)
                      ),
                    ),

                    SizedBox(height: 30.0,),
                    Divider(
                      color: Colors.white,
                    ),
                    SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.only(left: 12.0),
                      child: Text(
                        'Version ' + versionnumber,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                          color: Colors.white,
                        ),
                      ),
                    ), ///Version Number Text - Constants.dart file

                    SizedBox(height: 30,),
                    Padding(
                      padding: const EdgeInsets.only(left: 12.0),
                      child: Text(
                        '\u00a9 2021 Brain Cap Developers ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(height: 140,),
                  ],
                ),
              )
            ],
          ),
        ),
        /*drawer: new Drawer(
          child: new ListView(
            children: <Widget>[
              new Container(
                child: new DrawerHeader(
                    child: new CircleAvatar()
                ),
                color: Colors.tealAccent,),
              new Container (
                color: Colors.black,
                child: new Column(
                  children: new List.generate(4, (int index){
                    return new ListTile(
                      leading: Icon(Icons.person, color: Colors.white,),
                      title: GestureDetector(
                        onTap: () {
                          if(currentFirebaseUser?.email == null){
                            showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (BuildContext context) => WaitDialog(
                                  heading: 'Profile not loaded',
                                  status: 'Please restart the app',)
                            );
                          } else {
                            Navigator.push(context, new MaterialPageRoute(
                                builder: (context) =>
                                new ProfilePage())
                            );
                          }

                        },
                        child: Text(
                          'Profile',
                          style: TextStyle(
                            color: Colors.white
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              )
            ],
          ),
        ),*/
        body: HomePage(),
        bottomNavigationBar: Container(
          child: AdWidget(
            ad: AdmobHelper.getBannerAd()..load(),
            key: UniqueKey(),
          ),
          height: 50,
        ),
      ),
    );
  }
}
