import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:jra_app/datamodels/ticketsClass.dart';
import 'package:jra_app/screens/mainpage.dart';
import 'package:jra_app/screens/newmainpage.dart';
import 'package:jra_app/widgets/Dialog.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share/share.dart';

import '../../constants.dart';

class TicketsLogged extends StatefulWidget {
  static const String id = 'ticketslogged';
  const TicketsLogged({Key? key}) : super(key: key);

  @override
  _TicketsLoggedState createState() => _TicketsLoggedState();
}

class _TicketsLoggedState extends State<TicketsLogged> {
  final userReports = FirebaseDatabase.instance.reference().child("issueslogged").child("${currentFirebaseUser?.uid}").child("Reports");
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
    userReports.once().then((DataSnapshot snap) {
      var data = snap.value;
      list.clear();
      data.forEach((key,value) {
        Model model = new Model(
          description: value['description'],
          typeofissue: value['typeofissue'],
          receptnumber: value['recieptnumber'],
          wardnumber: value['wardnumber'],
          wardcounciler: value['wardcounciler'],
          status: value['status'],
          //time: value['time'],
          //date: value['date'],
          locationUrl: value["locationUrl"],
          photoUrl: value['imageUrl'],
          key: key,
        );

        list.add(model);
      });
      setState(() {

      });
    });
  }



  Widget build(BuildContext context) {
    Widget UI(
        String typeofissue,
        String description,
        String recieptnumber,
        String wardnumber,
        String wardcounciler,
        String locationUrl,
        String photoUrl,
        String status,
        String key
        ){
      return new GestureDetector(
        onLongPress: (){},
        onTap: (){},
        child: Column(
          children: [
            SizedBox(height: 20,),
            Container(
              //height: 140, ///Fixed height will cause errors
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10.0)), color: Colors.white, boxShadow: [
                BoxShadow(color: Colors.black.withAlpha(100), blurRadius: 20.0),
              ]),
              child: Column(
                children: [
                  SizedBox(height: 15,),
                  Container(
                    height: 60,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                            Radius.circular(25.0)),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(color: Colors.black.withAlpha(65),
                              blurRadius: 15.0),
                        ]),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0, left: 1.0, right: 1.0),
                          child: Text('# $description', style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold, color: Colors.amber
                          ),),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment
                                .spaceBetween,
                            children: <Widget>[
                              Row(
                                children: [
                                ],
                              ),

                            ],
                          ),
                        ),
                      ],
                    ),
                  ), ///Reciept Number
                  SizedBox(height: 30,),
                  Padding(
                    padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                    child: Text('Ward Number:', style: TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold
                    ),),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                      child: Text(wardnumber, style: TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w400
                      ),),
                  ),
                  SizedBox(height: 20,),
                  Padding(
                    padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                    child: Text('Ward Counciler:', style: TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold
                    ),),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                    child: Text(wardcounciler, style: TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w400
                    ),),
                  ),
                  SizedBox(height: 20,),
                  Padding(
                    padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                    child: Text('Description:', style: TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold
                    ),),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                    child: Text(recieptnumber , style: TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w400
                    ),),
                  ),
                  SizedBox(height: 20,),
                  Padding(
                    padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                    child: Text('Location:', style: TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold
                    ),),
                  ),
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
                  SizedBox(height: 20,),
                  Padding(
                    padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                    child: Text('Picture URL:', style: TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold
                    ),),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0,),
                    child: GestureDetector(
                      onTap: () => setState(() {
                        _launched = _launchInBrowser(photoUrl.toString());
                        print(photoUrl.toString());
                      }),
                      child: Text(photoUrl, style: TextStyle(
                          fontSize: 15, fontWeight: FontWeight.normal, color: Colors.blue
                      ),),
                    ),
                  ),
                  SizedBox(height: 10,),
                  /*Padding(
                    padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                    child: Text('Date & Time:', style: TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold
                    ),),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                    child: Text('08/08/2020 13:30', style: TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w400
                    ),),
                  ),*/
                  SizedBox(height: 25,),
                  Row(
                    children: [
                      Expanded(child: RaisedButton(
                        padding: const EdgeInsets.only(
                          left: 20, right: 20, top: 15, bottom: 10,),
                        onPressed: () {
                          if(status.toString() == 'Incomplete'){
                            status = 'Your ticket has not been assigned yet, please check again later';
                          } else if (status == 'Complete'){
                            status = 'Your ticket has been closed. Thank you for helping us find the problem.';
                          } else {
                            status = 'Your ticket has been assigned and is in progress';
                          }
                          showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (BuildContext context) => WaitDialog(
                                heading: 'Status',
                                status: status,)
                          );
                        },
                        elevation: 10,
                        color: Colors.amber,
                        child: Container(
                          height: 25,
                          child: Text("View Status",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight
                                .bold),),
                        ),
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30)
                        ),
                      ),),
                      Expanded(
                        child: RaisedButton(
                          padding: const EdgeInsets.only(
                            left: 30, right: 30, top: 15, bottom: 10,),
                          onPressed: () {
                            Share.share("wardcounciler + wardcounciler + description + locationUrl + photoUrl");
                            //Share(context, logged);
                          },
                          //onPressed: () => share(context, logged),
                          elevation: 10,
                          color: Colors.amber,
                          child: Container(
                            height: 25,
                            child: Text("Share",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight
                                  .bold),),
                          ),
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30)
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 1),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: [
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.0,),
                ],
              ),
            ),
          ],
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
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
        title: Text("All logged tickets", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
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
              return UI(list[index].typeofissue, list[index].receptnumber, list[index].description, list[index].wardnumber, list[index].wardcounciler, list[index].locationUrl, list[index].photoUrl, list[index].status, list[index].key);
            }),
      ),
    );
  }

  /*void share(BuildContext context, logged){
    final String text = "test string";
    Share.share(text);
  }*/
}
