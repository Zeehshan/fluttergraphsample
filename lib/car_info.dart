import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class CarInfo extends StatelessWidget {
  final String carName;
  final String compName;
  final String carId;
  final String compId;

  const CarInfo({Key key, this.carName,this.carId,this.compId,this.compName}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final HttpLink httpLink = HttpLink(
        uri:
            "https://32hu5x5zy9.execute-api.us-east-1.amazonaws.com/dev/graphql");
    final ValueNotifier<GraphQLClient> client = ValueNotifier<GraphQLClient>(
      GraphQLClient(
        link: httpLink,
        cache: OptimisticCache(
          dataIdFromObject: typenameDataIdFromObject,
        ),
      ),
    );
    print("carname");
    print(carName);
    final String findCar = r""" 
  query searchCar($carName: String!){
  carByName(name : $carName ){
    name
    _id
    company{
      name
      _id
    }
  }
}
  """;
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Container(
          margin: EdgeInsets.only(top: 10),
          width: MediaQuery.of(context).size.width * .9,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Car name:    ' + carName),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Car id:    ' + carId),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Company name:    ' + compName),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Company id:    ' + carId),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
