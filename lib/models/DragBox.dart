import 'package:code_your_home/models/Block.dart';
import 'package:flutter/material.dart';
import 'package:code_your_home/screens/home.dart';

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
      },
      /*setState(() {
          blocks = executable_codes.map(
            (block_label) {
              return Block(
                block_label,
                () {
                  setState(() {
                    aurduino_codes.remove(block_label);
                    blocks.removeWhere(
                        (Block element) => element.label == block_label);
                  });
                  print(aurduino_codes);
                },
              );
            },
          ).toList();
        });
      },*/
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
