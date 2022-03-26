import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {

  GoogleMapController? myController;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  /*void initMarker(specify, specifyId) async{
    var markerIdVal = specifyId;
    final MarkerId markerId = MarkerId(markerIdVal);
    final Marker marker = Marker(
      markerId: markerId,
      position: LatLng(specify['location'].latitude, specify['location'].longitude),
      infoWindow: InfoWindow(title: 'Potholess', snippet: specify['address'])
    );
    setState(() {
      markers[markerId] = marker;
    });
  }*/

  void initMarker(specify, specifyId){
    var markerIdVal = specifyId;
    final MarkerId markerId = MarkerId(markerIdVal);
    // creating a new marker
    final Marker marker = Marker(
      markerId: markerId,
      position: LatLng(specify.docs.data()['location'].latitude, specify.docs.data()['location'].longitude),
      infoWindow: InfoWindow(title: 'Markers', snippet: specify.docs.data()['address']),
    );
  }

  getMarkerData() async{
    /*FirebaseFirestore.instance.collection('locations').get(GetOptions()).then((myMockData){
      if(myMockData.docs.isNotEmpty){
        for(int i = 0; i < myMockData.docs.length ; i++){
          initMarker(myMockData.docs[i].data(), myMockData.docs[i].id);
        }
      }
    });*/
    /*FirebaseFirestore.instance.collection('locations').get().then((documents){
      if (documents.docs.isNotEmpty) {
        for (int i = 0; i < documents.size; ++i){
          initMarker(documents.docs[i].data(), documents.docs[i].id);
        }
      }
    });*/
    FirebaseFirestore.instance.collection('locations').get().then((QuerySnapshot querySnapshot) {
      if(querySnapshot.docs.isNotEmpty){
        for(int i = 0; i < querySnapshot.size; i++){
          initMarker(querySnapshot.docs[i].data(), querySnapshot.docs[i].id);
        }
      }
      querySnapshot.docs.forEach((doc) {
        print(doc['location'].latitude);
        print(doc['location'].longitude);
      });
    });
  }

  void initState(){
    getMarkerData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Set<Marker> getMarker() {
      return <Marker>[
        Marker(
            markerId: MarkerId('Pothole'),
            position: LatLng(-26.23925,28.11164),
            icon: BitmapDescriptor.defaultMarker,
            infoWindow: InfoWindow(title: 'Pothole Description')
        ),
      ].toSet();
    }
    return Scaffold(
      body: GoogleMap(
        //markers: Set<Marker>.of(markers.values),
        markers: getMarker(),
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(
          target: LatLng(-26.23925,28.11164),
          zoom: 14.0,),
          onMapCreated: (GoogleMapController controller){
            myController = controller;

          },
        ),
      );
  }
}
