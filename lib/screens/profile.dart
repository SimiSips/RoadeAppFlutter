/*
import 'package:jra_app/screens/mainpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_geofire/flutter_geofire.dart';

import '../constants.dart';
import 'loginpage.dart';

class ProfilePage extends StatelessWidget {

  static const String id = 'profile';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 40.0,),
              CircleAvatar(
                backgroundColor: Colors.amber ,
                radius: 30,
                child: GestureDetector(
                    onTap:(){
                      Navigator.pushNamedAndRemoveUntil(context, MainPage.id, (route) => false);
                    },
                    child: Icon(Icons.arrow_back, color: Colors.black87,)
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 20.0),
                child: Container(
                  //alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Text(
                      currentUserInfo.fullName.trim(),
                      style: TextStyle(
                          fontSize: 35.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Brand-Bold'
                      ),
                    ),
                  ),
                ),
              ),

              Text(
                "User",
                style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.lightBlueAccent,
                    letterSpacing: 2.5,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Brand-Regular'
                ),
              ),

              SizedBox(
                height: 20,
                width: 200,
                child: Divider(
                  color: Colors.white,
                ),
              ),

              SizedBox(height: 40.0,),

              InfoCard(
                text: currentUserInfo.fullName,
                icon: Icons.person,
                onPressed: () async {
                  print("This is name");
                },
              ),

              InfoCard(
                text: currentUserInfo.phone,
                icon: Icons.phone,
                onPressed: () async {
                  print("This is phone number");
                },
              ),

              InfoCard(
                text: currentUserInfo.email,
                icon: Icons.email,
                onPressed: () async {
                  print("This is email address");
                },
              ),

              *//*

*/
/*InfoCard(
                text: currentUserInfo.homeAdd,
                icon: Icons.home,
                onPressed: () async {
                  print("This is home address");
                },
              ),

              InfoCard(
                text: currentUserInfo.workAdd,
                icon: Icons.work,
                onPressed: () async {
                  print("This is work address");
                },
              ),*//*
*/
/*



              GestureDetector(
                onTap: ()
                {
                  Geofire.removeLocation(currentFirebaseUser.uid);
                  //rideRef.onDisconnect();
                  // rideRef.remove();
                  //rideRef = null;

                  FirebaseAuth.instance.signOut();
                  Navigator.pushNamedAndRemoveUntil(context, LoginPage.id, (route) => false);
                },
                child: Card(
                  color: Colors.amber,
                  margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 110.0),
                  child: ListTile(
                      trailing: Icon(
                        Icons.exit_to_app,
                        color: Colors.black,
                      ),
                      title: Text(
                        "Sign out",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.0,
                          fontFamily: 'Brand-Bold',
                        ),
                      )
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}

class InfoCard extends StatelessWidget
{
  final String text;
  final IconData icon;
  Function onPressed;

  InfoCard({this.text, this.icon, this.onPressed});

  @override
  Widget build(BuildContext context)
  {
    return GestureDetector(
      onTap: onPressed,
      child: Card(
        color: Colors.white,
        margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
        child: ListTile(
          leading: Icon(
            icon,
            color: Colors.black87,
          ),
          title: Text(
            text,
            style: TextStyle(
              color: Colors.black87,
              fontSize: 16.0,
              fontFamily: 'Brand-Bold',
            ),
          ),
        ),
      ),
    );
  }
}
*//*

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:jra_app/constants.dart';
import 'package:jra_app/main.dart';

import 'loginpage.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final usersProfile = FirebaseDatabase.instance.reference().child("users");

  var descriptionController = TextEditingController();
  var emailText;
  var phoneText;
  var nameText;

  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  _initUser() async {
    usersProfile.once().then((DataSnapshot snap) {
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

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          actions: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: GestureDetector(
                onTap: (){
                  databaseRef.reference().child("users")
                      .child("${currentFirebaseUser?.uid}")
                      .child("email").once().then((DataSnapshot snapshot) {
                    print(snapshot.value);
                    print(snapshot.key);
                    setState(() {
                      emailText = snapshot.value;
                    });
                  });

                  databaseRef.reference().child("users")
                      .child("${currentFirebaseUser?.uid}")
                      .child("phone").once().then((DataSnapshot snapshot) {
                    print(snapshot.value);
                    print(snapshot.key);
                    setState(() {
                      phoneText = snapshot.value;
                    });
                  });

                  databaseRef.reference().child("users")
                      .child("${currentFirebaseUser?.uid}")
                      .child("fullname").once().then((DataSnapshot snapshot) {
                    print(snapshot.value);
                    print(snapshot.key);
                    setState(() {
                      nameText = snapshot.value;
                    });
                  });
                },
                  child: Icon(Icons.refresh, size: 35,)),
            ),
          ],
          leading: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          title: Text("Profile", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
          backgroundColor: Colors.white38
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 35.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              //Text("Name", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),),
              Container(
                height: 60,
                margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20.0)), color: Colors.white, boxShadow: [
                  BoxShadow(color: Colors.black.withAlpha(100), blurRadius: 20.0),
                ]),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 18),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: [

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                               nameText ?? "Name",
                                //currentUserInfo!.fullName,//Get name from database
                                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              */
/*Text(
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
                          ),
                          SizedBox(width: 160,),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              */
/*DropdownButton<String>(
                                  value: dropdownValue,
                                  icon: const Icon(Icons.arrow_downward),
                                  iconSize: 24,
                                  elevation: 16,
                                  style: const TextStyle(color: Colors.amber),
                                  onChanged: (String? newValue) {
                                    setState((){
                                      dropdownValue = newValue!;
                                    });
                                  },
                                  items:<String>["One", "Two", "Three", "Four"]
                                      .map<DropdownMenuItem<String>>((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),*//*

                            ],
                          )
                        ],
                      ),
                      */
/*Image.asset(
                          "assets/images/${post["image"]}",
                          height: double.infinity,
                        )*//*

                    ],
                  ),
                ),
              ),

              SizedBox(height: 35.0,),
              Container(
                height: 60,
                margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20.0)), color: Colors.white, boxShadow: [
                  BoxShadow(color: Colors.black.withAlpha(100), blurRadius: 20.0),
                ]),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 18),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: [

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                emailText ?? "Email",//Get email from database
                                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              */
/*Text(
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
                          ),
                          SizedBox(width: 160,),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              */
/*DropdownButton<String>(
                                  value: dropdownValue,
                                  icon: const Icon(Icons.arrow_downward),
                                  iconSize: 24,
                                  elevation: 16,
                                  style: const TextStyle(color: Colors.amber),
                                  onChanged: (String? newValue) {
                                    setState((){
                                      dropdownValue = newValue!;
                                    });
                                  },
                                  items:<String>["One", "Two", "Three", "Four"]
                                      .map<DropdownMenuItem<String>>((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),*//*

                            ],
                          )
                        ],
                      ),
                      */
/*Image.asset(
                          "assets/images/${post["image"]}",
                          height: double.infinity,
                        )*//*

                    ],
                  ),
                ),
              ),
              SizedBox(height: 35.0,),
              Container(
                height: 60,
                margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20.0)), color: Colors.white, boxShadow: [
                  BoxShadow(color: Colors.black.withAlpha(100), blurRadius: 20.0),
                ]),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 18),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: [

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                phoneText ?? "Phone",//Get phone from database
                                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              */
/*Text(
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
                          ),
                          SizedBox(width: 160,),
                          */
/*Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              *//*
*/
/*DropdownButton<String>(
                                  value: dropdownValue,
                                  icon: const Icon(Icons.arrow_downward),
                                  iconSize: 24,
                                  elevation: 16,
                                  style: const TextStyle(color: Colors.amber),
                                  onChanged: (String? newValue) {
                                    setState((){
                                      dropdownValue = newValue!;
                                    });
                                  },
                                  items:<String>["One", "Two", "Three", "Four"]
                                      .map<DropdownMenuItem<String>>((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),*//*
*/
/*
                            ],
                          )*//*

                        ],
                      ),
                      */
/*Image.asset(
                          "assets/images/${post["image"]}",
                          height: double.infinity,
                        )*//*

                    ],
                  ),
                ),
              ),
              SizedBox(height: 50.0,),
              RaisedButton(
                padding: const EdgeInsets.only(left: 90, right: 90, top: 15, bottom: 10,),
                onPressed: ()async {
                */
/*databaseRef.reference().child("users")
                .child("${currentFirebaseUser?.uid}")
                .child("email").once().then((DataSnapshot snapshot) {
                  print(snapshot.value);
                  print(snapshot.key);
                  setState(() {
                    retrievedName = snapshot.value;
                  });
                });*//*


                  */
/*DatabaseReference dbref = FirebaseDatabase.instance.reference().child("Test");
                  dbref.set("IsConnected");*//*

                  //await FirebaseAuth.instance.signOut();
                  _signOut();
                  Navigator.of(context).pop();
                  Navigator.pushNamedAndRemoveUntil(context, LoginPage.id, (route) => false);
                },
                elevation: 9,
                color: Colors.amber,
                child: Container(
                  height: 30,
                  child: Text("Logout", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                ),
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(22)
                ),
              ),
              SizedBox(height: 20.0,),
              //Text(retrievedName ?? "Test"),

            ],
          ),
        ),
      ),
    );
  }
}
*/

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
//import 'package:jra_app/datamodels/modelClass.dart';
//import 'package:jra_app/datamodels/publicModelClass.dart';
import 'package:jra_app/datamodels/userModel.dart';
import 'package:jra_app/screens/ReportPages/generalreport.dart';
import 'package:jra_app/screens/homepage.dart';
import 'package:jra_app/screens/newmainpage.dart';

import '../constants.dart';
import 'loginpage.dart';

class ProfilePage extends StatefulWidget {
  static const String id = 'profile';
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final usersRef = FirebaseDatabase.instance.reference().child("users").child("${currentFirebaseUser?.uid}");
  List<Model> list = [];
  @override

  void initState() {
    super.initState();
    _initUser().whenComplete((){
      setState(() {
        _initUser();
      });
    });
  }

  _initUser() async {
    usersRef.once().then((DataSnapshot snap) {
      var data = snap.value;
      list.clear();
      data.forEach((key,value) {
        Model usersProfile = new Model(
          fullname: value['fullname'],
          email: value['email'],
          phone: value['phone'],
          key: key,
        );

        list.add(usersProfile);
      });
      setState(() {

      });
    });
  }

  Widget build(BuildContext context) {
    Widget UI(String fullname, String email, String phone, String key){
      return Center(
        child: new GestureDetector(
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
                    /*SizedBox(height: 15,),
                    Padding(
                      padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                      child: Text(fullname, style: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold
                      ),),
                    ),
                    SizedBox(height: 15,),
                    Padding(
                      padding: const EdgeInsets.all(12.0,),
                      child: Text(email, style: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold
                      ),),
                    ),
                    SizedBox(height: 20,),
                    Padding(
                      padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                      child: Text(phone, style: TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w400,
                        color: Colors.red,
                      ),),
                    ),*/
                    SizedBox(height: 10,),
                    Container(
                      height: 40,
                      margin: const EdgeInsets.symmetric(
                           horizontal: 15,vertical: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                              Radius.circular(20.0)),
                          color: Colors.amber,
                          boxShadow: [
                            BoxShadow(color: Colors.black.withAlpha(100),
                                blurRadius: 10.0),
                          ]),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 0, vertical: 1),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            //crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[

                              Row(
                                //mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Column(
                                    children: <Widget>[
                                      Text(fullname, style: TextStyle(
                                        fontWeight: FontWeight.bold, fontSize: 15
                                      ),)
                                    ],
                                  ),
                                ],
                              ),

                              /*Image.asset(
                                "assets/images/${post["image"]}",
                                height: double.infinity,
                              )*/
                            ],
                          ),
                        ),
                      ),

                    ),
                    SizedBox(height: 5,),
                    Container(
                      height: 40,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 15,vertical: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                              Radius.circular(20.0)),
                          color: Colors.amber,
                          boxShadow: [
                            BoxShadow(color: Colors.black.withAlpha(100),
                                blurRadius: 10.0),
                          ]),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 0, vertical: 1),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            //crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[

                              Row(
                                //mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Column(
                                    children: <Widget>[
                                      Text(email, style: TextStyle(
                                          fontWeight: FontWeight.bold, fontSize: 15
                                      ),)
                                    ],
                                  ),
                                ],
                              ),

                              /*Image.asset(
                                "assets/images/${post["image"]}",
                                height: double.infinity,
                              )*/
                            ],
                          ),
                        ),
                      ),

                    ),
                    SizedBox(height: 5,),
                    Container(
                      height: 40,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 15,vertical: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                              Radius.circular(20.0)),
                          color: Colors.amber,
                          boxShadow: [
                            BoxShadow(color: Colors.black.withAlpha(100),
                                blurRadius: 10.0),
                          ]),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 0, vertical: 1),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            //crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[

                              Row(
                                //mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Column(
                                    children: <Widget>[
                                      Text(phone, style: TextStyle(
                                          fontWeight: FontWeight.bold, fontSize: 15
                                      ),)
                                    ],
                                  ),
                                ],
                              ),

                              /*Image.asset(
                                "assets/images/${post["image"]}",
                                height: double.infinity,
                              )*/
                            ],
                          ),
                        ),
                      ),

                    ),
                    SizedBox(height: 10,),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 1),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20,),
              RaisedButton(
                padding: const EdgeInsets.only(
                  left: 90, right: 90, top: 15, bottom: 10,),
                onPressed: () async{
                  FirebaseAuth auth = FirebaseAuth.instance;
                  auth.signOut().then((res) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  });
                },
                elevation: 9,
                color: Colors.black,
                child: Container(
                  height: 30,
                  child: Text("Log out",
                    style: TextStyle(
                        fontSize: 18, fontWeight: FontWeight
                        .bold, color: Colors.white),),
                ),
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30)
                ),
              ),
            ],
          ),
        ),
      );
    }
    return Scaffold(
      backgroundColor: Colors.amber,
      appBar: AppBar(
        foregroundColor: Colors.amber,
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
        /*actions: [
          GestureDetector(
            onTap: (){
              print("General");
              //Navigator.pushNamedAndRemoveUntil(context, HomePage.id, (route) => false);
              //Navigator.of(context).push(new MaterialPageRoute(builder: (context) => HomePage()));
            },
            child: Icon(
              Icons.refresh,
              size: 40,
              color: Colors.black,
            ),
          ),
        ],*/
        title: Text("Profile", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
        backgroundColor: Colors.amber,
        elevation: 0,
      ),
      body: new Container(
        child: list.length == 0 ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(width: 30,),
            /*Text("Currently no data has been found", style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
          ),*/
                CircularProgressIndicator(),
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
        )) : new ListView.builder(
            itemCount: list.length,
            itemBuilder: (_,index) {
              return UI(list[index].fullname, list[index].email, list[index].phone, list[index].key);
            }),
      ),
    );
  }
}

