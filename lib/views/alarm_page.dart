import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:sample_alarm/constans/alarm_helper.dart';
import 'package:sample_alarm/common/theme_data.dart';
import 'package:sample_alarm/main.dart';
import 'package:sample_alarm/models/alarm_info.dart';

class Alarm extends StatefulWidget {
  const Alarm({Key? key}) : super(key: key);

  @override
  _AlarmState createState() => _AlarmState();
}

class _AlarmState extends State<Alarm> {
  late DateTime _alarmTime;
  late String _alarmTimeString;
  final AlarmHelper _alarmHelper = AlarmHelper();
  Future<List<DataAlarm>>? _alarms;
  List<DataAlarm>? _currentAlarms;

  @override
  void initState() {
    _alarmTime = DateTime.now();
    _alarmHelper.initializeDatabase().then((value) {
      // ignore: avoid_print
      print('database intialized');
      loadAlarms();
    });
    super.initState();
  }

  void loadAlarms() {
    _alarms = _alarmHelper.getAlarms();
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 64),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Alarm',
                style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Row(
                children: const [
                  Text(
                    "Tidur",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 5),
                  Text(
                    "|",
                    style: TextStyle(
                        color: Colors.white,
                        // fontSize: 17,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 5),
                  Text(
                    "bangun",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              )
            ],
          ),
          Expanded(
            child: FutureBuilder<List<DataAlarm>>(
              future: _alarms,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  _currentAlarms = snapshot.data;
                  return ListView(
                    children: snapshot.data!.map<Widget>((alarm) {
                      var alarmTime =
                          DateFormat('hh:mm aa').format(alarm.alarmDateTime!);

                      return Container(
                        margin: const EdgeInsets.only(bottom: 32),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        decoration: const BoxDecoration(
                          color: Color(0xFF242634),
                          borderRadius: BorderRadius.all(Radius.circular(24)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    const Icon(
                                      Icons.label,
                                      color: Colors.white,
                                      size: 24,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      alarm.title ?? '-',
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'NunitoSans'),
                                    ),
                                  ],
                                ),
                                Switch(
                                  onChanged: (bool value) {},
                                  value: true,
                                  activeColor: Colors.green,
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  alarmTime,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'NunitoSans',
                                      fontSize: 24,
                                      fontWeight: FontWeight.w700),
                                ),
                                IconButton(
                                    icon: const Icon(Icons.delete),
                                    color: Colors.redAccent,
                                    onPressed: () {
                                      deleteAlarm(alarm.id!);
                                    }),
                              ],
                            ),
                          ],
                        ),
                      );
                    }).followedBy([
                      if (_currentAlarms!.length < 5)
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: CustomColors.clockBG,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(24)),
                          ),
                          child: FlatButton(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 32, vertical: 16),
                            onPressed: () {
                              _alarmTimeString =
                                  DateFormat('HH:mm').format(DateTime.now());
                              showModalBottomSheet(
                                useRootNavigator: true,
                                context: context,
                                clipBehavior: Clip.antiAlias,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(20),
                                  ),
                                ),
                                builder: (context) {
                                  return StatefulBuilder(
                                    builder: (context, setModalState) {
                                      return Container(
                                        padding: const EdgeInsets.all(32),
                                        child: Column(
                                          children: [
                                            FlatButton(
                                              onPressed: () async {
                                                var selectedTime =
                                                    await showTimePicker(
                                                  context: context,
                                                  initialTime: TimeOfDay.now(),
                                                );
                                                if (selectedTime != null) {
                                                  final now = DateTime.now();
                                                  var selectedDateTime =
                                                      DateTime(
                                                          now.year,
                                                          now.month,
                                                          now.day,
                                                          selectedTime.hour,
                                                          selectedTime.minute);
                                                  _alarmTime = selectedDateTime;
                                                  setModalState(() {
                                                    _alarmTimeString =
                                                        DateFormat('HH:mm')
                                                            .format(
                                                                selectedDateTime);
                                                  });
                                                }
                                              },
                                              child: Text(
                                                _alarmTimeString,
                                                style: const TextStyle(
                                                    fontSize: 32),
                                              ),
                                            ),
                                            const ListTile(
                                              title: Text('Repeat'),
                                              trailing:
                                                  Icon(Icons.arrow_forward_ios),
                                            ),
                                            const ListTile(
                                              title: Text('Sound'),
                                              trailing:
                                                  Icon(Icons.arrow_forward_ios),
                                            ),
                                            const ListTile(
                                              title: Text('Title'),
                                              trailing:
                                                  Icon(Icons.arrow_forward_ios),
                                            ),
                                            FloatingActionButton.extended(
                                              onPressed: onSaveAlarm,
                                              icon: const Icon(
                                                Icons.alarm_on,
                                                color: Colors.white24,
                                              ),
                                              label: const Text('Save'),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                },
                              );
                              // scheduleAlarm();
                            },
                            child: Column(
                              children: [
                                Image.asset(
                                  'assets/add_alarm.png',
                                  scale: 1.5,
                                  color: Colors.blueAccent,
                                ),
                                const SizedBox(height: 8),
                                const Text(
                                  'Add Alarm',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'NunitoSans'),
                                ),
                              ],
                            ),
                          ),
                        )
                      else
                        const Center(
                            child: Text(
                          'Limit Max Alarm!',
                          style: TextStyle(color: Colors.white),
                        )),
                    ]).toList(),
                  );
                }
                return const Center(
                  child: Text(
                    'Loading..',
                    style: TextStyle(color: Colors.white),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  void scheduleAlarm(
      DateTime scheduledNotificationDateTime, DataAlarm alarmInfo) async {
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
      'alarm_notif',
      'Channel for Alarm notification',
      icon: 'ic_launcher',
      importance: Importance.max,
      priority: Priority.high,
      sound: RawResourceAndroidNotificationSound('a_long_cold_sting'),
      largeIcon: DrawableResourceAndroidBitmap('ic_launcher'),
    );

    var iOSPlatformChannelSpecifics = const IOSNotificationDetails(
      sound: 'a_long_cold_sting.wav',
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);

    // flutterLocalNotificationsPlugin.show(
    //   0,
    //   'New Alert',
    //   alarmInfo.title,
    //   platformChannelSpecifics,
    //   payload: 'Default Sound',
    // );

    // ignore: deprecated_member_use
    await flutterLocalNotificationsPlugin.schedule(
      0,
      'notif',
      alarmInfo.title,
      // alarmInfo.description,
      scheduledNotificationDateTime,
      platformChannelSpecifics,
    );
  }

  void onSaveAlarm() {
    DateTime scheduleAlarmDateTime;
    if (_alarmTime.isAfter(DateTime.now())) {
      scheduleAlarmDateTime = _alarmTime;
    } else {
      scheduleAlarmDateTime = _alarmTime.add(const Duration(days: 1));
    }

    var alarmInfo = DataAlarm(
      alarmDateTime: scheduleAlarmDateTime,
      gradientColorIndex: _currentAlarms!.length,
      title: 'alarm',
    );
    _alarmHelper.insertAlarm(alarmInfo);
    scheduleAlarm(scheduleAlarmDateTime, alarmInfo);
    Navigator.pop(context);
    loadAlarms();
  }

  void deleteAlarm(int id) {
    _alarmHelper.delete(id);
    //unsubscribe for notification
    loadAlarms();
  }
}
