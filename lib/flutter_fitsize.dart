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

  double _referenceWidth = 375.0;
  double _padFitMultiple = 0.5;

  /// 设置全局配置
  /// 
  ///  * [referenceWidth], 参照宽度.
  ///  * [padFitMultiple], pad 的缩放倍数.
  setup({double referenceWidth, double padFitMultiple}) {
    assert((padFitMultiple == null) || (padFitMultiple > 0) || (padFitMultiple <= 1));
    if ((referenceWidth ?? 0) > 0) {
      this._referenceWidth = referenceWidth; 
    }
    if (padFitMultiple != null) {
      this._padFitMultiple = padFitMultiple; 
    }
  }

  /// 计算适配大小的核心方法
  ///
  ///  * [value], 需要适配的值.
  ///  * [isForce], 是否为强制适配.
  ///  * [padFitMultiple], 指定 pad 的缩放倍数.
  double call(double value, {bool isForce = false, double padFitMultiple}) {
    final forceValue = _fetchPortraitWidth() / _referenceWidth * value;
    if (isForce || !_isPad()) return forceValue;
    // isPad == true
    if (padFitMultiple != null && (padFitMultiple > 0 || padFitMultiple <= 1)) {
      return forceValue * padFitMultiple;
    }
    return forceValue * _padFitMultiple;
  }

  /// 自动适配大小
  /// 
  /// 会自动判断 phone 和 pad，可指定 padFitMultiple
  ///
  ///  * [value], 需要适配的值.
  ///  * [isForce], 是否为强制适配.
  double auto(double value, {double padFitMultiple}) {
    return fs(value, padFitMultiple : padFitMultiple);
  }

  /// 强制适配大小
  /// 
  /// 会强制按比例计算相应的大小，不区分 phone 和 pad
  ///
  ///  * [value], 需要适配的值.
  double force(double value) {
    return fs(value, isForce: true);
  }

  /// auto
  double operator >(double value) => auto(value);
  /// force
  double operator >>(double value) => force(value);

  /// 是否为 pad
  /// 
  /// 按平台类型再判断相应的宽度值
  bool _isPad() {
    if (Platform.isIOS) {
      return _fetchPortraitWidth() >= 700;
    } else if (Platform.isAndroid) {
      return _fetchPortraitWidth() >= 600;
    }
    return false;
  }

  /// 获取竖屏的宽度
  double _fetchPortraitWidth() {
    return _mediaQueryData.size.width < _mediaQueryData.size.height ? _mediaQueryData.size.width : _mediaQueryData.size.height;
  }
}