import 'package:flutter/material.dart';

class DailyWeather extends StatelessWidget {
  final String image;
  final int temp;
  final String date;
  const DailyWeather({Key? key, this.image="c", this.temp=0,  this.date="Null"}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> weekdays=["Pazartesi","Salı","Çarşamba","Perşemve","Cuma","Cumartesi","Pazar"];
    String weekday=weekdays[DateTime.parse(date).weekday-1];
    return InkWell(
      onTap: (){print("Carda tıklandı");},
      onLongPress: (){print("Carda uzun tıklandı");},
      
      child: Card(elevation: 2,
        color: Colors.transparent,
        child: Container(
          width: 120,
          height: 120,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network("https://www.metaweather.com/static/img/weather/png/$image.png",width: 40,height: 40,),
              SizedBox(height: 8,),
              Text("$temp°C",style: TextStyle(fontSize: 25),),
              SizedBox(height: 6,),
              Text(weekday,style: TextStyle(fontSize: 16,),),
            ],
          ),
        ),
      ),
    );
  }
}