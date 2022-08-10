import 'package:flutter/material.dart';
import 'package:about/about.dart';
import 'package:testing/Utils/notificationservice.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}
class _SettingsState extends State<Settings> {


  void goalMet(goal)  {
    if (!goal) {
      NotificationService().showNotification(1, "title", "body", 2);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isIOS = theme.platform == TargetPlatform.iOS;

    /*
    AboutPage
    - Uses the flutter "about" package to display an "About Us" Page
    Properties:
    ApplicationVersion: Displays the version of your app
    ApplicationDescription: Small description of the app
    ApplicationIcon: Icon to display at the top of the page
    MarkdownPageListTile List: List of tiles to display markdown files, each
    with their own icon and associated Markdown file
     */
    return AboutPage(
      // values: {
      //   'version': '1.0',
      //   'year': DateTime.now().year.toString(),
      // },
      applicationVersion: 'Version 1.0',
      applicationDescription: const Text("MicroMe - Taking care of taking care of you"),
      applicationIcon: Image.asset('assets/QTZtransparent.png', height: 200, width: 200),
      children: const <Widget>[
        MarkdownPageListTile(
          filename: 'Markdown_Files/PURPOSE.md',
          title: Text('Purpose'),
          icon: Icon(Icons.star),
          fitContent: true,
        ),
        MarkdownPageListTile(
          filename: 'Markdown_Files/TUTORIAL.md',
          title: Text('App Tutorial'),
          icon: Icon(Icons.description),
        ),
        MarkdownPageListTile(
          filename: 'Markdown_Files/CONTRIBUTING.md',
          title: Text('Contributors'),
          icon: Icon(Icons.share),
        ),
        MarkdownPageListTile(
          filename: 'Markdown_Files/ACKNOWLEDGEMENT.md',
          title: Text('Acknowledgements'),
          icon: Icon(Icons.sentiment_satisfied),
        ),
        MarkdownPageListTile(
          filename: 'Markdown_Files/README.md',
          title: Text('View Readme'),
          icon: Icon(Icons.all_inclusive),
          selectable: true,
        ),
      ],
    );
  }
}