import 'package:flutter/material.dart';
import 'package:sudoku_api/sudoku_api.dart';

class GameCell extends StatefulWidget{
  final Text value;
  final dynamic width;
  final dynamic height;
  final Function(GameCellState) onCellSelected;
  final Position position;


  const GameCell({super.key, required this.position, required this.width, required this.height, required this.value, required this.onCellSelected});

  @override
  State<GameCell> createState() => GameCellState();
}

class GameCellState extends State<GameCell> {
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
              child: widget.value
            ),
          )
        )
      );
  }
}

