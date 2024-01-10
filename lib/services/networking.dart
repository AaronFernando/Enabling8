import 'package:http/http.dart';
import 'package:test_clima_flutter/services/location.dart';

class Networking{
  String apiKEY = 'ac8cb210e1350fe7851b569c27fcbfe5';
  double temp = 0;
  String data = '', city = '';
  int id = 0;

  Future<String> getData() async{

    Location location = new Location();
    await location.getLocation();
    double lat = location.lat;
    double lon = location.lon;

    Uri url = Uri.parse('https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$apiKEY&units=metric');
    Response response = await get(url);
    data = response.body;
    if (response.statusCode == 200){
      return data;
    }else{
      return 'Error';
    }
  }
}