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
*/
//import 'dart:html';

import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:jra_app/constants.dart';
import 'package:jra_app/screens/TicketsLogged/TicketLoggedPage.dart';
import 'package:jra_app/screens/TicketsLogged/TicketsLogged.dart';
import 'package:jra_app/widgets/Dialog.dart';
import 'package:jra_app/widgets/ProgressDialog.dart';
import 'package:jra_app/screens/mapPage.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

import '../mainpage.dart';
import '../newmainpage.dart';

class PotholePage extends StatefulWidget {
  static const String id = 'potholereport';
  const PotholePage({Key? key}) : super(key: key);

  @override
  _PotholePageState createState() => _PotholePageState();
}

class _PotholePageState extends State<PotholePage> {

  /*File? _image;
   String? _uploadedFileUrl;
*/
  var generalNo = 0 +1;
  var descriptionController = TextEditingController();
  var typeofissueController = TextEditingController();
  var locationController = TextEditingController();
  var wardnumbercontroller = TextEditingController();
  var wardcouncilercontroller = TextEditingController();
  //DateTime now = DateTime.now();
  //String formattedDate = DateFormat('kk:mm:ss EEE d MMM') as String;

  get heading => typeofissueController.text;

  get type => "General $generalNo";

  get locationUrl => "https://www.google.com/maps/search/?api=1&query=${_currentPosition!.latitude}%2C${_currentPosition!.longitude}";

  get area => _currentAddress;

  get status => "Incomplete";
  String fileName = Uuid().v4();


  void submitIssuePersonal() async {

    // check if user registration is successful

    DatabaseReference issuesPersonRef = FirebaseDatabase.instance.reference().child('issueslogged/${currentFirebaseUser!.uid}/Reports/$fileName');


    setState(() {
      generalNo++;
    });

    //Prepare data to be saved on users table
    Map userMap = {
      'description': descriptionController.text,
      'typeofissue': typeofissueController.text,
      'wardnumber': wardnumbercontroller.text,
      'wardcounciler': wardcouncilercontroller.text,
      'recieptnumber': fileName,
      'imageUrl': imageUrl,
      'locationUrl': locationUrl.toString(),
      'area': area.toString(),
      'status': status,
    };

    issuesPersonRef.set(userMap);

    //Take the user to the mainPage
    Navigator.push(context, new MaterialPageRoute(
        builder: (context) =>
        new TicketLoggedPage())
    );


  }
  void submitIssueGlobal() async {

    // check if user registration is successful


    DatabaseReference issuesGlobalRef = FirebaseDatabase.instance.reference().child('global/Reports/Pothole/$fileName');

    setState(() {
      generalNo++;
    });

    //Prepare data to be saved on users table
    Map userMap = {
      'description': descriptionController.text,
      'typeofissue': typeofissueController.text,
      'area': area.toString(),
      'wardnumber': wardnumbercontroller.text,
      'wardcounciler': wardcouncilercontroller.text,
      'locationUrl': locationUrl.toString(),
      'status': status,
    };

    issuesGlobalRef.set(userMap);
    submitIssuePersonal();

    //Take the user to the mainPage
    Navigator.push(context, new MaterialPageRoute(
        builder: (context) =>
        new TicketLoggedPage())
    );


  }

  Position? _currentPosition;
  String? _currentAddress;

  String? imageUrl;
  String postID = Uuid().v1();

  uploadImage() async {
    final _firebaseStorage = FirebaseStorage.instance;
    final _imagePicker = ImagePicker();
    PickedFile image;
    //Check Permissions
    await Permission.photos.request();

    var permissionStatus = await Permission.photos.status;

    if (permissionStatus.isGranted){
      //Select Image
      image = (await _imagePicker.getImage(source: ImageSource.camera))!;
      var file = File(image.path);

      if (image != null){
        //Upload to Firebase
        var snapshot = await _firebaseStorage.ref()
            .child('${currentFirebaseUser?.uid}/images/Reciept No - ${fileName}/${postID}')
            .putFile(file);
        var downloadUrl = await snapshot.ref.getDownloadURL();
        print(downloadUrl);
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) => WaitDialog(heading: 'Success', status: 'Your file has been uploaded',),
        );
        setState(() {
          imageUrl = downloadUrl;
        });

      } else {
        print('No Image Path Received');
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) => WaitDialog(heading: 'Failed', status: 'Your file has not been uploaded',),
        );
      }
    } else {
      print('Permission not granted. Try Again with permission access');
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) => WaitDialog(heading: 'Failed', status: 'Permission not granted. Try Again with permission access',),
      );
    }
  }

  uploadImageGallery() async {
    final _firebaseStorage = FirebaseStorage.instance;
    final _imagePicker = ImagePicker();
    PickedFile image;
    //Check Permissions
    await Permission.photos.request();

    var permissionStatus = await Permission.photos.status;

    if (permissionStatus.isGranted){
      //Select Image
      image = (await _imagePicker.getImage(source: ImageSource.gallery))!;
      var file = File(image.path);

      if (image != null){
        //Upload to Firebase
        var snapshot = await _firebaseStorage.ref()
            .child('${currentFirebaseUser?.uid}/images/Reciept No - ${fileName}/${postID}')
            .putFile(file);
        var downloadUrl = await snapshot.ref.getDownloadURL();
        print(downloadUrl);
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) => WaitDialog(heading: 'Success', status: 'Your file has been uploaded',),
        );
        setState(() {
          imageUrl = downloadUrl;
        });

      } else {
        print('No Image Path Received');
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) => WaitDialog(heading: 'Failed', status: 'Your file has not been uploaded',),
        );
      }
    } else {
      print('Permission not granted. Try Again with permission access');
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) => WaitDialog(heading: 'Failed', status: 'Permission not granted. Try Again with permission access',),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _getCurrentLocation().whenComplete((){
      setState(() {});
    });
    _getAddressFromLatLng().whenComplete((){
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          return Scaffold(
            backgroundColor: Colors.amber,
            appBar: AppBar(
                elevation: 0,
                leading: GestureDetector(
                  onTap: () {
                    //Navigator.pushNamedAndRemoveUntil(context, MainPage.id, (route) => false);
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
                title: Text("Report your issue",
                  style: TextStyle(
                      fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black),),
                backgroundColor: Colors.amber
            ),
            body: Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [

                    Container(
                      height: 60,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                              Radius.circular(20.0)),
                          color: Colors.black,
                          boxShadow: [
                            BoxShadow(color: Colors.black.withAlpha(100),
                                blurRadius: 20.0),
                          ]),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 12.0, right: 12.0, top: 5),
                            child: TextFormField(
                              controller: typeofissueController,
                              style: TextStyle(fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 20),
                              cursorColor: Colors.white,
                              decoration: new InputDecoration(
                                border: InputBorder.none,
                                hintText: "Type of issue",
                                hintStyle: TextStyle(fontSize: 20.0, color: Colors.white),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 0, vertical: 0),
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
                    ),
                    GestureDetector(
                      onTap: (){
                        print(imageUrl);
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(width: 30.0,),
                          Text('Click here for info on your ward number'),
                          SizedBox(width: 10.0,),
                          Icon(
                            Icons.info,
                          ),
                        ],
                      ),
                    ),
                    //SizedBox(height: 15.0,),
                    Container(
                      height: 60,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                              Radius.circular(20.0)),
                          color: Colors.black,
                          boxShadow: [
                            BoxShadow(color: Colors.black.withAlpha(100),
                                blurRadius: 20.0),
                          ]),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 12.0, right: 12.0, top: 5),
                            child: TextFormField(
                              controller: wardnumbercontroller,
                              style: TextStyle(fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 20),
                              cursorColor: Colors.white,
                              decoration: new InputDecoration(
                                border: InputBorder.none,
                                hintText: "Ward number",
                                hintStyle: TextStyle(fontSize: 20.0, color: Colors.white),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 0, vertical: 0),
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
                    ),
                    GestureDetector(
                      onTap: (){
                        showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (BuildContext context) => WaitDialog(
                              heading: 'Ward Councilers names',
                              status: 'Simphiwe Radebe - Ward 1\n'
                                  'Simphiwe Radebe - Ward 2\n'
                                  'Simphiwe Radebe - Ward 3\n'
                                  'Simphiwe Radebe - Ward 4\n'
                                  'Simphiwe Radebe - Ward 5\n'
                                  'Simphiwe Radebe - Ward 6\n'
                                  'Simphiwe Radebe - Ward 7\n'
                                  'Simphiwe Radebe - Ward 8\n'
                                  'Simphiwe Radebe - Ward 9\n'
                                  'Simphiwe Radebe - Ward 10\n'
                                  'Simphiwe Radebe - Ward 11\n'
                                  'Simphiwe Radebe - Ward 12\n'
                                  'Simphiwe Radebe - Ward 13\n'
                                  'Simphiwe Radebe - Ward 14\n'
                                  'Simphiwe Radebe - Ward 15\n'
                                  'Simphiwe Radebe - Ward 16\n'
                                  'Simphiwe Radebe - Ward 17\n'
                                  'Simphiwe Radebe - Ward 18\n'
                                  'Simphiwe Radebe - Ward 19\n'
                                  'Simphiwe Radebe - Ward 10\n'
                                  'Simphiwe Radebe - Ward 21\n'
                                  'Simphiwe Radebe - Ward 22\n'
                                  'Simphiwe Radebe - Ward 2\n'
                                  'Simphiwe Radebe - Ward 3\n'
                                  'Simphiwe Radebe - Ward 4\n'
                                  'Simphiwe Radebe - Ward 5\n'
                                  'Simphiwe Radebe - Ward 6\n'
                                  'Simphiwe Radebe - Ward 7\n'
                                  'Simphiwe Radebe - Ward 8\n'
                                  'Simphiwe Radebe - Ward 9\n'
                                  'Simphiwe Radebe - Ward 10\n'
                                  'Simphiwe Radebe - Ward 11\n'
                                  'Simphiwe Radebe - Ward 12\n'
                                  'Simphiwe Radebe - Ward 13\n'
                                  'Simphiwe Radebe - Ward 14\n'
                                  'Simphiwe Radebe - Ward 15\n'
                                  'Simphiwe Radebe - Ward 16\n'
                                  'Simphiwe Radebe - Ward 17\n'
                                  'Simphiwe Radebe - Ward 18\n'
                                  'Simphiwe Radebe - Ward 19\n'
                                  'Simphiwe Radebe - Ward 10\n'
                                  'Simphiwe Radebe - Ward 21\n'
                                  'Simphiwe Radebe - Ward 22\n'
                              ,)
                        );
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(width: 30.0,),
                          Text('Click here for info on your ward councilors name'),
                          SizedBox(width: 10.0,),
                          Icon(
                            Icons.info,
                          ),
                        ],
                      ),
                    ),
                    //SizedBox(height: 15.0,),
                    Container(
                      height: 60,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                              Radius.circular(20.0)),
                          color: Colors.black,
                          boxShadow: [
                            BoxShadow(color: Colors.black.withAlpha(100),
                                blurRadius: 20.0),
                          ]),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 12.0, right: 12.0, top: 5),
                            child: TextFormField(
                              controller: wardcouncilercontroller,
                              style: TextStyle(fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 20),
                              cursorColor: Colors.black,
                              decoration: new InputDecoration(
                                border: InputBorder.none,
                                hintText: "Ward counciler",
                                hintStyle: TextStyle(fontSize: 20.0, color: Colors.white),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 0, vertical: 0),
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
                    ),

                    Container(
                      height: 190,
                      margin: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10,),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                              Radius.circular(20.0)),
                          color: Colors.black,
                          boxShadow: [
                            BoxShadow(color: Colors.black.withAlpha(100),
                                blurRadius: 20.0),
                          ]),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 12.0, right: 12.0),
                            child: TextFormField(
                              controller: descriptionController,
                              style: TextStyle(fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 20),
                              cursorColor: Colors.white,
                              decoration: new InputDecoration(
                                border: InputBorder.none,
                                hintText: "Description",
                                hintStyle: TextStyle(fontSize: 20.0, color: Colors.white),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 20),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 15.0,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 35.0, right: 60.0),
                              child: IconButton(
                                  onPressed: () {
                                    print('Image Upload Clicked');
                                    //chooseFile();
                                    uploadImage();
                                  },
                                  icon: Icon(
                                    Icons.add_a_photo_outlined, size: 40,)),
                            ),
                            SizedBox(height: 10,),
                            Text("From Camera", style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),)
                          ],
                        ),
                        Text('OR', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),),
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 35.0, right: 60.0),
                              child: IconButton(
                                  onPressed: () {
                                    print('Image Upload Clicked');
                                    //chooseFile();
                                    uploadImageGallery();
                                  },
                                  icon: Icon(
                                    Icons.photo_album, size: 40,)),
                            ),
                            SizedBox(height: 10,),
                            Text("From Gallery", style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),)
                          ],
                        ),

                      ],
                    ),
                    SizedBox(height: 25.0,),
                    Column(

                      children: <Widget>[
                        if(_currentPosition != null) Text(
                          "Lat: ${_currentPosition!
                              .latitude}, Lng: ${_currentPosition!
                              .longitude}",
                        ),
                      ],
                    ),

                    ///Location Container
                    SizedBox(height: 40.0,),
                    /*GestureDetector(
                  onTap: (){
                    print("Submit Button Pressed");
                  },
                  child: Container(
                    height: 40,
                    margin: const EdgeInsets.symmetric(horizontal: 90, vertical: 10),
                    decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20.0)), color: Colors.white, boxShadow: [
                      BoxShadow(color: Colors.black.withAlpha(100), blurRadius: 20.0),
                    ]),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 1.0, vertical: 1),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Submit",
                                style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),*/
                    RaisedButton(
                      padding: const EdgeInsets.only(
                        left: 90, right: 90, top: 15, bottom: 10,),
                      onPressed: () {
                        if (typeofissueController.text.length < 1) {
                          print("Type of Issue cant be empty");
                          return;
                        }

                        if (descriptionController.text.length < 1) {
                          print("Please add a small description");
                          return;
                        }

                        submitIssueGlobal();
                      },
                      elevation: 15,
                      color: Colors.amber,
                      child: Container(
                        height: 30,
                        child: Text("Submit",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight
                              .bold),),
                      ),
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(25)
                      ),
                    ),
                    SizedBox(height: 30,)
                  ],
                ),
              ),
            ),
          );
          /*return Scaffold(
            appBar: AppBar(
                elevation: 0,
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
                title: Text("Report your issue",
                  style: TextStyle(
                      fontSize: 25, fontWeight: FontWeight.bold),),
                backgroundColor: Colors.white38
            ),
            body: Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [

                    Container(
                      height: 60,
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
                                left: 12.0, right: 12.0),
                            child: TextFormField(
                              controller: typeofissueController,
                              style: TextStyle(fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 20),
                              cursorColor: Colors.black,
                              decoration: new InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Type of issue"
                              ),
                            ),
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
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(width: 20.0,),
                        Text('Click here for info on your ward number'),
                        SizedBox(width: 10.0,),
                        Icon(
                          Icons.info,
                        ),
                      ],
                    ),
                    SizedBox(height: 15.0,),
                    Container(
                      height: 60,
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
                                left: 12.0, right: 12.0),
                            child: TextFormField(
                              controller: wardnumbercontroller,
                              style: TextStyle(fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 20),
                              cursorColor: Colors.black,
                              decoration: new InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Ward number"
                              ),
                            ),
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
                    ),
                    GestureDetector(
                      onTap: (){
                        showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (BuildContext context) => WaitDialog(
                              heading: 'Ward Councilers names',
                              status: 'Simphiwe Radebe - Ward 1\n'
                                  'Simphiwe Radebe - Ward 2\n'
                                  'Simphiwe Radebe - Ward 3\n'
                                  'Simphiwe Radebe - Ward 4\n'
                                  'Simphiwe Radebe - Ward 5\n'
                                  'Simphiwe Radebe - Ward 6\n'
                                  'Simphiwe Radebe - Ward 7\n'
                                  'Simphiwe Radebe - Ward 8\n'
                                  'Simphiwe Radebe - Ward 9\n'
                                  'Simphiwe Radebe - Ward 10\n'
                                  'Simphiwe Radebe - Ward 11\n'
                                  'Simphiwe Radebe - Ward 12\n'
                                  'Simphiwe Radebe - Ward 13\n'
                                  'Simphiwe Radebe - Ward 14\n'
                                  'Simphiwe Radebe - Ward 15\n'
                                  'Simphiwe Radebe - Ward 16\n'
                                  'Simphiwe Radebe - Ward 17\n'
                                  'Simphiwe Radebe - Ward 18\n'
                                  'Simphiwe Radebe - Ward 19\n'
                                  'Simphiwe Radebe - Ward 10\n'
                                  'Simphiwe Radebe - Ward 21\n'
                                  'Simphiwe Radebe - Ward 22\n'
                                  'Simphiwe Radebe - Ward 2\n'
                                  'Simphiwe Radebe - Ward 3\n'
                                  'Simphiwe Radebe - Ward 4\n'
                                  'Simphiwe Radebe - Ward 5\n'
                                  'Simphiwe Radebe - Ward 6\n'
                                  'Simphiwe Radebe - Ward 7\n'
                                  'Simphiwe Radebe - Ward 8\n'
                                  'Simphiwe Radebe - Ward 9\n'
                                  'Simphiwe Radebe - Ward 10\n'
                                  'Simphiwe Radebe - Ward 11\n'
                                  'Simphiwe Radebe - Ward 12\n'
                                  'Simphiwe Radebe - Ward 13\n'
                                  'Simphiwe Radebe - Ward 14\n'
                                  'Simphiwe Radebe - Ward 15\n'
                                  'Simphiwe Radebe - Ward 16\n'
                                  'Simphiwe Radebe - Ward 17\n'
                                  'Simphiwe Radebe - Ward 18\n'
                                  'Simphiwe Radebe - Ward 19\n'
                                  'Simphiwe Radebe - Ward 10\n'
                                  'Simphiwe Radebe - Ward 21\n'
                                  'Simphiwe Radebe - Ward 22\n'
                              ,)
                        );
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(width: 20.0,),
                          Text('Click here for info on your ward councilors name'),
                          SizedBox(width: 10.0,),
                          Icon(
                            Icons.info,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 15.0,),
                    Container(
                      height: 60,
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
                                left: 12.0, right: 12.0),
                            child: TextFormField(
                              controller: wardcouncilercontroller,
                              style: TextStyle(fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 20),
                              cursorColor: Colors.black,
                              decoration: new InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Ward counciler"
                              ),
                            ),
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
                    ),

                    SizedBox(height: 20,),

                    Container(
                      height: 190,
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
                                left: 12.0, right: 12.0),
                            child: TextFormField(
                              controller: descriptionController,
                              style: TextStyle(fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 20),
                              cursorColor: Colors.black,
                              decoration: new InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Description"
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 20),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 15.0,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 35.0, right: 60.0),
                              child: IconButton(
                                  onPressed: () {
                                    print('Image Upload Clicked');
                                    //chooseFile();
                                    uploadImage();
                                  },
                                  icon: Icon(
                                    Icons.add_a_photo_outlined, size: 40,)),
                            ),
                            SizedBox(height: 10,),
                            Text("From Camera", style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),)
                          ],
                        ),
                        Text('OR', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),),
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 35.0, right: 60.0),
                              child: IconButton(
                                  onPressed: () {
                                    print('Image Upload Clicked');
                                    //chooseFile();
                                    uploadImageGallery();
                                  },
                                  icon: Icon(
                                    Icons.photo_album, size: 40,)),
                            ),
                            SizedBox(height: 10,),
                            Text("From Gallery", style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),)
                          ],
                        ),

                      ],
                    ),
                    SizedBox(height: 25.0,),
                    *//*Container(
                      height: 40,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 130, vertical: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                              Radius.circular(20.0)),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(color: Colors.black.withAlpha(100),
                                blurRadius: 20.0),
                          ]),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 1.0, vertical: 1),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                *//**//*if(_currentAddress != null) Text(
                                    _currentAddress!
                                ),*//**//*

                                *//**//*Text(

                                  "Select Location",
                                  style: const TextStyle(fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),*//**//*
                                FlatButton(
                                    onPressed: () {
                                      _getCurrentLocation();
                                    },
                                    child: Text("Check Location")
                                ),
                                Column(
                                  children: <Widget>[

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
                                ),
                              ],
                            ),

                            *//**//*Image.asset(
                            "assets/images/${post["image"]}",
                            height: double.infinity,
                          )*//**//*
                          ],
                        ),
                      ),

                    ),*//*
                    Column(

                      children: <Widget>[
                        if(_currentPosition != null) Text(
                          "Lat: ${_currentPosition!
                              .latitude}, Lng: ${_currentPosition!
                              .longitude}",
                        ),
                      ],
                    ),

                    ///Location Container
                    SizedBox(height: 30.0,),
                    *//*GestureDetector(
                  onTap: (){
                    print("Submit Button Pressed");
                  },
                  child: Container(
                    height: 40,
                    margin: const EdgeInsets.symmetric(horizontal: 90, vertical: 10),
                    decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20.0)), color: Colors.white, boxShadow: [
                      BoxShadow(color: Colors.black.withAlpha(100), blurRadius: 20.0),
                    ]),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 1.0, vertical: 1),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Submit",
                                style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),*//*
                    RaisedButton(
                      padding: const EdgeInsets.only(
                        left: 90, right: 90, top: 15, bottom: 10,),
                      onPressed: () {
                        if (typeofissueController.text.length < 1) {
                          print("Type of Issue cant be empty");
                          return;
                        }

                        if (descriptionController.text.length < 1) {
                          print("Please add a small description");
                          return;
                        }

                        submitIssueGlobal();
                      },
                      elevation: 9,
                      color: Colors.amber,
                      child: Container(
                        height: 30,
                        child: Text("Submit",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight
                              .bold),),
                      ),
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(20)
                      ),
                    ),

                    SizedBox(height: 25.0,),
                  ],
                ),
              ),
            ),
          );*/
          var locationText = "Lat: ${_currentPosition!
              .latitude}, Lng: ${_currentPosition!.longitude}";
          var locationUrl = "https://www.google.com/maps/search/?api=1&query=${_currentPosition!
              .latitude}%2C${_currentPosition!.longitude}";

        });
  }
  _getCurrentLocation() async {
    Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
        forceAndroidLocationManager: true)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
        _getAddressFromLatLng();
      });
    }).catchError((e) {
      print(e);
    });
  }
  _getAddressFromLatLng() async {
    try{
      List<Placemark> placemarks = await placemarkFromCoordinates(
          _currentPosition!.latitude, _currentPosition!.longitude);

      Placemark place = placemarks[0];

      setState(() {
        _currentAddress = "${place.street}, ${place.postalCode}, ${place.country}";
      });
    } catch (e)
    {
      print(e);
    }
  }

/*Future chooseFile() async{
    await ImagePicker.pickImage(source: ImageSource.gallery).then((image) {
      setState(() {
        _image = image;
      });
    });
  }

  Future uploadFile() async {
    FirebaseStorage storageReference = FirebaseStorage.instance;
    //Reference ref = storageReference.ref.().child('${currentFirebaseUser?.uid}/Pictures/${Path.basename(_image?.path)}');
    Reference ref = storageReference.ref().child("image1" + DateTime.now().toString());
    UploadTask uploadTask = ref.putFile(_image);
    uploadTask.then((res) {
    res.ref.getDownloadURL();
    });
  }*/
}



