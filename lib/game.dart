import 'package:flutter/material.dart';
import 'package:sudoku_api/sudoku_api.dart';
import 'package:sudoku_starter/Components/GameCell.dart';
import 'Components/GameGrid.dart';

class Game extends StatefulWidget {

  const Game({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game> {
  Widget gameGrid = const CircularProgressIndicator();
  Puzzle puzzle = Puzzle(PuzzleOptions());
  List<String> _puzzleValues = [];
  List<Position> _puzzlePositions = [];
  List<String> _solution = [];
  final GlobalKey<GameGridState> _gameGridState = GlobalKey();

  void _generatePuzzle() {
    puzzle.generate().then((_) {
      _regenerateGameGrid();
    });
  }

  void _updatePuzzleValue(int value) {
    GameCellState? selectedCellState = _gameGridState.currentState?.selectedCellState;

    if(selectedCellState != null) {
      puzzle.board()!.cellAt(selectedCellState.widget.position).setValue(value);
      _regenerateGameGrid();
    }
  }

  void _regenerateGameGrid() {
    _extractPuzzleValuesAndPositions();

    setState(() {
      gameGrid = GameGrid(
        key: _gameGridState,
        height: MediaQuery.of(context).size.height / 2,
        width: MediaQuery.of(context).size.width,
        cellValues: _puzzleValues,
        cellPositions : _puzzlePositions,
        solution: _solution,
      );
    });
  }

  void _extractPuzzleValuesAndPositions() {
    _puzzleValues = [];
    _puzzlePositions = [];
    _solution = [];

    for(var a = 0; a < 3; a++) {
      for (var b = 0; b < 3; b++) {
        for (var x = 0; x < 3; x++) {
          for (var y = 0; y < 3; y++) {

            int? value = puzzle.board()?.matrix()?[x + (a * 3)][y + (b * 3)]
                .getValue();

            Position? position = puzzle.board()?.matrix()?[x + (a * 3)][y + (b * 3)]
                .getPosition();

            int? solutionValue = puzzle.solvedBoard()?.matrix()?[x + (a * 3)][y + (b * 3)]
                .getValue();

            if(value != null && position != null){
              String valueString =value > 0 ? value.toString() : "";
              _puzzleValues.add(valueString);
              _puzzlePositions.add(position);
              _solution.add(solutionValue.toString());
            }
          }
        }
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _generatePuzzle();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            gameGrid,
            Row(
              children: [
                ElevatedButton(onPressed: () => _updatePuzzleValue(0), child: const Text("Empty")),
                ElevatedButton(onPressed: () => _updatePuzzleValue(1), child: const Text("1")),
                ElevatedButton(onPressed: () => _updatePuzzleValue(2), child: const Text("2")),
                ElevatedButton(onPressed: () => _updatePuzzleValue(3), child: const Text("3")),
                ElevatedButton(onPressed: () => _updatePuzzleValue(4), child: const Text("4")),
              ],
            ),
            Row(
              children: [
                ElevatedButton(onPressed: () => _updatePuzzleValue(5), child: const Text("5")),
                ElevatedButton(onPressed: () => _updatePuzzleValue(6), child: const Text("6")),
                ElevatedButton(onPressed: () => _updatePuzzleValue(7), child: const Text("7")),
                ElevatedButton(onPressed: () => _updatePuzzleValue(8), child: const Text("8")),
                ElevatedButton(onPressed: () => _updatePuzzleValue(9), child: const Text("9")),
              ],
            )
          ],
        ),
      ),
    );
  }
}
