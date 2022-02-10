
import 'package:flutter/cupertino.dart';
import 'package:sample_alarm/common/enums.dart';

class MenuInfo extends ChangeNotifier {
  MenuType bottomMenu;
  String? title;
  String? imageSource;

  MenuInfo(this.bottomMenu, {this.title, this.imageSource});

  updateMenu(MenuInfo menuInfo) {
    bottomMenu = menuInfo.bottomMenu;
    title = menuInfo.title;
    imageSource = menuInfo.imageSource;

    notifyListeners();
  }
}
