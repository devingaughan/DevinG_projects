/*
  Class StepFields
  Instantiates column names in the step database.
 */
class StepFields {
  // A list of all the values in the table
  static final List<String> values = [
    id, steps, time
  ];

  // Column names
  static const String id = '_id';
  static const String steps = 'steps';
  static const String time = 'time';
}

/*
  Class Step
  Represents a singular Step object with all its field values.
 */
class Step {
  final int? id;
  final int steps;
  final DateTime createdTime;

  const Step({
    this.id,
    required this.steps,
    required this.createdTime,
  });

  // Makes a copy of a Step object to avoid modifying the original Step created
  Step copy({
    int? id,
    int? steps,
    DateTime? createdTime,
  }) {
    return Step(
      id: id ?? this.id,
      steps:  steps ?? this.steps,
      createdTime: createdTime ?? this.createdTime,
    );
  }

  // Converting back from json to our step type
  // createdTime and isImportant are two special cases as their types
  // are not natively supported by json and must be converted
  static Step fromJson(Map<String, Object?> json) {
    return Step(
        id: json[StepFields.id] as int?,
        steps: json[StepFields.steps] as int,
        createdTime: DateTime.parse(json[StepFields.time] as String)
    );
  }

  // Function to map our values to the columns in the database
  // Converts our Step type to a json object
  Map<String, Object?> toJson() {
    return {
      StepFields.id: id,
      StepFields.steps: steps,
      StepFields.time: createdTime.toIso8601String(),};
  }
}