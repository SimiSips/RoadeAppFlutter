

import 'package:jra_app/screens/loginpage.dart';
import 'package:jra_app/screens/mainpage.dart';
import 'package:jra_app/screens/newmainpage.dart';
import 'package:jra_app/widgets/ProgressDialog.dart';
import 'package:jra_app/widgets/TaxiButton.dart';
//import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'mainpage.dart';

class RegisterPage extends StatefulWidget {

  static const String id = 'register';

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  void showSnackBar(String title){
    final snackbar = SnackBar(
      content: Text(title, textAlign: TextAlign.center, style: TextStyle(fontSize: 15),),
    );
    //scaffoldKey.currentState.showSnackBar(snackbar);
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }


  final FirebaseAuth _auth = FirebaseAuth.instance;

  var fullNameController = TextEditingController();

  var phoneController = TextEditingController();

  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  var confPasswordController = TextEditingController();

  void registerUser() async {

    //show please wait dialog
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => ProgressDialog(status: 'Registering you...',),
    );

    final User? user = (await _auth.createUserWithEmailAndPassword(
      email: emailController.text,
      password: passwordController.text,
    ).catchError((ex){

      //check error and display message
      Navigator.pop(context);
      PlatformException thisEx = ex;
      //showSnackBar(thisEx.message);

    })).user;

    Navigator.pop(context);
    // check if user registration is successful
    if(user != null){

      DatabaseReference newUserRef = FirebaseDatabase.instance.reference().child('users/${user.uid}/profile');

      //Prepare data to be saved on users table
      Map userMap = {
        'fullname': fullNameController.text,
        'email': emailController.text,
        'phone': phoneController.text,
      };

      newUserRef.set(userMap);

      //Take the user to the mainPage
      //Navigator.pushNamedAndRemoveUntil(context, NewMainpage.id, (route) => false);
      Navigator.push(context, new MaterialPageRoute(
          builder: (context) =>
          new NewMainpage())
      );
    }
  }
  bool _obscureText = true;
  bool _obscureTextConf = true;

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }
  void _toggleConf() {
    setState(() {
      _obscureTextConf = !_obscureTextConf;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                SizedBox(height: 70,),
                Image(
                  alignment: Alignment.center,
                  height: 150.0,
                  width: 150.0,
                  image: AssetImage('assets/images/logo.png'),
                ),

                SizedBox(height: 40,),

                Text('REGISTER',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                ),

                Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                                Radius.circular(20.0)),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(color: Colors.black.withAlpha(100),
                                  blurRadius: 20.0),
                            ]),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 12.0, right: 12.0, top: 2),
                              child: TextFormField(
                                controller: fullNameController,
                                style: TextStyle(fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 20),
                                cursorColor: Colors.black,
                                decoration: new InputDecoration(
                                  icon: const Padding(
                                      padding: const EdgeInsets.only(top: 0),
                                      child: const Icon(Icons.person, color: Colors.black,)),
                                  border: InputBorder.none,
                                  hintText: "Full Name",
                                  hintStyle: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10,),
                      Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                                Radius.circular(20.0)),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(color: Colors.black.withAlpha(100),
                                  blurRadius: 20.0),
                            ]),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 12.0, right: 12.0, top: 2),
                              child: TextFormField(
                                controller: emailController,
                                style: TextStyle(fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 20),
                                cursorColor: Colors.black,
                                decoration: new InputDecoration(
                                  icon: const Padding(
                                      padding: const EdgeInsets.only(top: 0),
                                      child: const Icon(Icons.email, color: Colors.black,)),
                                  border: InputBorder.none,
                                  hintText: "Email",
                                  hintStyle: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10,),
                      Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                                Radius.circular(20.0)),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(color: Colors.black.withAlpha(100),
                                  blurRadius: 20.0),
                            ]),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 12.0, right: 12.0, top: 2),
                              child: TextFormField(
                                controller: phoneController,
                                style: TextStyle(fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 20),
                                cursorColor: Colors.black,
                                decoration: new InputDecoration(
                                  icon: const Padding(
                                      padding: const EdgeInsets.only(top: 0),
                                      child: const Icon(Icons.phone, color: Colors.black,)),
                                  border: InputBorder.none,
                                  hintText: "Phone number",
                                  hintStyle: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10,),
                      Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                                Radius.circular(20.0)),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(color: Colors.black.withAlpha(100),
                                  blurRadius: 20.0),
                            ]),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 12.0, right: 12.0, top: 2),
                              child: TextFormField(
                                controller: passwordController,
                                style: TextStyle(fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 20),
                                cursorColor: Colors.black,
                                obscureText: _obscureText,
                                decoration: new InputDecoration(
                                  icon: GestureDetector(
                                    onTap: (){
                                      _toggle();
                                      //hide = false;
                                      print(_obscureText ? "Show" : "Hide");
                                    },
                                    child: const Padding(
                                        padding: const EdgeInsets.only(top: 0),
                                        child: const Icon(Icons.remove_red_eye, color: Colors.black,)),
                                  ),
                                  border: InputBorder.none,
                                  hintText: "Password",
                                  hintStyle: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10,),
                      Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                                Radius.circular(20.0)),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(color: Colors.black.withAlpha(100),
                                  blurRadius: 20.0),
                            ]),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 12.0, right: 12.0, top: 2),
                              child: TextFormField(
                                controller: confPasswordController,
                                style: TextStyle(fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 20),
                                cursorColor: Colors.black,
                                obscureText: _obscureTextConf,
                                decoration: new InputDecoration(
                                  icon: GestureDetector(
                                    onTap: (){
                                      _toggleConf();
                                      //hide = false;
                                      print(_obscureTextConf ? "Show" : "Hide");
                                    },
                                    child: const Padding(
                                        padding: const EdgeInsets.only(top: 0),
                                        child: const Icon(Icons.remove_red_eye, color: Colors.black,)),
                                  ),
                                  border: InputBorder.none,
                                  hintText: "Confirm Password",
                                  hintStyle: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 40,),
                      RaisedButton(
                        padding: const EdgeInsets.only(
                          left: 90, right: 90, top: 15, bottom: 10,),
                        onPressed: () async{

                          //check network availability

                          /*var connectivityResult = await Connectivity().checkConnectivity();
                          if(connectivityResult != ConnectivityResult.mobile && connectivityResult != ConnectivityResult.wifi){
                            showSnackBar('No internet connectivity');
                            return;
                          }*/

                          if(fullNameController.text.length < 3){
                            showSnackBar('Please provide a valid fullname');
                            return;
                          }

                          if(phoneController.text.length < 10){
                            showSnackBar('Please provide a valid phone number');
                            return;
                          }

                          if(!emailController.text.contains('@')){
                            showSnackBar('Please provide a valid email address');
                            return;
                          }
                          if(!emailController.text.contains('.com')){
                            showSnackBar('Please provide a valid email address');
                            return;
                          }

                          if(passwordController.text.length < 8){
                            showSnackBar('Password must be at least 8 characters');
                            return;
                          }
                          if(passwordController.text == confPasswordController){
                            showSnackBar('Passwords must be the same');
                            return;
                          }

                          if(passwordController.text.length < 8){
                            showSnackBar('Password must be at least 8 characters');
                            return;
                          }

                          registerUser();

                        },
                        elevation: 9,
                        color: Colors.amber,
                        child: Container(
                          height: 30,
                          child: Text("REGISTER",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight
                                .bold),),
                        ),
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30)
                        ),
                      ),

                    ],
                  ),
                ),

                FlatButton(
                    onPressed: (){
                      Navigator.push(context, new MaterialPageRoute(
                          builder: (context) =>
                          new LoginPage())
                      );
                    },
                    child: Text('Already have a Roade App account? Log in')
                ),
                
                Text('\u00a9 2021 Brain Cap Developers'),


              ],
            ),
          ),
        ),
      ),
    );
  }
}
