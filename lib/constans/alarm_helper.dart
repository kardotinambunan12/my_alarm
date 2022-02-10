import 'package:sample_alarm/models/alarm_info.dart';
import 'package:sqflite/sqflite.dart';

const String tableAlarm = 'alarm';
const String columnId = 'id';
const String columnTitle = 'title';
// const String columnDescription = 'description';
const String columnDateTime = 'alarmDateTime';
const String columnPending = 'isPending';
const String columnColorIndex = 'gradientColorIndex';

const String tableName = 'alarm';

class AlarmHelper {
  static Database? _database;
  static AlarmHelper? _alarmHelper;

  AlarmHelper._createInstance();
  factory AlarmHelper() {
    _alarmHelper ??= AlarmHelper._createInstance();
    return _alarmHelper!;
  }

  Future<Database> get database async {
    _database ??= await initializeDatabase();
    // if (_database == null) {
    //   _database = await initializeDatabase();
    // }

    return _database!;
  }

  Future<Database> initializeDatabase() async {
    var dir = await getDatabasesPath();
    var path = dir + "alarm.db";

    var database = openDatabase(path, version: 1, onCreate: (db, version) {
      db.execute('''
        create table $tableAlarm ( 
          $columnId integer primary key autoincrement, 
          $columnTitle text not null,
          $columnDateTime text not null,
          $columnPending integer,
          $columnColorIndex integer)
      ''');
    });

    return database;
  }

  Future<void> insertAlarm(DataAlarm alarmInfo) async {
    var db = await database;
    var result = db.insert(tableAlarm, alarmInfo.toMap());
    // ignore: avoid_print
    print('result : $result');
  }

  Future<List<DataAlarm>> getAlarms() async {
    List<DataAlarm> _alarms = [];

    var db = await database;
    var result = await db.query(tableAlarm);
    for (var element in result) {
      var alarmInfo = DataAlarm.fromMap(element);
      _alarms.add(alarmInfo);
    }

    return _alarms;
  }

  Future<int> delete(int id) async {
    var db = await database;
    return await db.delete(tableAlarm, where: '$columnId = ?', whereArgs: [id]);
  }
}

// Future selectNotification(String payload) async {
//   // ignore: unnecessary_null_comparison
//   if (payload != null) {
//     print('notification payload: $payload');
//   } else {
//     print("Notification Done");
//   }
// }


