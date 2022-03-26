import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
//import 'package:jra_app/datamodels/modelClass.dart';
import 'package:jra_app/datamodels/publicModelClass.dart';
import 'package:jra_app/constants.dart';
import 'package:url_launcher/url_launcher.dart';

import '../mainpage.dart';
import '../newmainpage.dart';
//import 'loginpage.dart';

class PotholeIssues extends StatefulWidget {
  const PotholeIssues({Key? key}) : super(key: key);
  static const String id = 'potholeissues';

  @override
  _PotholeIssuesState createState() => _PotholeIssuesState();
}

class _PotholeIssuesState extends State<PotholeIssues> {
  final potholeReports = FirebaseDatabase.instance.reference().child("global").child("Reports").child("Pothole");
  List<Model> list = [];
  Future<void>? _launched;

  Future<void> _launchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
        headers: <String, String>{'my_header_key': 'my_header_value'},
      );
    } else {
      throw 'Could not launch $url';
    }
  }
  @override

  void initState() {
    super.initState();
    _initUser().whenComplete((){
      setState(() {});
    });
  }

  _initUser() async {
    potholeReports.once().then((DataSnapshot snap) {
      var data = snap.value;
      list.clear();
      data.forEach((key,value) {
        Model publicModel = new Model(
          description: value['description'],
          typeofissue: value['typeofissue'],
          status: value['status'],
          area: value['area'],
          locationUrl: value['locationUrl'],
          key: key,
        );

        list.add(publicModel);
      });
      setState(() {

      });
    });
  }

  Widget build(BuildContext context) {
    Widget UI(String typeofissue, String description, String locationUrl, String area, String status, String key){
      return new GestureDetector(
        onLongPress: (){},
        onTap: (){},
        child: Column(
          children: [
            SizedBox(height: 20,),
            Container(
              //height: 140, ///Fixed height will cause errors
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20.0)), color: Colors.white, boxShadow: [
                BoxShadow(color: Colors.black.withAlpha(100), blurRadius: 20.0),
              ]),
              child: Column(
                children: [
                  SizedBox(height: 15,),
                  Padding(
                    padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                    child: Text(typeofissue, style: TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold
                    ),),
                  ),
                  Divider(thickness: 2, color: Colors.black,),
                  SizedBox(height: 8,),
                  Padding(
                    padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                    child: Text(description, style: TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w400
                    ),),
                  ),
                  SizedBox(height: 5,),
                  Padding(
                    padding: const EdgeInsets.all(12.0,),
                    child: GestureDetector(
                      onTap: () => setState(() {
                        _launched = _launchInBrowser(locationUrl.toString());
                        print(locationUrl.toString());
                      }),
                      child: Text(locationUrl, style: TextStyle(
                          fontSize: 15, fontWeight: FontWeight.normal, color: Colors.blue
                      ),),
                    ),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0, right: 12.0),
                        child: Text(status, style: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w500,
                          color: Colors.red,
                        ),),
                      ),
                    ],
                  ),
                  SizedBox(height: 15,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 1),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: [
                            /*Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        "Description",
                                        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                                      ),
                                      *//*Text(
                                            post["brand"],
                                            style: const TextStyle(fontSize: 17, color: Colors.grey),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            "\$ ${post["price"]}",
                                            style: const TextStyle(fontSize: 25, color: Colors.black, fontWeight: FontWeight.bold),
                                          )*//*
                                    ],
                                  ),*/
                          ],
                        ),
                        /*Image.asset(
                                  "assets/images/${post["image"]}",
                                  height: double.infinity,
                                )*/
                      ],
                    ),
                  ),
                ],
              ),
            ),

            /*Card(
             child: Column(
               children: <Widget>[
                 Text(
                   typeofissue,
                   style: TextStyle(
                     color: Colors.red,
                     fontStyle: FontStyle.italic,
                     fontSize: 20,
                     fontWeight: FontWeight.bold,
                   ),
                 ),

                 Text(
                   description,
                   style: TextStyle(
                     color: Colors.red,
                     fontStyle: FontStyle.italic,
                     fontSize: 17,
                     fontWeight: FontWeight.bold,
                   ),
                 ),

               ],
             ),
           ),*/
          ],
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: (){
            Navigator.push(context, new MaterialPageRoute(
                builder: (context) =>
                new NewMainpage())
            );
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        title: Text("Public logged issues", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
        backgroundColor: Colors.white38,
        elevation: 0,
      ),
      body: new Container(
        child: list.length == 0?Center(child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(width: 30,),
            /*Text("Currently no data has been found", style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
          ),*/CircularProgressIndicator(),
            SizedBox(
              height: 20,
            ),
            Text("Please wait...", style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,),
            ),

            /*Icon(

            Icons.close,
            color: Colors.black,
            size: 300,
          ),*/
          ],
        )): new ListView.builder(
            itemCount: list.length,
            itemBuilder: (_,index) {
              return UI(list[index].typeofissue, list[index].description, list[index].locationUrl, list[index].area, list[index].status, list[index].key);
            }),
      ),
    );
  }
}
