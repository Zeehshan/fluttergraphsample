
class UtilQuries{


  static final String query = r"""
                    query{
                    allCars{
    name
    _id
    company{
      name
      _id
    }
  }
}
                  """;

  static final String findCar = r""" 
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

  static final String editCarName = r""" 
  mutation editCarName($name: String!,$_id: String!){
  updateCarName(newName: $name,_id: $_id){
    name
    company{
      name
    }
  }
}
  """;



}