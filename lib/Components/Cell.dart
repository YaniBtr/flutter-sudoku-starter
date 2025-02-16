import 'package:flutter/material.dart';

class Cell extends StatefulWidget{
  final String value;
  final dynamic width;
  final dynamic height;
  final Function(CellState) onCellSelected;

  const Cell({super.key, required this.width, required this.height, required this.value, required this.onCellSelected});

  @override
  State<Cell> createState() => CellState();
}

class CellState extends State<Cell> {
  bool _isSelected = false;

  void updateSelection(bool isSelected) {
    setState(() {
      _isSelected = isSelected;
    });
  }

  bool get isSelected => _isSelected;

  @override
  Widget build(BuildContext context) {
    return
      Container(
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          border: Border.all(color:  Colors.black),
        ),
        child: Material(
          color: _isSelected ?
          Colors.blueAccent.shade100.withAlpha(100) :
          Colors.transparent,
          child: InkWell(
            onTap: () => widget.onCellSelected(this),
            child: Center(
              child: Text(widget.value)
            ),
          )
        )
      );
  }
}

