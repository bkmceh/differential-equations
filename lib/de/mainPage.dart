import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  double _x0;
  double _y0;
  double _x;
  double _n;

  GivenData _data = GivenData();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(28.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 60,
              ),
              TextField(
                decoration: new InputDecoration(labelText: "Enter Your x0"),
                keyboardType: TextInputType.number,
                onChanged: (String value) {
                  _x0 = double.parse(value);
                  _data.setX0(_x0);
                },
              ),
              TextField(
                decoration: new InputDecoration(labelText: "Enter Your y0"),
                keyboardType: TextInputType.number,
                onChanged: (String value) {
                  _y0 = double.parse(value);
                  _data.setY0(_y0);
                },
              ),
              TextField(
                decoration: new InputDecoration(labelText: "Enter Your X"),
                keyboardType: TextInputType.number,
                onChanged: (String value) {
                  _x = double.parse(value);
                  _data.setX(_x);
                },
              ),
              TextField(
                decoration: new InputDecoration(labelText: "Enter Your N"),
                keyboardType: TextInputType.number,
                onChanged: (String value) {
                  _n = double.parse(value);
                  _data.setN(_n);
                },
              ),
              TextField(
                decoration: new InputDecoration(labelText: "Enter Your n0"),
                keyboardType: TextInputType.number,
                onChanged: (String value) {
                  _data.setN0(double.parse(value));
                },
              ),
              TextField(
                decoration: new InputDecoration(labelText: "Enter Your Nf"),
                keyboardType: TextInputType.number,
                onChanged: (String value) {
                  _data.setNf(double.parse(value));
                },
              ),
              RaisedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/charts', arguments: _data);
                },
                child: Text("Build Charts of Methods"),
              ),
              RaisedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/maxGte', arguments: _data);
                },
                child: Text("See Max GTE charts"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class GivenData {
  double _x0;
  double _y0;
  double _x;
  double _n;
  double _n0;
  double _nf;


  void setN0(double value) {
    this._n0 = value;
  }

  void setNf(double value) {
    this._nf = value;
  }


  void setX0(double value) {
    this._x0 = value;
  }

  void setY0(double value) {
    this._y0 = value;
  }

  void setX(double value) {
    this._x = value;
  }

  void setN(double value) {
    this._n = value;
  }

  double getX0() {
    return _x0;
  }

  double getY0() {
    return _y0;
  }

  double getX() {
    return _x;
  }

  double getN() {
    return _n;
  }
  double getN0() {
    return _n0;
  }
  double getNf() {
    return _nf;
  }
}
