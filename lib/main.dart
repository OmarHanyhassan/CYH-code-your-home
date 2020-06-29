import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  //  This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      home: Home(),
    );
  }
}

List<String> codes = List<String>();
List<Widget> blocks = List<Widget>();

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Code Your Home"),
      ),
      body: Flex(
        direction: Axis.horizontal,
        children: [
          Expanded(
            flex: 2,
            child: ListView.builder(
              itemCount: 9,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.only(
                    top: 10,
                    right: 15,
                  ),
                  child: DragBox(
                    "aurduino code $index",
                    Colors.grey[800],
                  ),
                );
              },
            ),
          ),
          Expanded(
            flex: 2,
            child: Stack(
              children: [
                DragTarget(
                  onAccept: (String code) {
                    setState(
                      () {
                        codes.add(code);
                        print(codes);
                      },
                    );
                  },
                  builder: (context, accepted, rejected) {
                    //print(accepted);
                    return Container(
                      color: Colors.grey,
                      child: Center(
                        child: Text("code"),
                      ),
                    );
                  },
                ),
                //Column(
                //children: blocks,
                //),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: ListView(
              children: blocks,
            ),
          )
        ],
      ),
    );
  }
}

class DragBox extends StatefulWidget {
  // final Offset initpos;
  final String code;
  final Color itemColor;
  DragBox(this.code, this.itemColor);

  @override
  _DragBoxState createState() => _DragBoxState();
}

class _DragBoxState extends State<DragBox> {
  Offset position = Offset(0.0, 0.0);
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Draggable(
      data: widget.code,
      child: Container(
        color: widget.itemColor,
        height: 100,
        width: 100,
        child: Card(
          child: Text(
            widget.code,
          ),
        ),
      ),
      onDragCompleted: () {
        setState(() {
          blocks = codes.map(
            (e) {
              return Card(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.close,
                          size: 18,
                        ),
                        onPressed: () {
                          setState(() {
                            codes.remove(e);
                            //blocks.removeAt(index);
                          });
                          print(codes);
                          ////blocks.remove();
                        },
                      ),
                      Text(
                        e,
                        style: TextStyle(fontSize: 15),
                      )
                    ],
                  ),
                ),
              );
            },
          ).toList();
        });
      },
      feedback: Card(
        color: widget.itemColor.withOpacity(0.5),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
          child: Text(
            widget.code,
            style: TextStyle(fontSize: 15),
          ),
        ),
      ),
    );
  }
}
