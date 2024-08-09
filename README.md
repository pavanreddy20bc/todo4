<img width="1440" alt="Screenshot 2024-08-09 at 2 47 37 PM" src="https://github.com/user-attachments/assets/cf649996-0dca-4982-82c6-53863333df17">

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
  
   <img width="1440" alt="Screenshot 2024-08-09 at 2 47 37 PM" src="https://github.com/us<img width="1440" alt="Screenshot 2024-08-09 at 2 51 24 PM" src="https://github.com/user-attachments/assets/02067975-c2e4-4f60-928d-36a552851c4b">
er-attachments/assets/f5683ead-c020-4e98-9ff3-fc1c5b2bdaf7">

<img width="1440" alt="Screenshot 2024-08-09 at 2 47 45 PM" src="https://github.com/user-attachments/assets/b94b9dbc-8d43-4eb0-994d-14f87c68df1a"><img width="1440" alt="Screenshot 2024-08-09 at 2 47 49 PM" src="https://github.com/user-attachments/assets/0b6d373d-8eb4-4f29-82f6-c9e8e83336e1">
<img width="1440" alt="Screenshot 2024-08-09 at 2 51 33 PM" src="https://github.com/user-attachments/assets/b8192909-0cf6-46ba-acd1-b126680dc44b">





