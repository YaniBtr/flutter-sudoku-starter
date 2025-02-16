import 'package:flutter/material.dart';

class GameGrid extends StatelessWidget {

  final dynamic width;
  final dynamic height;
  List<String> values;

  GameGrid({super.key, required this.width, required this.height, required this.values});

  @override
  Widget build(BuildContext context) {

    var maxSize = height > width ? width : height;
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
                    return Container(
                      width: boxSize,
                      height: boxSize,
                      decoration: BoxDecoration(border: Border.all(color:  Colors.black)),
                      child: Center(child: Text(values[i++].toString())),
                    );
                  }),
                ),
              ),
            );
          }),
        ),
      );

  }
}