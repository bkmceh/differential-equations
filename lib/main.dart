import 'package:differential_equations/de/MaxErrors.dart';
import 'package:differential_equations/de/charts.dart';
import 'package:differential_equations/de/errorsCharts.dart';
import 'package:differential_equations/de/mainPage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(new MaterialApp(
    home: MainPage(),
    routes: {
      '/charts': (context) => DifferentCharts(),
      '/gte': (context) => GTECharts(),
      '/maxGte': (context) => MaxErrors()
    },
  ));
}
