import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:test_clima_flutter/screens/city_screen.dart';
import 'package:test_clima_flutter/utilities/constants.dart';
import 'package:test_clima_flutter/services/weather.dart';
import 'package:test_clima_flutter/services/networking.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen(this.data, {super.key});
  String data;

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  double temp = 0.0;
  String city = '', info = '', weathericon = '', weathermssg = '', mssg = '', tempString = '';
  int id = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    info = widget.data;
    updateUI();
  }

  void updateUI(){
    city = jsonDecode(info)['name'];
    temp = jsonDecode(info)['main']['temp'];
    id = jsonDecode(info)['weather'][0]['id'];

    WeatherModel weatherModel = new WeatherModel();
    weathericon = weatherModel.getWeatherIcon(id);
    weathermssg = weatherModel.getMessage(temp.toInt());

    tempString = temp.toStringAsFixed(0) + '°';
    mssg = '$weathermssg in $city';
  }

  void citySearch() async{
    String newcity;
    newcity = await Navigator.push(context, MaterialPageRoute(builder: (context){
      return CityScreen();
    }));

    if (newcity != null && newcity.isNotEmpty) {
      Networking networking = new Networking();
      String newInfo = await networking.searchCity(newcity);
      try{
        if (newInfo != null && jsonDecode(newInfo)['cod'] == 200) {
          setState(() {
            city = jsonDecode(newInfo)['name'];
            temp = jsonDecode(newInfo)['main']['temp'];
            id = jsonDecode(newInfo)['weather'][0]['id'];

            WeatherModel weatherModel = new WeatherModel();
            weathericon = weatherModel.getWeatherIcon(id);
            weathermssg = weatherModel.getMessage(temp.toInt());

            tempString = temp.toStringAsFixed(0) + '°';
            mssg = '$weathermssg in $city';
          });
        } else {
          setState(() {
            tempString = 'ERROR';
            weathericon = '';
            mssg = 'CITY NOT FOUND';
          });
        }
      }catch(e){
        print(e);
        setState(() {
          tempString = 'ERROR';
          weathericon = '';
          mssg = 'CITY NOT FOUND';
        });
      }
    }else{
      setState(() {
        tempString = 'ERROR';
        weathericon = '';
        mssg = 'NO CITY INPUTTED';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: const BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton(
                    onPressed: () {
                      setState(() {
                        updateUI();
                      });
                    },
                    child: const Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  TextButton(
                    onPressed: (){
                      citySearch();
                    },
                    child: const Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      tempString,
                      style: kTempTextStyle,
                    ),
                    Text(
                      '$weathericon',
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  mssg,
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

