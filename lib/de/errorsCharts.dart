import 'package:differential_equations/de/charts.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class EulerError {
  double x;
  double y;

  EulerError() {}

  EulerError.point(this.x, this.y);

  dynamic Difference() {
    double x;
    double y;
    List<EulerError> eulerErrorPoints = [];
    for (int i = 0; i < listsOfPoints.eulerPoints.length; i++) {
      x = listsOfPoints.eulerPoints[i].x;
      y = listsOfPoints.eulerPoints[i].y;

      eulerErrorPoints.add(EulerError.point(
          x, (listsOfPoints.exactSolutionPoints[i].y - y).abs()));
    }

    return eulerErrorPoints;
  }
}

class ImprovedEulerError {
  double x;
  double y;

  ImprovedEulerError() {}

  ImprovedEulerError.point(this.x, this.y);

  dynamic Difference() {
    double x;
    double y;
    List<ImprovedEulerError> improvedEulerErrorPoints = [];
    for (int i = 0; i < listsOfPoints.improvedEulerPoints.length; i++) {
      x = listsOfPoints.improvedEulerPoints[i].x;
      y = listsOfPoints.improvedEulerPoints[i].y;

      improvedEulerErrorPoints.add(ImprovedEulerError.point(
          x, (listsOfPoints.exactSolutionPoints[i].y - y).abs()));
    }

    return improvedEulerErrorPoints;
  }
}

class RungeKuttaError {
  double x;
  double y;

  RungeKuttaError() {}

  RungeKuttaError.point(this.x, this.y);

  dynamic Difference() {
    double x;
    double y;
    List<RungeKuttaError> RungeKuttaErrorPoints = [];
    for (int i = 0; i < listsOfPoints.rungeKuttaPoints.length; i++) {
      x = listsOfPoints.rungeKuttaPoints[i].x;
      y = listsOfPoints.rungeKuttaPoints[i].y;

      RungeKuttaErrorPoints.add(RungeKuttaError.point(
          x, (listsOfPoints.exactSolutionPoints[i].y - y).abs()));
    }

    return RungeKuttaErrorPoints;
  }
}

ListsOfPoints listsOfPoints = ListsOfPoints();
EulerError eulerError = EulerError();
ImprovedEulerError improvedEulerError = ImprovedEulerError();
RungeKuttaError rungeKuttaError = RungeKuttaError();

class GTECharts extends StatefulWidget {
  @override
  _GTEChartsState createState() => _GTEChartsState();
}

class _GTEChartsState extends State<GTECharts> {
  @override
  Widget build(BuildContext context) {
    RouteSettings settings = ModalRoute
        .of(context)
        .settings;
    listsOfPoints = settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text('GTE Charts'),
        centerTitle: true,
      ),
      body: SfCartesianChart(
        zoomPanBehavior: ZoomPanBehavior(enablePinching: true),
        title:
        ChartTitle(text: 'GTE Charts of Different Methods'),
        legend: Legend(isVisible: true),
        primaryXAxis: NumericAxis(),
        tooltipBehavior: TooltipBehavior(enable: true),
        series: <LineSeries>[
          LineSeries<EulerError, double>(
              markerSettings: MarkerSettings(isVisible: true),
              name: "Euler",
              dataSource: eulerError.Difference(),
              xValueMapper: (EulerError sales, _) => sales.x,
              yValueMapper: (EulerError sales, _) => sales.y,
              // Enable data label
              dataLabelSettings: DataLabelSettings(isVisible: false)),
          LineSeries<ImprovedEulerError, double>(
              color: Colors.green,
              markerSettings: MarkerSettings(isVisible: true),
              name: "Improved Euler",
              dataSource: improvedEulerError.Difference(),
              xValueMapper: (ImprovedEulerError sales, _) => sales.x,
              yValueMapper: (ImprovedEulerError sales, _) => sales.y,
              // Enable data label
              dataLabelSettings: DataLabelSettings(isVisible: false)),
          LineSeries<RungeKuttaError, double>(
              color: Colors.purple,
              markerSettings: MarkerSettings(isVisible: true),
              name: "Runge-Kutta",
              dataSource: rungeKuttaError.Difference(),
              xValueMapper: (RungeKuttaError sales, _) => sales.x,
              yValueMapper: (RungeKuttaError sales, _) => sales.y,
              // Enable data label
              dataLabelSettings: DataLabelSettings(isVisible: false)),
        ],
      ),
    );
  }
}
