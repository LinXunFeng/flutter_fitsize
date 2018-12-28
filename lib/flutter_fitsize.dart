import 'package:flutter/material.dart';
import 'dart:ui';
import 'dart:io';

FlutterFitsize fs = FlutterFitsize();

class FlutterFitsize implements Function {
  // private init
  FlutterFitsize._internal();
  static FlutterFitsize _singleton = new FlutterFitsize._internal();
  factory FlutterFitsize() => _singleton;

  final _mediaQueryData = MediaQuery(data: MediaQueryData.fromWindow(window), child: Container(),).data;

  double referenceWidth = 375;
  double padFitMultiple = 0.6;

  setup({double referenceWidth, double padFitMultiple}) {
    assert((padFitMultiple == null) || (padFitMultiple > 0) || (padFitMultiple <= 1));
    if ((referenceWidth ?? 0) > 0) {
      this.referenceWidth = referenceWidth; 
    }
    if (padFitMultiple != null) {
      this.padFitMultiple = padFitMultiple; 
    }
  }

  double call(double value, {bool isForce = false}) {
    return isForce ? _singleton>>value: _singleton>value;
  }

  double auto(double value) {
    return fs(value);
  }
  double force(double value) {
    return fs(value, isForce: true);
  }

  double operator >(double value) => this >> value*(isPad() ? padFitMultiple : 1);
  double operator >>(double value) => _fetchPortraitWidth() / referenceWidth * value;

  bool isPad() {
    if (Platform.isIOS) {
      return _fetchPortraitWidth() >= 700;
    } else if (Platform.isAndroid) {
      return _fetchPortraitWidth() >= 600;
    }
    return false;
  }

  double _fetchPortraitWidth() {
    return _mediaQueryData.size.width < _mediaQueryData.size.height ? _mediaQueryData.size.width : _mediaQueryData.size.height;
  }
}