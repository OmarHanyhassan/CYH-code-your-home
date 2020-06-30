import 'package:flutter/material.dart';
import 'package:code_your_home/models/Block.dart';
import 'package:code_your_home/data/aurduino_codes.dart';
import 'package:code_your_home/data/blocks_labels.dart';
import 'package:code_your_home/models/DragBox.dart';

///Lists for `selected aurduino codes` and `blocks created after dragging each element`
List<String> executable_blocks_labels = List<String>();
List<String> executable_codes = List<String>();
List<Block> blocks = List<Block>();

///Building the `home` page
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: PopupMenuButton(
        color: Colors.white,
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
                  onAccept: (String code) {
                    setState(
                      () {
                        executable_codes.add(code);
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
