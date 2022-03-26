import 'package:firebase_auth/firebase_auth.dart' as User;
import 'package:firebase_database/firebase_database.dart';
import 'package:jra_app/datamodels/user.dart' as Users;

const FOOD_DATA = [
  {
    "name":"General",
    "brand":"Hawkers",
    "price":2.99,
    "image":"warning.png",

  },{
    "name":"Traffic Signal",
    "brand":"Hawkers",
    "price":4.99,
    "image":"trafficlight.png",
  },
  {
    "name":"Pothole",
    "brand":"Mcdonald",
    "price":1.49,
    "image":"pothole.png",

  },
  {
    "name":"Signage",
    "brand":"Ben & Jerry's",
    "price":9.49,
    "image":"signage.png",
  },
  {
    "name":"Manhole Cover",
    "brand":"Hawkers",
    "price":4.49,
    "image":"warning.png",

  },
  {
    "name":"Stormwater Drainage",
    "brand":"Mcdonald",
    "price":2.99,
    "image":"warning.png",
  },
  {
    "name":"Crime Scenes",
    "brand":"Dominos",
    "price":17.99,
    "image":"warning.png",

  },
  {
    "name":"Accidents",
    "brand":"Hawkers",
    "price":2.99,
    "image":"warning.png",

  },
  {
    "name":"Need traffic director",
    "brand":"Subway",
    "price":6.99,
    "image":"warning.png",
  }
];
User.User? currentFirebaseUser;
Users.User? currentUserInfo;
 final databaseRef = FirebaseDatabase.instance.reference();

var versionnumber = '1.0.1';