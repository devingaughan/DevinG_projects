import 'package:flutter/material.dart';

/*
  Class - EntryFormWidget
  This class utilizes material dart to create widgets for the entering of the
  journal details.
 */


class EntryFormWidget extends StatelessWidget {
  final bool? isImportant;
  final int? number;
  final String? title;
  final String? description;
  final ValueChanged<bool> onChangedImportant;
  final ValueChanged<int> onChangedNumber;
  final ValueChanged<String> onChangedTitle;
  final ValueChanged<String> onChangedDescription;

  const EntryFormWidget({
    Key? key,
    this.isImportant = false,
    this.number = 0,
    this.title = '',
    this.description = '',
    required this.onChangedImportant,
    required this.onChangedNumber,
    required this.onChangedTitle,
    required this.onChangedDescription,
  }) : super(key: key);

  /*
  The build widget is the root of the entry form page. It utilizes the
  SingleChildScrollView material design class to implement the two text
  boxes for the title and the actual content for the journal.
   */

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            buildTitle(),
            const SizedBox(height: 8),
            buildDescription(),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  /*
    Widget - buildTitle
    buildTitle utilizes the TextFormField class to store the title of the entry.
    It makes sure that the entry also has a title.
   */

    Widget buildTitle() {
      return TextFormField(
        maxLines: 1,
        initialValue: title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: 'Title',
        ),
        validator: (title) =>
        title != null && title.isEmpty ? 'The title cannot be empty' : null,
        onChanged: onChangedTitle,
      );
    }

    /*
    Widget - buildDescription
    This widget builds the text box that is needed to fill in the body of the
    journal entry. It also uses the TextFormField class. It also ensures that
    there must be a description/body in the entry.
     */

    Widget buildDescription() {
      return TextFormField(
        maxLines: 20,
        initialValue: description,
        style: const TextStyle(
            fontSize: 18
        ),

        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: 'Type something...',
        ),
        validator: (title) =>
        title != null && title.isEmpty
            ? 'The description cannot be empty'
            : null,
        onChanged: onChangedDescription,
      );
  }
}