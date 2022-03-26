
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jra_app/screens/newmainpage.dart';

import '../constants.dart';
import 'loginpage.dart';

class ProfilePageFirebase extends StatelessWidget {

  static const String id = 'profilepagefirebase';

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
                      Navigator.pushNamedAndRemoveUntil(context, NewMainpage.id, (route) => false);
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
                      currentFirebaseUser?.email ?? 'Email',
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

              /*InfoCard(
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
                text: currentUserInfo!.email,
                icon: Icons.email,
                onPressed: () async {
                  print("This is email address");
                },
              ),*/

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
              ),*/


              GestureDetector(
                onTap: ()
                {
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

/*class InfoCard extends StatelessWidget
{
  final String text;
  final IconData icon;
  Function onPressed;

  InfoCard({required this.text, required this.icon, required this.onPressed});

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
}*/
