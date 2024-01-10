import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:test_clima_flutter/services/networking.dart';
import 'package:test_clima_flutter/screens/location_screen.dart';


class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getWeatherData();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: SpinKitDoubleBounce(
          size: 70,
          color: Colors.white,
        ),
      ),
    );
  }

  void getWeatherData() async{
    Networking networking = new Networking();
    String data = await networking.getData();
    // print(data);

    // The code below will push the window screen on the phone from loading_screen.dart to location_screen.dart
    // Simply put, when the app is launched or hot restarted it will show the loading screen first.
    // Then the code below will push another interface in front of the loading screen, which is the --
    // -- interface coded in location.screen.dart
    // import location_screen.dart to call public class 'LocationScreen'
    // parameter 'data' inside LocationScreen sends the outputted data from the code above

    Navigator.push(context, MaterialPageRoute(builder: (context){
     return LocationScreen(data);
    }));
  }
}
