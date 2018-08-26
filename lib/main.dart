

import 'package:flutter/material.dart';
import './ui/Home.dart';
import 'package:map_view/map_view.dart';

void main() {
  var API_KEY = "AIzaSyCdDRYeDYxRTdSCQkn_G8tKxb-_oZB3p_0";
  MapView.setApiKey(API_KEY);
  runApp(new MaterialApp(
    home: new Home(),
  ));
}

