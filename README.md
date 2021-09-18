# HavaDurumuApp
This app made for learning Flutter.

## You need to know before you start

The first time you run the application, the same city is always displayed because I used a city as static.<br>
You can also search based on your location. I designed the application in such a way that it can receive<br> location information and bring weather data.
But I had to comment line this feature out because I only<br> tried it on the emulator.<br><br>
`/*void getDevicePosition() async{
    print("Konum alınıyor...");
    try{Position position =
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.lowest);}
    catch(e){
      print("Şu hata oluştu $e");
    }
    print("Konum alındı.");
  }*/`<br><br>
If you want the application to search by location information when first opened, simply remove this<br> feature from the comment line and add it to the necessary places.

## Working Principle
The working principle of the application is quite easy. The first time the application runs, it uses the<br>
default value to show you the most up-to-date weather information and 5-day temperature values.<br>
If you want to enter a city yourself instead of the default value, simply press the search button next to the city name.<br>

The application consists of two pages, I am sure you will understand easily.<br><br>

![This is an image](https://myoctocat.com/assets/images/base-octocat.svg)

I don't think I need to explain the rest.
<br> Good working to you guys.
