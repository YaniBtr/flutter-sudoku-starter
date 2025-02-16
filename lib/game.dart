import 'package:flutter/material.dart';
import 'package:sudoku_api/sudoku_api.dart';
import 'Components/GameGrid.dart';

class Game extends StatefulWidget {

  const Game({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game> {
  Widget gameGrid = const CircularProgressIndicator();

  List<String> puzzleValues = [];

  void _generatePuzzle() {
    Puzzle puzzle = Puzzle(PuzzleOptions());

    puzzle.generate().then((_) {
      setState(() {
        gameGrid = GameGrid(
          height: MediaQuery.of(context).size.height / 2,
          width: MediaQuery.of(context).size.width,
          cellValues: _extractPuzzleValues(puzzle),
        );
      });
    });
  }

  List<String> _extractPuzzleValues(Puzzle puzzle) {

    List<String> puzzleValues = [];

    for(var a = 0; a < 3; a++) {
      for (var b = 0; b < 3; b++) {
        for (var x = 0; x < 3; x++) {
          for (var y = 0; y < 3; y++) {

            int? value = puzzle.board()?.matrix()?[x + (a * 3)][y + (b * 3)]
                .getValue();

            if(value != null){
              puzzleValues.add(value > 0 ? value.toString() : "");
            }
          }
        }
      }
    }

    return puzzleValues;
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
            gameGrid
          ],
        ),
      ),
    );
  }
}
