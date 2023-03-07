import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import '../services/location.dart';
import 'package:http/http.dart' as http;

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  // NOTE : No.2 - geo location 패키지를 사용해서 사용자 위치값을 가져오자.

  @override
  void initState() {
    // TODO: implement initState
    getData();
    getLocation();
    super.initState();
  }

  // NOTE : No.6 - 비동기 통신을 통한 위치값 가져오기
  void getLocation() async {
    Location location = Location();
    await location.getCurrentLocation();

    print(location.latitude);
    print(location.longitude);
  }

  // NOTE : No.8 - API를 통한 Web Data 가져오기
  void getData() async {
    String apiKey = "c03d";
    String strUri =
        "https://api.openweathermap.org/data/2.5/weather?lat=44.34&lon=10.99&appid=$apiKey";
    var url = Uri.parse(strUri);
    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      String data = response.body;
      print(data);
    } else {
      print(response.statusCode);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            getLocation();
          },
          child: Text('Get Location'),
        ),
      ),
    );
  }
}
