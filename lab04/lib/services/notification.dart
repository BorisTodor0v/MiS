import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

class NotificationService {

  static Future<void> init() async{
    await AwesomeNotifications().initialize(
      null,
      [
        NotificationChannel(
          channelKey: 'high_importance_channel',
          channelName: 'Notifications',
          channelDescription: 'Notification channel description',
          importance: NotificationImportance.Default,
          playSound: true
        )
      ],
      channelGroups: [
        NotificationChannelGroup(
          channelGroupKey: 'high_importance_group',
          channelGroupName: 'Group 1'
        )
      ]
    );
    
    await AwesomeNotifications().isNotificationAllowed().then(
      (isAllowed) async {
        if(!isAllowed){
          await AwesomeNotifications().requestPermissionToSendNotifications();
        }
      }
    );

    await AwesomeNotifications().setListeners(
      onActionReceivedMethod: onActionReceivedMethod,
      onNotificationCreatedMethod: onNotificationCreatedMethod,
      onNotificationDisplayedMethod: onNotificationDisplayedMethod,
      onDismissActionReceivedMethod: onDismissActionReceivedMethod,
    );

  }

  static Future<void> onNotificationCreatedMethod(ReceivedNotification receivedNotification) async {
    debugPrint('onNotificationCreatedMethod');
  }

  static Future<void> onNotificationDisplayedMethod(ReceivedNotification receivedNotification) async {
    debugPrint('onNotificationDisplayedMethod');
  }

  static Future<void> onDismissActionReceivedMethod(ReceivedAction receivedAction) async {
    debugPrint('onDismissActionReceivedMethod');
  }

  static Future<void> onActionReceivedMethod(ReceivedAction receivedAction) async {
    debugPrint('onActionReceivedMethod');
  }

  // test scheduled notification - notification pops up 5 seconds after method is called
  /*
  static Future showSimpleNotification() async {
    Exam exam = Exam(course: "Test course",timestamp: DateTime.now().add(Duration(seconds: 5)));
    DateTime reminderTime = exam.timestamp;
    debugPrint("Notification set to fire at ${DateFormat('dd/MM/yyyy HH:mm:ss').format(reminderTime)}");
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: -1,
        channelKey: 'high_importance_channel',
        title: "Test notification",
        body: "This is a test scheduled notification fired 5 seconds after pressing a button"
      ),
      schedule: NotificationCalendar(
        year: reminderTime.year,
        month: reminderTime.month,
        day: reminderTime.day,
        hour: reminderTime.hour,
        minute: reminderTime.minute,
        second: reminderTime.second
      )
    );
  }
   */

  // scheduled notification - reminder 1 day before exam
  static Future showScheduledNotificationDayBefore(String course, DateTime examTime) async {
    DateTime reminderTime = examTime.subtract(const Duration(hours: 24));
    debugPrint("Notification set to fire at ${DateFormat('dd/MM/yyyy HH:mm:ss').format(reminderTime)}");
    AwesomeNotifications().createNotification(
        content: NotificationContent(
            id: -1,
            channelKey: 'high_importance_channel',
            title: "Exam reminder",
            body: "You have an upcoming exam for $course tomorrow at ${DateFormat('HH:mm').format(examTime)}"
        ),
        schedule: NotificationCalendar(
            year: reminderTime.year,
            month: reminderTime.month,
            day: reminderTime.day,
            hour: reminderTime.hour,
            minute: reminderTime.minute,
            second: reminderTime.second
        )
    );
  }

  // scheduled notification - reminder 1 hour before exam
  static Future showScheduledNotificationHourBefore(String course, DateTime examTime) async {
    DateTime reminderTime = examTime.subtract(const Duration(minutes: 60));
    debugPrint("Notification set to fire at ${DateFormat('dd/MM/yyyy HH:mm:ss').format(reminderTime)}");
    AwesomeNotifications().createNotification(
        content: NotificationContent(
            id: -1,
            channelKey: 'high_importance_channel',
            title: "Exam reminder",
            body: "You have an upcoming exam for $course in one hour at ${DateFormat('HH:mm').format(examTime)}! Good luck"
        ),
        schedule: NotificationCalendar(
            year: reminderTime.year,
            month: reminderTime.month,
            day: reminderTime.day,
            hour: reminderTime.hour,
            minute: reminderTime.minute,
            second: reminderTime.second
        )
    );
  }

  static Future cancelScheduledNotifications() async {
    await AwesomeNotifications().cancelAllSchedules();
  }


}