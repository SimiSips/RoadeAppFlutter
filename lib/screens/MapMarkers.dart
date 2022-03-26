/*
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class MapMarkers extends StatefulWidget {
  @override
  _MapMarkersState createState() => _MapMarkersState();
}

class _MapMarkersState extends State<MapMarkers> {
  late GoogleMapController _controller;

  late Position position;

  late Widget _child;

  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  late BitmapDescriptor pinLocationIcon;

  @override
  void initState() {
    _child = SpinKitRipple(
      itemBuilder: (BuildContext context, int index) {
        return DecoratedBox(
          decoration: BoxDecoration(
            color: index.isEven ? Colors.grey : Color(0xffffb838),
          ),
        );
      },
    );
    //getCurrentLocation();
    populateClients();
    setCustomMapPin();
    super.initState();
  }

  */
/*void getCurrentLocation() async {
    Position res = await getCurrentPosition();
    setState(() {
      position = res;
      _child = mapWidget();
    });
  }*//*


  populateClients() {
    FirebaseFirestore.instance.collection("locations").get().then((docs) {
      if (docs.docs.isNotEmpty) {
        for (int i = 0; i < docs.docs.length; ++i) {
          initMarker(docs.docs[i].data(), docs.docs[i].id);
        }
      }
    });
  }

  void initMarker(tomb, tombId) {
    var markerIdVal = tombId;
    final MarkerId markerId = MarkerId(markerIdVal);

    final Marker marker = Marker(
      markerId: markerId,
      position: LatLng(
          tomb.data()['location'].latitude, tomb.data()['location'].latitude),
      icon: pinLocationIcon,
    );
    setState(() {
      markers[markerId] = marker;
    });
  }

  void setCustomMapPin() async {
    pinLocationIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5), 'assets/cons/pin.png');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Color(0xffffb838)),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: _child,
    );
  }

  Widget mapWidget() {
    return Stack(
      children: <Widget>[
        GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(position.latitude, position.longitude),
              zoom: 10,
            ),
            onMapCreated: (GoogleMapController controller) {
              _controller = controller;
            },
            compassEnabled: true,
            myLocationEnabled: true,
            markers: Set<Marker>.of(markers.values)),
        SizedBox(
          height: 26,
        ),
      ],
    );
  }
}*/
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapMarkers extends StatefulWidget {
  @override
  _MapMarkersState createState() => _MapMarkersState();
}

class _MapMarkersState extends State<MapMarkers> {
  GoogleMapController? controller;

  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  void initMarker(specify, specifyId) async {
    var markerIdVal = specifyId;
    final MarkerId markerId = MarkerId(markerIdVal);
    final Marker marker = Marker(
      markerId: markerId,
      position:
      LatLng(specify.data.docs.data()['location'].latitude, specify.data.docs.data()['location'].longitude),
      infoWindow: InfoWindow(title: 'Shop', snippet: specify.data.docs.data()['address']),
    );
    setState(() {
      markers[markerId] = marker;
    });
  }

  getMarkerData() async {
    FirebaseFirestore.instance.collection('locations').get().then((myMockDoc) {
      if (myMockDoc.docs.isNotEmpty) {
        for (int i = 0; i < myMockDoc.docs.length; i++) {
          initMarker(myMockDoc.docs[i].data(), myMockDoc.docs[i].id);
        }
      }
    });
  }

  @override
  void initState() {
    getMarkerData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    Set<Marker> getMarker() {
      return <Marker>[
        Marker(
            markerId: MarkerId('Shop'),
            position: LatLng(21.1458, 79.0882),
            icon: BitmapDescriptor.defaultMarker,
            infoWindow: InfoWindow(title: 'Home'))
      ].toSet();
    }

    return Scaffold(
        body: GoogleMap(
            markers: Set<Marker>.of(markers.values),
            mapType: MapType.normal,
            initialCameraPosition:
            CameraPosition(target: LatLng(21.1458, 79.0882), zoom: 12.0),
            onMapCreated: (GoogleMapController controller) {
              controller = controller;
            }));
  }
}