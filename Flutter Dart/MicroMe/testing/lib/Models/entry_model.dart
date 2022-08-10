/*
  Class EntryFields
  Instantiates column names in the entries database.
 */
class EntryFields {
  // A list of all the values in the table
  static final List<String> values = [
    id, isImportant, number, title, description, time
  ];

  // Column names
  static const String id = '_id';
  static const String isImportant = 'isImportant';
  static const String number = 'number';
  static const String title = 'title';
  static const String description = 'description';
  static const String time = 'time';
}

/*
  Class Entry
  Represents a singular entry object with all its field values.
 */
class Entry {
  final int? id;
  final bool isImportant;
  final int number;
  final String title;
  final String description;
  final DateTime createdTime;

  const Entry({
    this.id,
    required this.isImportant,
    required this.number,
    required this.title,
    required this.description,
    required this.createdTime,
  });

  // Makes a copy of an entry object to avoid modifying the original entry created
  Entry copy({
    int? id,
    bool? isImportant,
    int? number,
    String? title,
    String? description,
    DateTime? createdTime,
  }) {
    return Entry(
      id: id ?? this.id,
      isImportant: isImportant ?? this.isImportant,
      number:  number ?? this.number,
      title: title ?? this.title,
      description: description ?? this.description,
      createdTime: createdTime ?? this.createdTime,
    );
  }

  // Converting back from json to our entries type
  // createdTime and isImportant are two special cases as their types
  // are not natively supported by json and must be converted
  static Entry fromJson(Map<String, Object?> json) {
    return Entry(
        id: json[EntryFields.id] as int?,
        isImportant: json[EntryFields.isImportant] == 1,
        number: json[EntryFields.number] as int,
        title: json[EntryFields.title] as String,
        description: json[EntryFields.description] as String,
        createdTime: DateTime.parse(json[EntryFields.time] as String)
    );
  }

  // Function to map our values to the columns in the database
  // Converts our entrytype to a json object
  Map<String, Object?> toJson() {
    return {
      EntryFields.id: id,
      EntryFields.title: title,
      EntryFields.isImportant: isImportant ? 1 : 0,
      EntryFields.number:number,
      EntryFields.description: description,
      EntryFields.time: createdTime.toIso8601String(),};
  }
}