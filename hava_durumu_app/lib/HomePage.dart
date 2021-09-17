import 'dart:convert';
//import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import 'package:hava_durumu_app/SearchPage.dart';
import 'package:hava_durumu_app/DailyWeather.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_spinkit/flutter_spinkit.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String sehir = 'Ankara';
  var locationData;
  var woeid;
  var jsonData;
  var wsname, temp;
  String wsabbr = "clouds2";
  var temps= List.filled(5,0,growable: false );
  List<String> abbrs=["0","1","2","3","4"];
  List<String> dates=["0","1","2","3","4"];


  /*void getDevicePosition() async{
    print("Konum alınıyor...");
    try{Position position =
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.lowest);}
    catch(e){
      print("Şu hata oluştu $e");
    }
    print("Konum alındı.");
  }*/




  final spinkit = SpinKitFadingCircle(
    itemBuilder: (BuildContext context, int index) {
      return DecoratedBox(
        decoration: BoxDecoration(
          color: index.isEven ? Colors.red : Colors.green,
        ),
      );
    },
  );

  Future<void> getLocation() async {
    locationData = await http.get(Uri.parse('https://www.metaweather.com/api/location/search/?query=$sehir'));
    var locationDataParsed = jsonDecode(utf8.decode(locationData.bodyBytes));
    woeid = locationDataParsed[0]["woeid"];
  }

  Future<void> getLatLong() async {
    locationData = await http.get(Uri.parse(
        'https://www.metaweather.com/api/location/search/?lattlong=36.96,-122.02'));
    var locationDataParsed = jsonDecode(locationData.body);
    woeid = locationDataParsed[0]["woeid"];
    sehir = locationDataParsed[0]["title"];
  }

  Future<void> getData() async {
    jsonData = await http
        .get(Uri.parse("https://www.metaweather.com/api/location/$woeid/"));
    var jsonDataParsed = jsonDecode(jsonData.body);
    wsname = jsonDataParsed["consolidated_weather"][0]["weather_state_name"];
    wsabbr = jsonDataParsed["consolidated_weather"][0]["weather_state_abbr"];

    setState(() {
      temp = jsonDataParsed["consolidated_weather"][0]["the_temp"].round();
      for(int i=0;i<temps.length;i++){
        temps[i]=jsonDataParsed["consolidated_weather"][i+1]["the_temp"].round();
        abbrs[i]=jsonDataParsed["consolidated_weather"][i+1]["weather_state_abbr"];
        dates[i]=jsonDataParsed["consolidated_weather"][i+1]["applicable_date"];
      }
    });

    print(
        "Hava Durumu : $wsname \nHava durumu kısaltması : $wsabbr \nSıcaklık : $temp");
  }

  Future<void> getAll() async {
    await getLatLong();
    getData();
  }

  Future<void> getAllbyCity() async {
    await getLocation();
    getData();
  }

  @override
  void initState() {
    getAll();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            fit: BoxFit.cover, image: AssetImage("assets/$wsabbr.jpg")),
      ),
      child: temp == null
          ? Center(child: spinkit)
          : Scaffold(
              backgroundColor: Colors.transparent,
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(height: 60,width: 60,child: Image.network("https://www.metaweather.com/static/img/weather/png/$wsabbr.png",),),
                    Text(
                      "$temp°C",
                      style: TextStyle(
                          fontSize: 70,
                          fontWeight: FontWeight.bold,
                          shadows: <Shadow>[
                            Shadow(
                              color: Colors.black54,
                              blurRadius: 5,
                              offset: Offset(-5, 5),
                            ),
                          ]),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          sehir,
                          style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,shadows: <Shadow>[
                            Shadow(
                              color: Colors.black54,
                              blurRadius: 5,
                              offset: Offset(-4, 4),
                            ),
                          ]),
                        ),
                        IconButton(
                          onPressed: () async {
                            sehir = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SearchPage()));
                            getAllbyCity();
                            setState(() {
                              sehir = sehir;
                            });
                          },

                          icon: Icon(Icons.search),
                        ),

                      ],
                    ),
                    SizedBox(height:120,),
                    Container(
                      height: 120,
                      width: MediaQuery.of(context).size.width*0.9,
                      child: ListView(
                        scrollDirection: Axis.horizontal ,
                        children: [
                          DailyWeather(image: abbrs[0], temp: temps[0], date: dates[0]),
                          DailyWeather(image: abbrs[1], temp: temps[1], date: dates[1]),
                          DailyWeather(image: abbrs[2], temp: temps[2], date: dates[2]),
                          DailyWeather(image: abbrs[3], temp: temps[3], date: dates[3]),
                          DailyWeather(image: abbrs[4], temp: temps[4], date: dates[4]),
                          ],

                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}


