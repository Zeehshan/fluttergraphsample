import 'package:flutter/material.dart';
import 'package:flutter_app_graph/bloc/all_car_bloc.dart';
import 'package:flutter_app_graph/quries_data.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';

import 'bloc/search_car_bloc.dart';
import 'car_info.dart';
import 'search_bar_widget.dart';

void main() {
  runApp(
      MultiProvider(
          providers: [
            ChangeNotifierProvider<SearCarBloc>.value(value: SearCarBloc()),
            ChangeNotifierProvider<AllCarsBloc>.value(value: AllCarsBloc())
          ],
          child: MaterialApp(title: "GQL App", home: MyApp())));
}

class MyApp extends StatelessWidget {
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
    return GraphQLProvider(
      child: HomePage(),
      client: client,
    );
  }
}

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  TextEditingController _controller1;
  TextEditingController _controller2;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller1 = TextEditingController();
    _controller2 = TextEditingController();
  }


  Future _changeCarName(carname,id)async{
     showDialog(
         context: context,
       builder: (context){
           return AlertDialog(
             content: Container(
               width: MediaQuery.of(context).size.width*.8,
               height: MediaQuery.of(context).size.height*.3,
               child: Column(
                 mainAxisAlignment: MainAxisAlignment.center,
                 crossAxisAlignment: CrossAxisAlignment.center,
                 children: <Widget>[
                   Text("Change Car name from here"),
                   SizedBox(height: 40,),
                   Text(carname??""),
                   SizedBox(height: 10,),
                   SearchWidget(
                     controller: _controller2,
                   ),
                   SizedBox(height: 20,),
                   RaisedButton(
                     color: Colors.black,
                     onPressed: (){
                       Navigator.pop(context);
                     },
                     child: Text("Update",style: TextStyle(color: Colors.white),),
                   ),
                 ],
               ),
             ),
           );
       }
     );
   }

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<SearCarBloc>(context);
    final data2 = Provider.of<AllCarsBloc>(context);
     double h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text("GraphlQL Test"),
      ),
      body: Column(
        children: <Widget>[
          SizedBox(height: 10,),
          SearchWidget(
            controller: _controller1,
            onChanged: (v){
              print(v);
              data.carName(v);
            },
          ),
          SizedBox(height: 10,),
          Query(
            options:data.searchingByCarName==null?QueryOptions(
                document: UtilQuries.query
            ) : QueryOptions(
              document:UtilQuries.findCar,
              variables: {
                'carName': data.searchingByCarName,
              },
            ),
            builder: (QueryResult result, { VoidCallback refetch}) {
              if (result.loading) {
                return Center(child: CircularProgressIndicator());
              }
              if (result.data == null) {
                return Text("No Data Found !");
              }
              if(result.data[data.searchingByCarName == null?'allCars' : "carByName"] == null){
                return Center(child: Text("no data found"),);
              }
              print(data.searchingByCarName);
              print(result.data["allCars"]);
              data2.getCarData(context: context,data:result.data[data.searchingByCarName==null?"allCars":"carByName"]);
              print("okayokay");
              return Flexible(
                child: ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                    return Center(
                      child: Container(
                        margin: EdgeInsets.only(top: 10),
                        width: MediaQuery.of(context).size.width*.9,
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'Car name:    ' + data2.listCars[index].carname
                                      ),
                                    ),
                                    FlatButton(
                                      child: Text("Edit"),
                                      onPressed: (){
                                        _changeCarName(
                                            data2.listCars[index].carname,
                                            data2.listCars[index].carid
                                        );
                                      },
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                     'Company name:    ' + data2.listCars[index].compname
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: FlatButton(
                                    child: Text("See All Details"),
                                    onPressed: (){
                                      Navigator.push(context, MaterialPageRoute(
                                        builder: (context) => CarInfo(
                                          carName: data2.listCars[index].carname,
                                          carId: data2.listCars[index].carid,
                                          compId: data2.listCars[index].compid,
                                          compName: data2.listCars[index].compid,
                                        ),
                                      ));
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: data2.listCars.length,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}



