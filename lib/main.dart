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

List<String> blocks_labels = ["open light", "close light", "close fan"];

List<String> aurduino_codes = [
  "void openLight()",
  "void closeLight()",
  "void closeFan()",
];

List<String> executable_blocks_labels = List<String>();

List<String> executable_codes = List<String>();

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
        child: Icon(
          Icons.more_vert,
          color: Colors.black,
        ),
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
            child: ListView.builder(
              itemCount: aurduino_codes.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.only(
                    top: 10,
                    right: 15,
                  ),
                  child: DragBox(
                    blocks_labels[index],
                    aurduino_codes[index],
                    Colors.grey[800],
                  ),
                );
              },
            ),
          ),
          Expanded(
            flex: 4,
            child: Stack(
              alignment: Alignment.center,
              children: [
                DragTarget(
                  onAccept: (String aurduino_code) {
                    setState(
                      () {
                        executable_codes.add(aurduino_code);
                        print(executable_codes);
                        //print(blocks);
                      },
                    );
                  },
                  builder: (context, accepted, rejected) {
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
  final String label;
  final String aurduino_code;
  final Color itemColor;
  DragBox(this.label, this.aurduino_code, this.itemColor);

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
      data: widget.aurduino_code,
      child: Container(
        color: widget.itemColor,
        height: 100,
        width: 100,
        child: Card(
          child: Text(
            widget.label,
          ),
        ),
      ),
      onDragCompleted: () {
        setState(() {
          blocks = executable_codes.map(
            (block_label) {
              return Block(block_label, () {});
            },
          ).toList();
        });
        /*setState(() {
        blocks = blocks_labels.map(
          (e) {
            return Block(
              e,
              () {
                //setState(() {
                //aurduino_codes.remove(e);
                //blocks.removeWhere((Block element) => element.label == e);
                //});
                print(aurduino_codes);
              },
            );
          },
        ).toList();
        //});*/
      },
      feedback: Card(
        color: widget.itemColor.withOpacity(0.5),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
          child: Text(
            widget.label,
            style: TextStyle(fontSize: 15),
          ),
        ),
      ),
    );
  }
}

class Block extends StatefulWidget {
  final String label;
  final Function onPressed;
  Block(this.label, this.onPressed);
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
              widget.label,
              style: TextStyle(fontSize: 15),
            )
          ],
        ),
      ),
    );
  }
}
