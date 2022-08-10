import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:testing/Models/entry_model.dart';

/*
  The colors used in the cards that show off the entries in the journal
 */
final _lightColors = [
  Colors.amber.shade300,
  Colors.lightGreen.shade300,
  Colors.lightBlue.shade300,
  Colors.orange.shade300,
  Colors.pinkAccent.shade100,
  Colors.tealAccent.shade100
];

/*
  Class - EntryCardWidget
  Purpose: This widget is used to actually create and display the card for
  an entry in the journal. It utilizes the Card class from Material Design.
  https://api.flutter.dev/flutter/material/Card-class.html
  All the relevant info for the class below can be found in the link.
  This function is used in the journal page class.
 */

class EntryCardWidget extends StatelessWidget {
  const EntryCardWidget({
    Key? key,
    required this.entry,
    required this.index,
  }) : super(key: key);

  final Entry entry;
  final int index;

  @override
  Widget build(BuildContext context) {
    /// Pick colors from the accent colors based on index
    final color = _lightColors[index % _lightColors.length];
    final time = DateFormat.yMMMd().format(entry.createdTime);
    final minHeight = getMinHeight(index);
    int displayLines = 2;
    if (minHeight == 150) {
      displayLines = 6;
    }

    return Card(
      color: color,
      child: Container(
        constraints: BoxConstraints(minHeight: minHeight),
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              time,
              style: TextStyle(color: Colors.grey.shade700),
            ),
            const SizedBox(height: 4),
            Text(
              entry.title,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              entry.description,
              style: TextStyle(
                color: Colors.black,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
              maxLines: displayLines,
            )
          ],
        ),
      ),
    );
  }

  /// To return different height for different widgets
  double getMinHeight(int index) {
    switch (index % 4) {
      case 0:
        return 100;
      case 1:
        return 150;
      case 2:
        return 150;
      case 3:
        return 100;
      default:
        return 100;
    }
  }
}