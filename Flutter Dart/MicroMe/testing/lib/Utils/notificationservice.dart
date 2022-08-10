import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;


class NotificationService {

  //----------------------------------------------------------------------------
  /*
  These lines create a Singleton object in dart. Singletons ensure only one
  instance of the class exists. Every reference of NotificationService will refer
  to a single instance detailed below. This makes sure that the notifications
  are all scheduled in the same fashion, with the only malleable parameters
  being the time and content of the scheduled notification
  */
  static final NotificationService _notificationService = NotificationService._internal();
  factory NotificationService() {
    return _notificationService;
  }
  NotificationService._internal();
  //----------------------------------------------------------------------------

  // Creates an instance of the plugin class. Plugin checks for the correct
  // platform to make sure the platform-specific settings are used
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  /*
  initNotification()
  - Notification initialization class. Uses platform specific initialization
  settings.
  Properties:
  - AndroidInitializationSettings - Android-specific. Establishes notification
  icon to use alongside the notifications
  - IOSInitializationSettings - Requests the appropriate notification perms
  specified by iOS
  - InitializationSettings - Calls previous two methods to establish
  platform-specific init settings.
   */
  Future<void> initNotification() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    const IOSInitializationSettings initializationSettingsIOS =
    IOSInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,

    );

    const InitializationSettings initializationSettings =
    InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: initializationSettingsIOS
    );

    // Initializes notification plugin with the init settings.
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  /*
  showNotification()
  - Function to display the notification. Uses a scheduled notification and the
  timezone package to allow for notifications to be sent at a specific
  amount of time after request.
  Parameters:
  id - ID of the notification
  title - Title of notification
  body - Subsequent text of the notification
  seconds - How many seconds to wait to send the notification upon toggle
   */
  Future<void> showNotification(int id, String title, String body, int seconds) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      /*
      Creates an instance of TZDateTime with the current local time summed using
      the add method with the number of sections specified in the seconds
      parameter.
       */
      tz.TZDateTime.now(tz.local).add(Duration(seconds: seconds)),

      // Class to specify per-platform details of each notification
      const NotificationDetails(
        /*
        AndroidNotificationDetails specifies the necessary Android-specific
        features of the notification
        Properties:
        channel_id - id to identify the channel by
        Name - User-visible name of channel
        channelDescription - Description of the notification channel
        importance - Importance of the notification (Android 8.0 or above)
        priority - Priority of the notification (Android 7.1 or lower)
        icon - Icon of notifications
         */
        android: AndroidNotificationDetails(
            'main_channel',
            'Main Channel',
            channelDescription: 'Main channel notifications',
            importance: Importance.max,
            priority: Priority.max,
            icon: '@mipmap/ic_launcher'
        ),
        /*
        IOSNotificationDetails specifies IOS-specific features
        Properties:
        sound - Sound file to use for notification
        presentAlert/Badge/Sound - Different notification features to enable
        or disable
         */
        iOS: IOSNotificationDetails(
          sound: 'default.wav',
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
      ),
      // Interprets the local notification date for iOS in GMT time
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      androidAllowWhileIdle: true, // Allows notifications in low-power mode
    );
  }
}
