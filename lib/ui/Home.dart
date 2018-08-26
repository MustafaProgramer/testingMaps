import 'dart:async';
import 'package:flutter/material.dart';
import 'package:map_view/figure_joint_type.dart';
import 'package:map_view/map_view.dart';
class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeState();
  }
}

class HomeState extends State<Home> {
  
    static const API_KEY  = "AIzaSyCdDRYeDYxRTdSCQkn_G8tKxb-_oZB3p_0";
  MapView mapView = new MapView();
  CameraPosition cameraPosition;

   void initState()  {
     mapView.onAnnotationDragStart.listen((markerMap) {
      var marker = markerMap.keys.first;
      var location = markerMap[marker]; // The original location of the marker before moving it. Use it if needed.
      print("Annotation ${marker.id} dragging started");
    });
// This listener fires when the user releases the marker.
mapView.onAnnotationDragEnd.listen((markerMap) {
      var marker = markerMap.keys.first;
      var location = markerMap[marker];
      Marker M2 = new Marker("2", "Marker2", location.latitude, location.longitude);
     _markers.add(M2); 
      //_markers // The actual position of the marker after finishing the dragging.
      print("Annotation ${marker.id} dragging ended");
    });
// This listener fires every time the marker changes position.
mapView.onAnnotationDrag.listen((markerMap) {
      var marker = markerMap.keys.first;
      var location = markerMap[marker];
     // // The updated position of the marker.
      print("Annotation ${marker.id} moved to ${location.latitude} , ${location
          .longitude}");
    });
     //Location centerLocation = await mapView.centerLocation;
    super.initState();
    cameraPosition = new CameraPosition(new Location(45.52480841512737,
      -122.66201455146073,), 2.0);
    staticMapUri = staticMapProvider.getStaticUri(Locations.portland, 12,
        width: 900, height: 400, mapType: StaticMapViewType.roadmap);
  }

  List<Marker> _markers = <Marker>[
    new Marker(
      "1",
      "Manama!",
      26.2285,
      50.5860,
      color: Colors.blue,
      draggable: true,
       //Allows the user to move the marker.
      
    ),
  ];

  var staticMapProvider = new StaticMapProvider(API_KEY);
  Uri staticMapUri;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text("Map Page"),),
      body:
      
       new Column(
         crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
      
        new Center(
            child: 
            new FlatButton(
          child: new Row(
            children: <Widget>[new Icon(Icons.map),new Text("Map")],
            
          ) ,
          onPressed: howMap,

        )),
        
      ],
    )
    );
    
  }

 

    howMap() async {
      Location centerLocation =new Location(26.0300488, 50.5663721);
    mapView.show(
      
        new MapOptions(
            mapViewType: MapViewType.normal,
            showUserLocation: true,
            showMyLocationButton: true,
            showCompassButton: true,
            initialCameraPosition: new CameraPosition(
                 centerLocation, 9.0),
            hideToolbar: false,
            title: "Recently Visited"),

        toolbarActions: [new ToolbarAction("Close", 1),new ToolbarAction("Save", 5)]);
        mapView.onToolbarAction.listen((id) {
           if (id == 1) {
        mapView.dismiss();
      }
      else if (id==5)
      {
        print("Save");
      }
        });
    StreamSubscription sub = mapView.onMapReady.listen((_) {
      mapView.setMarkers(_markers);
     
    });
  
}
}