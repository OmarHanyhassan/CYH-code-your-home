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
List<Block> blocks = List<Block>();

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: PopupMenuButton(
        color: Colors.black,
        child: Icon(Icons.more_vert),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        itemBuilder: (context) => [
          PopupMenuItem(
            child: Text("generate code"),
          ),
          PopupMenuItem(
            child: Text("exceute code"),
          ),
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {},
      //   child: Icon(Icons.more_vert),
      // ),
      appBar: AppBar(
        title: Text("Code Your Home"),
      ),
      body: Flex(
        direction: Axis.horizontal,
        children: [
          Expanded(
            flex: 2,
            child: ListView(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(
                    top: 10,
                    right: 15,
                  ),
                  child: DragBox("Setup pin as 13", "int pin = 13;"),
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: 10,
                    right: 15,
                  ),
                  child: DragBox("Make the setup() function", "void setup()"),
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: 10,
                    right: 15,
                  ),
                  child: DragBox("Setup pin as 13", "int pin = 13;"),
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: 10,
                    right: 15,
                  ),
                  child: DragBox("Setup pin as 13", "int pin = 13;"),
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: 10,
                    right: 15,
                  ),
                  child: DragBox("Setup pin as 13", "int pin = 13;"),
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: 10,
                    right: 15,
                  ),
                  child: DragBox("Setup pin as 13", "int pin = 13;"),
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: 10,
                    right: 15,
                  ),
                  child: DragBox("Setup pin as 13", "int pin = 13;"),
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: 10,
                    right: 15,
                  ),
                  child: DragBox("Setup pin as 13", "int pin = 13;"),
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: 10,
                    right: 15,
                  ),
                  child: DragBox("Setup pin as 13", "int pin = 13;"),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 4,
            child: Stack(
              alignment: Alignment.center,
              children: [
                DragTarget(
                  onAccept: (String code) {
                    setState(
                      () {
                        codes.add(code);
                        print(codes);
                        print(blocks);
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
                Column(
                  children: blocks,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DragBox extends StatefulWidget {
  // final Offset initpos;
  final String code;
  final String displayValue;
  DragBox(this.displayValue, this.code);

  @override
  _DragBoxState createState() => _DragBoxState();
}

class _DragBoxState extends State<DragBox> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Draggable(
      data: widget.code,
      child: Container(
        color: Colors.grey,
        height: 100,
        width: 100,
        child: Card(
          child: Text(
            widget.displayValue,
          ),
        ),
      ),
      onDragCompleted: () {
        setState(() {
          blocks = codes.map(
            (e) {
              return Block(
                () {
                  setState(() {
                    codes.remove(e);
                    blocks.removeWhere((Block element) => element.data == e);
                  });
                  print(codes);
                  print(blocks);
                },
                e,
              );
            },
          ).toList();
        });
      },
      feedback: Card(
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

class Block extends StatefulWidget {
  final Function onPressed;
  final String data;
  Block(this.onPressed, this.data);
  @override
  _BlockState createState() => _BlockState();
}

class _BlockState extends State<Block> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 20,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(
                Icons.close,
                size: 18,
              ),
              onPressed: widget.onPressed,
            ),
            Text(
              widget.data,
              style: TextStyle(fontSize: 15),
            )
          ],
        ),
      ),
    );
  }
}
