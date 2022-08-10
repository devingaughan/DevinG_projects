import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:testing/Db/microme_db.dart';
import 'package:testing/Models/entry_model.dart';
import 'package:testing/Pages/Journal_Pages/add_edit_entry_page.dart';

/*
  Class - EntryDetailPage
  Purpose: This creates a stateful page that is used to edit an entry in the
  journal. It has an integer variable that holds the entry ID. It also allows
  for an entry to be edited or deleted.
 */

class EntryDetailPage extends StatefulWidget {
  final int entryId;

  const EntryDetailPage({
    Key? key,
    required this.entryId,
  }) : super(key: key);

  @override
  _EntryDetailPageState createState() => _EntryDetailPageState();
}

/*
  Class - _EntryDetailPageState
  Purpose: This serves as the state for the entry detail page.
  Crucially, it includes an entry variable to hold info for an entry.
 */

class _EntryDetailPageState extends State<EntryDetailPage> {
  late Entry entry;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    refreshEntry();
  }

  /*
  Function - refreshEntry
  This function queries the data base to get an entry with the provided id.
   */

  Future refreshEntry() async {
    setState(() => isLoading = true);

    entry = await MicromeDatabase.instance.readEntry(widget.entryId);

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const ImageIcon(AssetImage('assets/Back.png')),
          onPressed: () {
            Navigator.of(context).pop();
              },
        ),
        actions: [editButton(), deleteButton()],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(12),
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 8),
          children: [
            Text(
              entry.title,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              DateFormat.yMMMd().format(entry.createdTime),
            ),
            const SizedBox(height: 8),
            Text(
              entry.description,
              style: const TextStyle(
                  fontSize: 18
              ),
            )
          ],
        ),
      ),
    );
  }

  /*
  Widget - editButton
  This widget creates the button to be pressed when editing a note. It navigates
  to the add/edit entry page and outsources the work to that page. In the end,
  it refreshes the entry to ensure that it reflects the new changes.
   */

  Widget editButton() {
    return IconButton(
        icon: const ImageIcon(AssetImage('assets/Edit.png'),),
        onPressed: () async {
          if (isLoading) return;

          await Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => AddEditEntryPage(entry: entry),
          ));

          refreshEntry();
        });
  }

  /*
  Widget - deleteButton
  Implements the button that is used to delete entries from the journal database.
  It is basically a wrapper around the delete function for the journal database.
   */

  Widget deleteButton() {
    return IconButton(
      icon: const ImageIcon(AssetImage('assets/Trash.png'),),
      onPressed: () async {
        await MicromeDatabase.instance.deleteEntry(widget.entryId);
        Navigator.of(context).pop();
      },
    );
  }
}