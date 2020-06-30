import 'package:flutter/material.dart';

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
