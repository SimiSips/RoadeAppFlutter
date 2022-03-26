import 'package:flutter/material.dart';
import 'package:jra_app/screens/LoggedIssuesPages/GeneralIssues.dart';
import 'package:jra_app/screens/LoggedIssuesPages/PotholeIssues.dart';
import 'package:jra_app/screens/LoggedIssuesPages/SignageIssues.dart';
import 'package:jra_app/screens/LoggedIssuesPages/TrafficSignalIssues.dart';
import 'package:jra_app/screens/ReportPages/potholereport.dart';
import 'package:jra_app/screens/ReportPages/signagereport.dart';
import 'package:jra_app/screens/ReportPages/trafficlightreport.dart';

import 'LoggedIssuesPages/TrafficSignalIssues.dart';

class PublicPage extends StatefulWidget {
  const PublicPage({Key? key}) : super(key: key);
  static const String id = 'publicpage';

  @override
  _PublicPageState createState() => _PublicPageState();
}

class _PublicPageState extends State<PublicPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            elevation: 0,
            leading: GestureDetector(
              onTap: () {
                //Navigator.pushNamedAndRemoveUntil(context, MainPage.id, (route) => false);
              },
              child: Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
            ),
            title: Text("All reported issues",
              style: TextStyle(
                  fontSize: 25, fontWeight: FontWeight.bold),),
            backgroundColor: Colors.white38
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: Column(
              children: [
                GestureDetector(
                  onTap: (){
                    print("General");
                    Navigator.push(context, new MaterialPageRoute(
                        builder: (context) =>
                        new GeneralIssues())
                    );
                  },
                  child: Container(
                    height: 70, ///Fixed height will cause errors
                    margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20.0)), color: Colors.white, boxShadow: [
                      BoxShadow(color: Colors.black.withAlpha(100), blurRadius: 20.0),
                    ]),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                          child: Text("General", style: TextStyle(
                              fontSize: 40, fontWeight: FontWeight.bold
                          ),),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20.0,),
                GestureDetector(
                  onTap: (){
                    print("General");
                    Navigator.push(context, new MaterialPageRoute(
                        builder: (context) =>
                        new TrafficSignalIssues())
                    );
                  },
                  child: Container(
                    height: 70, ///Fixed height will cause errors
                    margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20.0)), color: Colors.white, boxShadow: [
                      BoxShadow(color: Colors.black.withAlpha(100), blurRadius: 20.0),
                    ]),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                          child: Text("Traffic Signal", style: TextStyle(
                              fontSize: 40, fontWeight: FontWeight.bold
                          ),),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20.0,),
                GestureDetector(
                  onTap: (){
                    print("General");
                    Navigator.push(context, new MaterialPageRoute(
                        builder: (context) =>
                        new PotholeIssues())
                    );
                  },
                  child: Container(
                    height: 70, ///Fixed height will cause errors
                    margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20.0)), color: Colors.white, boxShadow: [
                      BoxShadow(color: Colors.black.withAlpha(100), blurRadius: 20.0),
                    ]),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                          child: Text("Pothole", style: TextStyle(
                              fontSize: 40, fontWeight: FontWeight.bold
                          ),),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20.0,),
                GestureDetector(
                  onTap: (){
                    print("General");
                    Navigator.push(context, new MaterialPageRoute(
                        builder: (context) =>
                        new SignageIssues())
                    );
                  },
                  child: Container(
                    height: 70, ///Fixed height will cause errors
                    margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20.0)), color: Colors.white, boxShadow: [
                      BoxShadow(color: Colors.black.withAlpha(100), blurRadius: 20.0),
                    ]),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                          child: Text("Signage", style: TextStyle(
                              fontSize: 40, fontWeight: FontWeight.bold
                          ),),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
