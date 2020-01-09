


import 'package:flutter/cupertino.dart';
import 'package:flutter_app_graph/model_car/car_model.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';

import 'search_car_bloc.dart';

class AllCarsBloc extends ChangeNotifier{

  AllCarsBloc();
  List<CarModel> _listCarsl;
  List<CarModel> get listCars => _listCarsl;

   getCarData({BuildContext context,List<Object> data}){
    final data2 = Provider.of<SearCarBloc>(context);
    var _listCars = <CarModel>[];
    if(data != null)
    data.forEach((dta){
      _listCars.add(CarModel.fromJson(dta));
    });
    _listCarsl = _listCars;
    notifyListeners();
  }
}




