/*
  Class WaterGoalFields
  Instantiates column names in the WaterGoal database.
 */
class WaterGoalFields {
  // A list of all the values in the table
  static final List<String> values = [
    id, goal, time
  ];

  // Column names
  static const String id = '_id';
  static const String goal = 'goal';
  static const String time = 'time';
}

/*
  Class WaterGoal
  Represents a singular WaterGoal object with all its field values.
 */
class WaterGoal {
  final int? id;
  final int goal;
  final String createdTime;

  const WaterGoal({
    this.id,
    required this.goal,
    required this.createdTime,
  });

  // Makes a copy of a WaterGoal object to avoid modifying the original WaterGoal created
  WaterGoal copy({
    int? id,
    int? goal,
    String? createdTime,
  }) {
    return WaterGoal(
      id: id ?? this.id,
      goal:  goal ?? this.goal,
      createdTime: createdTime ?? this.createdTime,
    );
  }

  // Converting back from json to our WaterGoal type
  // createdTime and isImportant are two special cases as their types
  // are not natively supported by json and must be converted
  static WaterGoal fromJson(Map<String, Object?> json) {
    return WaterGoal(
        id: json[WaterGoalFields.id] as int?,
        goal: json[WaterGoalFields.goal] as int,
        createdTime: json[WaterGoalFields.time] as String
    );
  }

  // Function to map our values to the columns in the database
  // Converts our WaterGoal type to a json object
  Map<String, Object?> toJson() {
    return {
      WaterGoalFields.id: id,
      WaterGoalFields.goal: goal,
      WaterGoalFields.time: createdTime,};
  }
}