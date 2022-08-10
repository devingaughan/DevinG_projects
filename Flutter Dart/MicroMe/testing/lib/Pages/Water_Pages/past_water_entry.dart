  // past water entries
  // Used in the class water_page.dart
  //    To track past entries and is updated dynamically.
  // Has three properties added: (text to show user),
  //                      amount: which is a double to show amount added
  //                      time: when amount was added

class PastWaterEntry {
  final String added;
  final String amount;
  final String time;

  PastWaterEntry(
    this.added,
    this.amount,
    this.time,
  );

}