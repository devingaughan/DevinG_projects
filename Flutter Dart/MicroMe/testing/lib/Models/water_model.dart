/*
  Class WaterFields
  Instantiates column names in the water database.
 */
class WaterFields {
  // A list of all the values in the table
  static final List<String> values = [
    id, amount, time
  ];

  // Column names
  static const String id = '_id';
  static const String amount = 'amount';
  static const String time = 'time';
}

/*
  Class Water
  Represents a singular Water object with all its field values.
 */
class Water {
  final int? id;
  final int amount;
  final String createdTime;

  const Water({
    this.id,
    required this.amount,
    required this.createdTime,
  });

  // Makes a copy of a Water object to avoid modifying the original Water created
  Water copy({
    int? id,
    int? amount,
    String? createdTime,
  }) {
    return Water(
      id: id ?? this.id,
      amount:  amount ?? this.amount,
      createdTime: createdTime ?? this.createdTime,
    );
  }

  // Converting back from json to our water type
  // createdTime and isImportant are two special cases as their types
  // are not natively supported by json and must be converted
  static Water fromJson(Map<String, Object?> json) {
    return Water(
        id: json[WaterFields.id] as int?,
        amount: json[WaterFields.amount] as int,
        createdTime: json[WaterFields.time] as String
    );
  }

  // Function to map our values to the columns in the database
  // Converts our Water type to a json object
  Map<String, Object?> toJson() {
    return {
      WaterFields.id: id,
      WaterFields.amount: amount,
      WaterFields.time: createdTime,};
  }
}