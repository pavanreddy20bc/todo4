

1. **Overview**: A Flutter app to set daily reminders with local notifications.

2. **Dependencies**: Uses `flutter_local_notifications` for notifications and `timezone` for time zone handling.

3. **Setup**:
   - Initialize time zones with `tz.initializeTimeZones()`.
   - Configure notifications with an Android icon.

4. **UI Features**:
   - **Day Selector**: Dropdown to choose a day of the week.
   - **Time Picker**: Select reminder time.
   - **Activity Selector**: Dropdown for reminder activities.
   - **Reminder List**: Shows and allows deletion of upcoming reminders.

5. **Notification Scheduling**:
   - **Calculate Date/Time**: Adjusts for the chosen day and time.
   - **Schedule Notification**: Uses `zonedSchedule` for timing and sound.

6. **Notification Handling**:
   - **Popup Dialog**: Displays reminder details when a notification is tapped.

7. **Reminder Management**:
   - **Add Reminder**: Updates list and schedules notification.
   - **Delete Reminder**: Remove reminders from the list.

8. **Run Instructions**:
   - Clone the repo, run `flutter pub get` to install dependencies, and start the app.


