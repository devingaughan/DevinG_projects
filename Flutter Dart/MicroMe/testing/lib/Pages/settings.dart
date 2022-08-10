import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:testing/Utils/notificationservice.dart';


class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}
class _SettingsState extends State<Settings> {
  bool _notifs = true;

  void goalMet(goal)  {
    if (!goal) {
      NotificationService().showNotification(1, "title", "body", 2);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /* AppBar for settings
        Properties:
        Title - Displays AppBar Title
        Leading - Leading Icon Button at top-left acts as return button
        */
      appBar: AppBar(
          title: const Text('Settings'),
          leading: IconButton(
            icon: const ImageIcon(AssetImage('assets/Back.png'),),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
      ),
      /*
      SettingsList body provides list of settings divided into individual
      sections.
      Uses settings_ui package
      Properties:
      sections - List of different settings sections
       */
      body: SettingsList(
        sections: [
          SettingsSection(
            title: const Text('GENERAL'),
            tiles: [
              SettingsTile(
                title: const Text('Example 1'),
                leading: const Icon(Icons.language),
                onPressed: (BuildContext context) {},
              ),
              SettingsTile.switchTile(
                title: const Text('Lock app in background'),
                leading: const Icon(Icons.phonelink_lock),
                onToggle: (bool value) {
                  setState(() {
                    _notifs = value;
                    goalMet(_notifs);
                  });
                },
                initialValue: _notifs,
              ),
              CustomSettingsTile(
                  child: IconButton(
                    icon: const ImageIcon(
                      AssetImage('assets/home.png'),
                    ),
                    onPressed: () {
                      NotificationService().showNotification(1, "title", "body", 10);
                    },
                  )
              ),
            ],
          ),
        ],
      ),
    );
  }
}