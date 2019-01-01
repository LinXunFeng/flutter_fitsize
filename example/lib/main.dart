import 'package:flutter/material.dart';
import 'package:flutter_fitsize/flutter_fitsize.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
    void initState() {
      // fs.setup(referenceWidth: 414.0, padFitMultiple: 0.7);
      // fs.setup(referenceWidth: 414.0);
      // fs.setup(padFitMultiple: 0.7);
      super.initState();
    }

  @override
  Widget build(BuildContext context) {
    calculate();

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('flutter fitsize'),
        ),
        body: Center(child: Text('show values on console'),),
      ),
    );
  }

  calculate() {
    // auto
    print('fs> -- ${fs>40.0}');
    print('fs -- ${fs(40.0)}');
    print('fs.auto -- ${fs.auto(40.0)}');
    print('fs.auto specify padFitMultiple -- ${fs.auto(40.0, padFitMultiple: 0.6)}');
    
    // force
    print('fs>> -- ${fs>>40.0}');
    print('fs -- ${fs(40.0, isForce: true)}'); 
    print('fs.force -- ${fs.force(40.0)}');
  }
}
