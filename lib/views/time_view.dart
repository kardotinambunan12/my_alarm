import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sample_alarm/views/time.dart';

class TimeView extends StatefulWidget {
  const TimeView({Key? key}) : super(key: key);

  @override
  _TimeViewState createState() => _TimeViewState();
}

class _TimeViewState extends State<TimeView> {
  @override
  Widget build(BuildContext context) {
    var now = DateTime.now();
    var formattedTime = DateFormat('HH:mm').format(now);
    var formattedDate = DateFormat('EEEE, dd MMM').format(now);
    var timezoneString = now.timeZoneOffset.toString().split('.').first;
    // ignore: unused_local_variable
    var offsetSign = '';
    if (!timezoneString.startsWith('-')) offsetSign = '+';
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 94),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 12),
            child: Text(
              formattedTime,
              style: const TextStyle(
                  fontSize: 40,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Text(
            formattedDate,
            style: const TextStyle(
              fontSize: 20,
              color: Colors.white,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Center(
            child: Time(),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
