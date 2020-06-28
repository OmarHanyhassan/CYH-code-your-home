import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    Color caughtColor = Colors.grey;
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [
          DragBox(Offset(100.0, 200.0), "box1", Colors.lime),
          DragBox(Offset(200.0, 200.0), "box2", Colors.red),
          DragBox(Offset(300.0, 200.0), "box3", Colors.orange),
          Positioned(
              top: 400,
              left: 500,
              child: DragTarget(
                onAccept: (Color color) {
                  caughtColor = color;
                },
                builder: (context, accepted, rejected) {
                  return Container(
                    width: 200,
                    height: 200,
                    color: accepted.isEmpty ? caughtColor : Colors.grey,
                  );
                },
              ))
        ],
      ),
    );
  }
}

class DragBox extends StatefulWidget {
  final Offset initpos;
  final String label;
  final Color itemColor;

  DragBox(this.initpos, this.label, this.itemColor);

  @override
  _DragBoxState createState() => _DragBoxState();
}

class _DragBoxState extends State<DragBox> {
  Offset position = Offset(0.0, 0.0);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    position = widget.initpos;
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: position.dx,
      top: position.dy,
      child: Draggable(
        data: widget.itemColor,
        child: Container(
          color: widget.itemColor,
          height: 100,
          width: 100,
          child: Center(
            child: Text(
              widget.label,
            ),
          ),
        ),
        onDraggableCanceled: (velocity, offset) {
          setState(() {
            position = offset;
          });
        },
        feedback: Container(
          color: widget.itemColor.withOpacity(0.5),
          width: 120,
          height: 120,
        ),
      ),
    );
  }
}
