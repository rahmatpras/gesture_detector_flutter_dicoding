import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gesture Detector',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final double boxSize = 150.0;
  int numTaps = 0;
  int doubleTaps = 0;
  int longPress = 0;
  double posX = 0.0;
  double posY = 0.0;

  @override
  Widget build(BuildContext context) {
    if (posX == 0) {
      center(context);
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Gesture Detector'),
      ),
      body: Stack(children: [
        Positioned(
          top: posY,
          left: posX,
          child: GestureDetector(
            //dibungkus GestureDetector agar dapat mendeteksi gestur/interaksi
            child: Container(
              width: boxSize,
              height: boxSize,
              decoration: BoxDecoration(color: Colors.red),
            ),
            onTap: () {
              setState(() => numTaps++);
            },
            onDoubleTap: () {
              setState(() => doubleTaps++);
            },
            onLongPress: () {
              setState(() => longPress++);
            },
            onPanUpdate: (DragUpdateDetails details) {
              setState(() {
                double deltaX = details.delta.dx;
                double deltaY = details.delta.dy;
                posX += deltaX;
                posY += deltaY;
              });
            },
          ),
        ),
      ]),
      bottomNavigationBar: Container(
        color: Colors.yellow,
        padding: const EdgeInsets.all(16.0),
        child: Text(
          'Taps: $numTaps - Double Taps: $doubleTaps - Long Press: $longPress',
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
    );
  }

  void center(BuildContext context) {
    posX = (MediaQuery.of(context).size.width / 2) - boxSize / 2;
    posY = (MediaQuery.of(context).size.height / 2) - boxSize / 2 - 30;

    setState(() {
      this.posX = posX;
      this.posY = posY;
    });
  }
}
