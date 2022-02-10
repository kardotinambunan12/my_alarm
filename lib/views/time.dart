import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class Time extends StatefulWidget {
  // ignore: avoid_types_as_parameter_names
  const Time({Key? key}) : super(key: key);

  @override
  _TimeState createState() => _TimeState();
}

class _TimeState extends State<Time> {
  double minute = 0;
  double secon = 0;
  double hours = 0;
  late Timer timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      final now = DateTime.now();
      if (!mounted) {
        return;
      }
      setState(() {
        secon = (pi / 30) * now.second;
        minute = pi / 30 * now.minute;
        hours = (pi / 6 * now.hour) + (pi / 45 * minute);
      });
    });
    // dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        child: Stack(
          children: [
            Image.asset("assets/images/clock_images.png"),
            //second
            Transform.rotate(
              child: Container(
                child: Container(
                  height: 100,
                  width: 4,
                  decoration: BoxDecoration(
                    color: Colors.pinkAccent,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                alignment: const Alignment(0, -0.35),
              ),
              angle: secon,
            ),
            //minute
            Transform.rotate(
              child: Container(
                child: Container(
                  height: 75,
                  width: 6,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                alignment: const Alignment(0, -0.35),
              ),
              angle: minute,
            ),
            //hours
            Transform.rotate(
              child: Container(
                child: Container(
                  height: 60,
                  width: 8,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                alignment: const Alignment(0, -0.2),
              ),
              angle: hours,
            ),
            //Dot
            Container(
              child: Container(
                height: 16,
                width: 16,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(60),
                ),
              ),
              alignment: const Alignment(0, 0),
            ),
          ],
        ),
        width: 300,
        height: 300,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black26, width: 8),
          borderRadius: BorderRadius.circular(350),
        ),
      ),
      color: const Color.fromARGB(8, 25, 35, 1),
      alignment: const Alignment(0, 0),
    );
  }
}
