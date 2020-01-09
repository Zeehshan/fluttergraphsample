

class CarModel{
  final String carname;
  final String compname;
  final String carid;
  final String compid;

  CarModel({this.carname, this.compname, this.carid, this.compid});

  factory CarModel.fromJson(Map json, {String key}){

    return CarModel(
      carname: json["name"],
      compname: json["company"]["name"],
      carid: json["_id"],
      compid: json["company"]["_id"]
    );

  }
}