import 'dart:math';

import 'package:differential_equations/de/charts.dart';
import 'package:differential_equations/de/mainPage.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Methods {
  double x;
  double y;

  dynamic data() {}
}

class Euler implements Methods {
  @override
  double x;

  @override
  double y;

  Euler() {}

  Euler.point(this.x, this.y);

  ExactSolution exactSolution = ExactSolution();
  EulerChart eulerChart = EulerChart();

  @override
  dynamic data() {
    List<Euler> points = [];
    for (int j = _data.getN0().toInt(); j <= _data.getNf().toInt(); j++) {
      double n = j.toDouble();
      List<ExactSolution> sol = exactSolution.dataForExactSolutionChart(n);
      List<EulerChart> eul = eulerChart.dataForEulerChart(n);
      double maxDifference = 0.0;
      for (int i = 0; i < sol.length; i++) {
        if ((sol[i].y - eul[i].y).abs() > maxDifference) {
          maxDifference = (sol[i].y - eul[i].y).abs();
        }
      }
      points.add(Euler.point(n, maxDifference));
    }

    return points;
  }
}

class ImprovedEuler implements Methods {
  @override
  double x;

  @override
  double y;

  ImprovedEuler() {}

  ImprovedEuler.point(this.x, this.y);

  ExactSolution exactSolution = ExactSolution();
  ImprovedEulerChart improvedEuler = ImprovedEulerChart();

  @override
  dynamic data() {
    List<ImprovedEuler> points = [];
    for (int j = _data.getN0().toInt(); j <= _data.getNf().toInt(); j++) {
      double n = j.toDouble();
      List<ExactSolution> sol = exactSolution.dataForExactSolutionChart(n);
      List<ImprovedEulerChart> eul = improvedEuler.dataForImprovedEulerChart(n);
      double maxDifference = 0.0;
      for (int i = 0; i < sol.length; i++) {
        if ((sol[i].y - eul[i].y).abs() > maxDifference) {
          maxDifference = (sol[i].y - eul[i].y).abs();
        }
      }
      points.add(ImprovedEuler.point(n, maxDifference));
    }

    return points;
  }
}

class RungeKutta implements Methods {
  @override
  double x;

  @override
  double y;

  RungeKutta() {}

  RungeKutta.point(this.x, this.y);

  ExactSolution exactSolution = ExactSolution();
  RungeKuttaChart rungeKuttaChart = RungeKuttaChart();

  @override
  data() {
    List<RungeKutta> points = [];
    for (int j = _data.getN0().toInt(); j <= _data.getNf().toInt(); j++) {
      double n = j.toDouble();
      List<ExactSolution> sol = exactSolution.dataForExactSolutionChart(n);
      List<RungeKuttaChart> eul = rungeKuttaChart.dataForRungeKuttaChart(n);
      double maxDifference = 0.0;
      for (int i = 0; i < sol.length; i++) {
        if ((sol[i].y - eul[i].y).abs() > maxDifference) {
          maxDifference = (sol[i].y - eul[i].y).abs();
        }
      }
      points.add(RungeKutta.point(n, maxDifference));
    }

    return points;
  }
}

GivenData _data = GivenData();
Euler euler = Euler();
ImprovedEuler improvedEuler = ImprovedEuler();
RungeKutta rungeKutta = RungeKutta();

class MaxErrors extends StatefulWidget {
  @override
  _MaxErrorsState createState() => _MaxErrorsState();
}

class _MaxErrorsState extends State<MaxErrors> {
  @override
  Widget build(BuildContext context) {
    RouteSettings settings = ModalRoute.of(context).settings;
    _data = settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text('Max GTE Charts'),
        centerTitle: true,
      ),
      body: SfCartesianChart(
        zoomPanBehavior: ZoomPanBehavior(enablePinching: true),
        title: ChartTitle(text: 'Max GTE Charts of Different Methods\n'
            'From n0 To Nf'),
        legend: Legend(isVisible: true),
        primaryXAxis: NumericAxis(),
        tooltipBehavior: TooltipBehavior(enable: true),
        series: <LineSeries>[
          LineSeries<Euler, double>(
              xAxisName: 'N',
              markerSettings: MarkerSettings(
                  isVisible: _data.getNf() - _data.getN0() > 30 ? false : true),
              name: 'Euler',
              dataSource: euler.data(),
              xValueMapper: (Euler sales, _) => sales.x,
              yValueMapper: (Euler sales, _) => sales.y,
              // Enable data label
              dataLabelSettings: DataLabelSettings(isVisible: false)),
          LineSeries<ImprovedEuler, double>(
              markerSettings: MarkerSettings(
                  isVisible: _data.getNf() - _data.getN0() > 30 ? false : true),
              name: 'Improved Euler',
              color: Colors.green,
              dataSource: improvedEuler.data(),
              xValueMapper: (ImprovedEuler sales, _) => sales.x,
              yValueMapper: (ImprovedEuler sales, _) => sales.y,
              dataLabelSettings: DataLabelSettings(isVisible: false)),
          LineSeries<RungeKutta, double>(
              markerSettings: MarkerSettings(
                  isVisible: _data.getNf() - _data.getN0() > 30 ? false : true),
              name: 'Runge-Kutta',
              color: Colors.purple,
              dataSource: rungeKutta.data(),
              xValueMapper: (RungeKutta sales, _) => sales.x,
              yValueMapper: (RungeKutta sales, _) => sales.y,
              dataLabelSettings: DataLabelSettings(isVisible: false))
        ],
      ),
    );
  }
}
