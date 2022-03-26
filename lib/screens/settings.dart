import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:jra_app/datamodels/modelClass.dart';
import 'package:jra_app/screens/mainpage.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants.dart';
import 'loginpage.dart';
import 'newmainpage.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final userReports = FirebaseDatabase.instance.reference().child("issueslogged").child("${currentFirebaseUser?.uid}").child("Reports");
  List<Model> list = [];
  Future<void>? _launched;

  var completeImage = 'assets/images/incomplete.png';

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
    userReports.once().then((DataSnapshot snap) {
      var data = snap.value;
      list.clear();
      data.forEach((key,value) {
        Model model = new Model(
          description: value['description'],
          typeofissue: value['typeofissue'],
          status: value['status'],
          locationUrl: value["locationUrl"],
          key: key,
        );

        list.add(model);
      });
      setState(() {

      });
    });
  }



  Widget build(BuildContext context) {
    Widget UI(String typeofissue, String description, String locationUrl, String status, String key){
      if(status == 'in progress'){
        var complete = 'assets/images/inprogress.png';
        completeImage = complete;
      } else if(status == 'Incomplete'){
        var complete = 'assets/images/incomplete.png';
        completeImage = complete;
      } else {
        var complete = 'assets/images/complete.png';
        completeImage = complete;
      }
      return new GestureDetector(
       onLongPress: (){},
       onTap: (){},
       child: Column(
         children: [
           SizedBox(height: 20,),
           Container(
             //height: 140, ///Fixed height will cause errors
             margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
             decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20.0)), color: Colors.black, boxShadow: [
               BoxShadow(color: Colors.black.withAlpha(100), blurRadius: 20.0),
             ]),
             child: Column(
               children: [
                 //SizedBox(height: 15,),

                 Row(
                   children: [
                     Expanded(child: Image.asset(completeImage, scale: 1.5,),),
                     Expanded(
                       child: Padding(
                         padding: const EdgeInsets.only(left: 0, right: 0),
                         child: Text(typeofissue, style: TextStyle(
                             fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white
                         ),),
                       ),
                     ),
                   ],
                 ),
                 //Divider(thickness: 2, color: Colors.black,),
                 //SizedBox(height: 8,),
                 Padding(
                   padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                   child: Text(description, style: TextStyle(
                       fontSize: 20, fontWeight: FontWeight.w400, color: Colors.white
                   ),),
                 ),
                 SizedBox(height: 5,),
                 Padding(
                   padding: const EdgeInsets.all(12.0,),
                   child: GestureDetector(
                     /*onTap: () => setState(() {
                          _launched = _launchInBrowser(locationUrl.toString());
                          print(locationUrl.toString());
                        }),*/
                     child: Column(
                       children: [
                         ElevatedButton(
                             onPressed: () => setState(() {
                               _launched = _launchInBrowser(locationUrl.toString());
                               print(locationUrl.toString());
                             }),
                             child: Text('Location')),
                         Text(locationUrl, style: TextStyle(
                             fontSize: 2, fontWeight: FontWeight.normal, color: Colors.black
                         ),),
                       ],
                     ),
                   ),
                 ),
                 /*Row(
                   children: [
                     Padding(
                       padding: const EdgeInsets.only(left: 20.0, right: 12.0),
                       child: Text(status, style: TextStyle(
                         fontSize: 20, fontWeight: FontWeight.w500,
                         color: Colors.red,
                       ),),
                     ),
                     SizedBox(width: 20,),
                     Padding(
                       padding: const EdgeInsets.only(left: 20.0, right: 12.0),
                       child: GestureDetector(
                         onTap: (){
                           userReports.child("Reports").child(key)
                               .remove();
                               //.whenComplete(() => Navigator.pushNamedAndRemoveUntil(context, MainPage.id, (route) => false));
                         },
                         child: Text("Delete", style: TextStyle(
                           fontSize: 20, fontWeight: FontWeight.w500,
                           color: Colors.red,
                         ),),
                       ),
                     ),
                   ],
                 ),*/
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
           /*Container(
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
                       fontSize: 25, fontWeight: FontWeight.bold
                   ),),
                 ),
                 SizedBox(height: 15,),
                 Divider(
                   thickness: 2,
                   color: Colors.black,
                 ),
                 Padding(
                   padding: const EdgeInsets.all(12.0,),
                   child: Text(description, style: TextStyle(
                     fontSize: 20, fontWeight: FontWeight.w400
                   ),),
                 ),
                 SizedBox(height: 15,),
                 Padding(
                   padding: const EdgeInsets.all(12.0,),
                   child: GestureDetector(
                     onTap: (){

                       print("tapped");
                     },
                     child: Text(locationUrl, style: TextStyle(
                         fontSize: 15, fontWeight: FontWeight.normal, color: Colors.blue
                     ),),
                   ),
                 ),
                 SizedBox(height: 20,),
                 Padding(
                   padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                   child: Text(status, style: TextStyle(
                       fontSize: 20, fontWeight: FontWeight.w400,
                        color: Colors.red,
                   ),),
                 ),
                 SizedBox(height: 15,),
                 Padding(
                   padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 1),
                   child: Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: <Widget>[
                       Row(
                         children: [
                           *//*Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        "Description",
                                        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                                      ),
                                      *//**//*Text(
                                            post["brand"],
                                            style: const TextStyle(fontSize: 17, color: Colors.grey),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            "\$ ${post["price"]}",
                                            style: const TextStyle(fontSize: 25, color: Colors.black, fontWeight: FontWeight.bold),
                                          )*//**//*
                                    ],
                                  ),*//*
                         ],
                       ),
                       *//*Image.asset(
                                  "assets/images/${post["image"]}",
                                  height: double.infinity,
                                )*//*
                     ],
                   ),
                 ),
               ],
             ),
           ),*/

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
      backgroundColor: Colors.amber,
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
          title: Text("Your logged issues", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
          backgroundColor: Colors.amber,
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
            return UI(list[index].typeofissue, list[index].description, list[index].locationUrl, list[index].status, list[index].key);
          }),
    ),
    );
  }
}
