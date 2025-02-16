import 'package:flutter/material.dart';
import 'package:sudoku_api/sudoku_api.dart';
import 'package:sudoku_starter/Components/GameCell.dart';

class GameGrid extends StatefulWidget {

  final dynamic width;
  final dynamic height;
  final List<String> cellValues;
  final List<Position> cellPositions;
  final List<String> solution;

  const GameGrid({super.key, required this.width, required this.height, required this.cellValues, required this.cellPositions, required this.solution});

  @override
  State<GameGrid> createState() => GameGridState();

}

class GameGridState extends State<GameGrid> {
  GameCellState? _selectedCellState;

  @override
  Widget build(BuildContext context) {

    var maxSize = widget.height > widget.width ? widget.width : widget.height;
    var boxSize = (maxSize / 3).ceil().toDouble();
    var numberOfElementsPerLine = 3;
    var numberOfBoxes = 3 * 3;

      int i = 0;

      return  SizedBox(
        height: boxSize * numberOfElementsPerLine,
        child: GridView.count(
          crossAxisCount: numberOfElementsPerLine,
          children: List.generate(numberOfBoxes, (x) {
            return Container(
              width: boxSize,
              height: boxSize,
              decoration: BoxDecoration(border: Border.all(color:  Colors.blue)),
              child: SizedBox(
                height: boxSize * numberOfElementsPerLine,
                child: GridView.count(
                  crossAxisCount: numberOfElementsPerLine,
                  children: List.generate(numberOfBoxes, (x) {
                    return GameCell(
                        width: widget.width,
                        height: widget.height,
                        value: Text(
                            widget.cellValues[i++] == "" ? widget.solution[i-1] : widget.cellValues[i-1],
                            style: TextStyle(
                              color:  widget.cellValues[i-1] == "" ? Colors.black : Colors.black12,
                            ),
                        ),
                        onCellSelected: _selectCell,
                        position: widget.cellPositions[i-1]
                    );
                  }),
                ),
              ),
            );
          }),
        ),
      );

  }

  void _selectCell(GameCellState state) {
    _selectedCellState?.updateSelection(!(_selectedCellState!.isSelected));

    if(state != _selectedCellState) {
      state.updateSelection(true);
      _selectedCellState = state;
    } else {
      _selectedCellState = null;
    }
  }

  GameCellState? get selectedCellState => _selectedCellState;
}
