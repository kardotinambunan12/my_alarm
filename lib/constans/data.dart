import 'package:sample_alarm/common/enums.dart';
import 'package:sample_alarm/constans/info.dart';
import 'package:sample_alarm/models/alarm_info.dart';

List<MenuInfo> menuItems = [
  MenuInfo(MenuType.clock,
      title: 'Clock', imageSource: 'assets/clock_icon.png'),
  MenuInfo(MenuType.alarm,
      title: 'Alarm', imageSource: 'assets/alarm_icon.png'),
];

List<DataAlarm> alarms = [
  DataAlarm(
      alarmDateTime: DateTime.now().add(const Duration(hours: 1)),
      title: 'Alarm1',
      gradientColorIndex: 0),
  DataAlarm(
      alarmDateTime: DateTime.now().add(const Duration(hours: 2)),
      title: 'Alarm2',
      gradientColorIndex: 1),
];
