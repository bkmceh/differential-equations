import 'dart:math';

import 'package:differential_equations/de/mainPage.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

const eps = 2.7182818284590452353602874714;

double _f(double x, double y) {
  return x * y - x * pow(y, 3);
}

class EulerChart {
  double x;
  double y;

  EulerChart() {}

  EulerChart.point(this.x, this.y);

  dynamic dataForEulerChart(double n) {
    double _x0 = _data.getX0();
    double _y0 = _data.getY0();

    List<EulerChart> points = [];
    double _h = (_data.getX() - _data.getX0()) / n;
    points.add(EulerChart.point(_x0, _y0)); // add first point x0 y0
    double _x1;
    double _y1;
    for (int i = 0; i < n.toInt(); i++) {
      _x1 = _x0 + _h;
      _y1 = _y0 + _h * _f(_x0, _y0);
      points.add(EulerChart.point(_x1, _y1));
      _x0 = _x1;
      _y0 = _y1;
    }
    listOfPoints.eulerPoints = points;
    return points;
  }
}

class ImprovedEulerChart {
  double x;
  double y;

  ImprovedEulerChart() {}

  ImprovedEulerChart.point(this.x, this.y);

  dynamic dataForImprovedEulerChart(double n) {
    double _x0 = _data.getX0();
    double _y0 = _data.getY0();

    List<ImprovedEulerChart> points = [];
    double _h = (_data.getX() - _data.getX0()) / n;
    points.add(ImprovedEulerChart.point(_x0, _y0)); // add first point x0 y0
    double _x1;
    double _delY0;
    double _y1;
    for (int i = 0; i < n.toInt(); i++) {
      _x1 = _x0 + _h;
      _delY0 = _h * _f(_x0 + _h / 2, _y0 + _h / 2 * _f(_x0, _y0));
      _y1 = _y0 + _delY0;
      points.add(ImprovedEulerChart.point(_x1, _y1));
      _x0 = _x1;
      _y0 = _y1;
    }
    listOfPoints.improvedEulerPoints = points;
    return points;
  }
}

class RungeKuttaChart {
  double x;
  double y;

  RungeKuttaChart() {}

  RungeKuttaChart.point(this.x, this.y);

  dynamic dataForRungeKuttaChart(double n) {
    double _x0 = _data.getX0();
    double _y0 = _data.getY0();

    List<RungeKuttaChart> points = [];
    double _h = (_data.getX() - _data.getX0()) / n;
    points.add(RungeKuttaChart.point(_x0, _y0)); // add first point x0 y0
    double _x1;
    double _delY0;
    double _k1;
    double _k2;
    double _k3;
    double _k4;
    double _y1;
    for (int i = 0; i < n.toInt(); i++) {
      _x1 = _x0 + _h;
      _k1 = _f(_x0, _y0);
      _k2 = _f(_x0 + _h / 2, _y0 + (_h * _k1) / 2);
      _k3 = _f(_x0 + _h / 2, _y0 + (_h * _k2) / 2);
      _k4 = _f(_x0 + _h, _y0 + _h * _k3);
      _delY0 = _h / 6 * (_k1 + 2 * _k2 + 2 * _k3 + _k4);
      _y1 = _y0 + _delY0;
      points.add(RungeKuttaChart.point(_x1, _y1));
      _x0 = _x1;
      _y0 = _y1;
    }
    listOfPoints.rungeKuttaPoints = points;
    return points;
  }
}

class ExactSolution {
  double x;
  double y;

  ExactSolution() {}

  ExactSolution.point(this.x, this.y);

  dynamic dataForExactSolutionChart(double n) {
    List<ExactSolution> points = [];
    double _x0 = _data.getX0();
    double _y0 = _data.getY0();
    points.add(ExactSolution.point(_x0, _y0));
    double _h = (_data.getX() - _data.getX0()) / n;
    double _x1 = _x0;
    double _y1;

    for (int i = 0; i < n.toInt(); i++) {
      _x1 += _h;
      _y1 = pow(eps, pow(_x1, 2) / 2) / sqrt(1 + pow(eps, pow(_x1, 2)));
      points.add(ExactSolution.point(_x1, _y1));
    }
    listOfPoints.exactSolutionPoints = points;
    return points;
  }
}

class ListsOfPoints {
  List<EulerChart> eulerPoints;
  List<ExactSolution> exactSolutionPoints;
  List<ImprovedEulerChart> improvedEulerPoints;
  List<RungeKuttaChart> rungeKuttaPoints;
}

GivenData _data = GivenData();
ListsOfPoints listOfPoints = ListsOfPoints();
EulerChart euler = EulerChart();
ImprovedEulerChart improvedEuler = ImprovedEulerChart();
RungeKuttaChart rungeKutta = RungeKuttaChart();
ExactSolution exactSolution = ExactSolution();

class DifferentCharts extends StatefulWidget {
  @override
  _DifferentChartsState createState() => _DifferentChartsState();
}

class _DifferentChartsState extends State<DifferentCharts> {
  @override
  Widget build(BuildContext context) {
    RouteSettings settings = ModalRoute.of(context).settings;
    _data = settings.arguments;
    return Scaffold(
        appBar: AppBar(
          title: Text('Charts'),
          centerTitle: true,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: SfCartesianChart(
                  zoomPanBehavior: ZoomPanBehavior(enablePinching: true),
                  title: ChartTitle(
                      text:
                          'Here Several Different Charts.\nPush On The Name of Chart to Hide It'),
                  primaryXAxis: NumericAxis(),
                  // Enable legend
                  legend: Legend(isVisible: true),
                  // Enable tooltip
                  tooltipBehavior: TooltipBehavior(enable: true),
                  series: <LineSeries>[
                    LineSeries<EulerChart, double>(
                        name: "Euler",
                        dataSource: euler.dataForEulerChart(_data.getN()),
                        markerSettings: MarkerSettings(
                            isVisible: _data.getN() < 16 ? true : false),
                        xValueMapper: (EulerChart sales, _) => sales.x,
                        yValueMapper: (EulerChart sales, _) => sales.y,
                        // Enable data label
                        dataLabelSettings: DataLabelSettings(isVisible: false)),
                    LineSeries<ExactSolution, double>(
                        name: "Exact Solution",
                        color: Colors.black,
                        dataSource: exactSolution
                            .dataForExactSolutionChart(_data.getN()),
                        markerSettings: MarkerSettings(
                            isVisible: _data.getN() < 16 ? true : false),
                        xValueMapper: (ExactSolution sales, _) => sales.x,
                        yValueMapper: (ExactSolution sales, _) => sales.y,
                        // Enable data label
                        dataLabelSettings: DataLabelSettings(isVisible: false)),
                    LineSeries<ImprovedEulerChart, double>(
                        name: "Improved Euler",
                        dataSource: improvedEuler
                            .dataForImprovedEulerChart(_data.getN()),
                        markerSettings: MarkerSettings(
                            isVisible: _data.getN() < 16 ? true : false),
                        xValueMapper: (ImprovedEulerChart sales, _) => sales.x,
                        yValueMapper: (ImprovedEulerChart sales, _) => sales.y,
                        color: Colors.green,
                        // Enable data label
                        dataLabelSettings: DataLabelSettings(isVisible: false)),
                    LineSeries<RungeKuttaChart, double>(
                        name: "Runge-Kutta",
                        dataSource:
                            rungeKutta.dataForRungeKuttaChart(_data.getN()),
                        markerSettings: MarkerSettings(
                            isVisible: _data.getN() < 16 ? true : false),
                        xValueMapper: (RungeKuttaChart sales, _) => sales.x,
                        yValueMapper: (RungeKuttaChart sales, _) => sales.y,
                        color: Colors.purple,
                        // Enable data label
                        dataLabelSettings: DataLabelSettings(isVisible: false)),
                  ]),
            ),
            RaisedButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamed('/gte', arguments: listOfPoints);
              },
              child: Text("See GTE charts"),
            )
          ],
        ));
  }
}
