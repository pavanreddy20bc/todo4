import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

void main() {
  tz.initializeTimeZones();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Reminder App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Roboto',
      ),
      home: ReminderPage(),
    );
  }
}

class ReminderPage extends StatefulWidget {
  @override
  _ReminderPageState createState() => _ReminderPageState();
}

class _ReminderPageState extends State<ReminderPage> {
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  String _selectedDay = 'Monday';
  TimeOfDay _selectedTime = TimeOfDay.now();
  String _selectedActivity = 'Wake up';

  final List<String> _days = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday'
  ];
  final List<String> _activities = [
    'Wake up',
    'Go to gym',
    'Breakfast',
    'Meetings',
    'Lunch',
    'Quick nap',
    'Go to library',
    'Dinner',
    'Go to sleep'
  ];

  List<String> _upcomingReminders = [];

  @override
  void initState() {
    super.initState();
    _initializeNotifications();
  }

  Future<void> _initializeNotifications() async {
    await _flutterLocalNotificationsPlugin.initialize(
      InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      ),
      onDidReceiveNotificationResponse: _onNotificationResponse,
    );
  }

  Future<void> _onNotificationResponse(NotificationResponse response) async {
    if (response.payload != null) {
      _showReminderPopup(response.payload!);
    }
  }

  Future<void> _scheduleNotification(String title, TimeOfDay time) async {
    final tz.TZDateTime scheduledDate = tz.TZDateTime(
      tz.local,
      tz.TZDateTime.now(tz.local).year,
      tz.TZDateTime.now(tz.local).month,
      tz.TZDateTime.now(tz.local).day +
          ((_days.indexOf(_selectedDay) -
              tz.TZDateTime.now(tz.local).weekday +
              7) %
              7),
      time.hour,
      time.minute,
    );

    await _flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      title,
      'Reminder: $title at ${time.format(context)}',
      scheduledDate,
      NotificationDetails(
        android: AndroidNotificationDetails(
          'your_channel_id',
          'your_channel_name',
          importance: Importance.max,
          priority: Priority.high,
          playSound: true,
          sound: RawResourceAndroidNotificationSound('notification'),
        ),
      ),
      androidAllowWhileIdle: true, // Use this instead if androidScheduleMode isn't available
      uiLocalNotificationDateInterpretation:
      UILocalNotificationDateInterpretation.wallClockTime,
      matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
      payload: title,
    );
  }

  void _showReminderPopup(String title) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Reminder Alert'),
          content: Text('It\'s time for: $title'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reminder App'),
        leading: Icon(Icons.alarm),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Set Your Daily Reminder',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DropdownButtonFormField<String>(
                      value: _selectedDay,
                      onChanged: (newValue) =>
                          setState(() => _selectedDay = newValue!),
                      items: _days.map<DropdownMenuItem<String>>((String value) =>
                          DropdownMenuItem<String>(
                              value: value, child: Text(value))).toList(),
                      decoration: InputDecoration(
                        labelText: 'Day of the Week',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    ListTile(
                      title: Text('Time: ${_selectedTime.format(context)}'),
                      trailing: Icon(Icons.keyboard_arrow_down),
                      onTap: _selectTime,
                    ),
                    SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      value: _selectedActivity,
                      onChanged: (newValue) =>
                          setState(() => _selectedActivity = newValue!),
                      items: _activities
                          .map<DropdownMenuItem<String>>((String value) =>
                          DropdownMenuItem<String>(
                              value: value, child: Text(value)))
                          .toList(),
                      decoration: InputDecoration(
                        labelText: 'Activity',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: _setReminder,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding: EdgeInsets.symmetric(
                            horizontal: 50, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      child: Text('Set Reminder'),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 32),
            Text(
              'Upcoming Reminders',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            if (_upcomingReminders.isEmpty)
              Text('No upcoming reminders.')
            else
              ..._upcomingReminders.map((reminder) => ListTile(
                title: Text(reminder),
                leading: Icon(Icons.notifications),
                contentPadding: EdgeInsets.symmetric(vertical: 8.0),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => setState(() =>
                      _upcomingReminders.remove(reminder)),
                ),
              )),
          ],
        ),
      ),
    );
  }

  Future<void> _selectTime() async {
    final picked = await showTimePicker(
        context: context, initialTime: _selectedTime);
    if (picked != null && picked != _selectedTime)
      setState(() => _selectedTime = picked);
  }

  void _setReminder() {
    final reminder =
        '$_selectedActivity on $_selectedDay at ${_selectedTime.format(context)}';
    setState(() => _upcomingReminders.add(reminder));
    _scheduleNotification(_selectedActivity, _selectedTime);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Reminder Set'),
        content: Text(reminder),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('OK'),
          )
        ],
      ),
    );
  }
}
