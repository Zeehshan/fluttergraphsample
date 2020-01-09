

import 'package:flutter/cupertino.dart';

class SearCarBloc extends ChangeNotifier{
  SearCarBloc();
  String _searchingByCarName;
  String get searchingByCarName => _searchingByCarName;
  void carName(String name){
    _searchingByCarName = name;
    notifyListeners();
  }
}