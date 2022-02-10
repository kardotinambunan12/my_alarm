import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_alarm/constans/info.dart';
import 'package:sample_alarm/views/alarm_page.dart';
import 'package:sample_alarm/views/time_view.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor:const Color(0xFF2D2F41),
        body:const TabBarView(
          children: [
            TimeView(),
            Alarm(),
          ],
        ),
        bottomNavigationBar: Container(
          color:const Color(0xFF19191C),
          child: const TabBar(
            labelColor: Colors.white,
            unselectedLabelColor: Colors.grey,
            indicatorColor: Colors.grey,
            tabs: [
              Tab(
                icon: Icon(Icons.access_time_filled),
                child: Text(
                  "Jam",
                  style: TextStyle(fontSize: 12.0),
                ),
              ),
              Tab(
                icon: Icon(Icons.alarm),
                child: Text(
                  "Alarm",
                  style: TextStyle(fontSize: 12.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildMenuMethod(MenuInfo menuInfo) {
    return Consumer<MenuInfo>(
      builder: (BuildContext? context, MenuInfo? value, Widget? child) {
        return FlatButton(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(topRight: Radius.circular(32)),
            ),
            padding:const EdgeInsets.symmetric(vertical: 16, horizontal: 0),
            color: menuInfo.bottomMenu == value!.bottomMenu
                ? Colors.grey
                : Colors.transparent,
            onPressed: () {
              var menuInfo = Provider.of<MenuInfo>(context!, listen: false);
              menuInfo.updateMenu(menuInfo);
            },
            child: Column(
              children: [
                Image.asset(
                  menuInfo.imageSource ?? '',
                  scale: 1.5,
                ),
                Text(
                  menuInfo.title ?? '',
                  style:const TextStyle(color: Colors.white, fontSize: 12),
                )
              ],
            ));
      },
    );
  }
}
