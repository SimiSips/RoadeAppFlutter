//import 'package:agconnect_crash/agconnect_crash.dart';
import 'package:jra_app/screens/mainpage.dart';
//import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jra_app/screens/newmainpage.dart';
import 'package:jra_app/screens/registerpage.dart';
import 'package:jra_app/widgets/ProgressDialog.dart';

class LoginPage extends StatefulWidget {

  static const String id = 'login';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();


  void showSnackBar(String title){
    final snackbar = SnackBar(
      content: Text(title, textAlign: TextAlign.center, style: TextStyle(fontSize: 15),),
    );
    //scaffoldKey.currentState.showSnackBar(snackbar);
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;

  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  bool _obscureText = true;
  //var test = true;

  void login() async {
    //_enableCollection();
    //_testCrash();

    //show please wait dialog
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => ProgressDialog(status: 'Logging in',)
    );



    final User? user = (await _auth.signInWithEmailAndPassword(
      email: emailController.text,
      password: passwordController.text,
    ).catchError((ex){

      //check error and display message
      Navigator.pop(context);
      PlatformException thisEx = ex;
      //showSnackBar(thisEx.message);

    })).user;

    if(user != null){
      // verify login
      DatabaseReference userRef = FirebaseDatabase.instance.reference().child('users/${user.uid}');
      userRef.once().then((DataSnapshot snapshot) {

        if(snapshot.value != null){
          Navigator.pushNamedAndRemoveUntil(context, NewMainpage.id, (route) => false);
        }
      });

    }

  }
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
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

                Text('LOGIN',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                ),

                Padding(
                  padding: EdgeInsets.all(10.0),
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
                            /*GestureDetector(
                              onTap: (){
                                _toggle();
                                //hide = false;
                                print(_obscureText ? "Show" : "Hide");
                              },
                                child: Icon(Icons.remove_red_eye)),*/
                          ],
                        ),
                      ),
                      SizedBox(height: 40,),
                      RaisedButton(
                        padding: const EdgeInsets.only(
                          left: 90, right: 90, top: 15, bottom: 10,),
                        onPressed: () async {
                          /*_testCrash();
                          _enableCollection();*/

                          //check network availability

                          /*var connectivityResult = await Connectivity().checkConnectivity();
                          if(connectivityResult != ConnectivityResult.mobile && connectivityResult != ConnectivityResult.wifi){
                            showSnackBar('No internet connectivity');
                            return;
                          }*/

                          if(!emailController.text.contains('@')){
                            showSnackBar('Please enter a valid email address');
                            return;
                          }
                          if(!emailController.text.contains('.com')){
                            showSnackBar('Please enter a valid email address');
                            return;
                          }

                          if(passwordController.text.length < 8){
                            showSnackBar('Please enter a valid password');
                            return;
                          }

                          login();

                        },
                        elevation: 9,
                        color: Colors.amber,
                        child: Container(
                          height: 30,
                          child: Text("LOGIN",
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
                          new RegisterPage())
                      );
                    },
                    child: Text('Don\'t have an account, sign up here')
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