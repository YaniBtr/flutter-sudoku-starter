import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Grid extends StatelessWidget {

  final Color color;
  final Grid? childGrid;

  final dynamic width;
  final dynamic height;

  const Grid({super.key, required this.width, required this.height, this.color = Colors.black, this.childGrid});

  @override
  Widget build(BuildContext context) {

    var maxSize = height > width ? width : height;
    var boxSize = (maxSize / 3).ceil().toDouble();
    var numberOfElementsPerLine = 3;
    var numberOfBoxes = 3 * 3;

    return  SizedBox(
      height: boxSize * numberOfElementsPerLine,
      child: GridView.count(
        crossAxisCount: numberOfElementsPerLine,
        children: List.generate(numberOfBoxes, (x) {
          return Container(
          width: boxSize,
          height: boxSize,
          decoration: BoxDecoration(border: Border.all(color:  color)),
            child: childGrid,
          );
        }),
      ),
    );
  }




}