import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:weather_app/additional_info_item.dart';
import 'package:weather_app/api_key.dart';
import 'package:weather_app/hourly_fore_cast_card.dart';
import 'package:http/http.dart' as http;

class WeatherScreen extends StatefulWidget{
  const WeatherScreen({Key? key}) : super(key: key);

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  Future getCurrentWeather() async{
    String city = 'Madurai';
    final res = await http.get(
      Uri.parse('https://api.openweathermap.org/data/2.5/forecast?q=$city&APPID=$API_KEY'),
    );
    final data = json.decode(res.body);
    if(data['cod'] != '200'){
      print(data['message']);
      throw 'An unexpected error occurred';
      
    }
    return data;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App', style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
        ),
        centerTitle: true,
        actions:  [
          IconButton(
            onPressed: (){
              print('refresh');
            },
            icon: Icon(Icons.refresh),
          ),
        ],
      ),
      body: FutureBuilder(
        future: getCurrentWeather(),
        builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if(snapshot.hasError){
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }
          final data = snapshot.data!;
          final currentTemp = data['list'][0]['main']['temp'];
          final currentSky = data['list'][0]['weather'][0]['main'];
          final humidity = data['list'][0]['main']['humidity'];
          final windSpeed = data['list'][0]['wind']['speed'];
          final pressure = data['list'][0]['main']['pressure'];
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  //main card
                  child: SizedBox (
                    width: double.infinity,
                    child: Card(
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)
                      ),
                      child: ClipRRect( // for the elevation property
                        borderRadius: BorderRadius.circular(16),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(
                            sigmaX: 10,
                            sigmaY: 10,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                Text('Madurai', style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),),  
                                Text('$currentTemp K', style: 
                                  TextStyle(
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  
                                ),
                                const SizedBox(height: 16),
                                Icon(
                                  currentSky == 'Clouds' || currentSky == 'Rain' ? Icons.cloud : Icons.sunny, size: 65
                                ),
                                const SizedBox(height: 16),
                                Text(currentSky,style: TextStyle(
                                  fontSize: 20,
                                ),),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Text('Weather Forecast',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                ),
                SizedBox(height: 16,),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      for(int i = 1;i<=5;i++)
                        HourlyForeCastCard(
                          icon: data['list'][i]['weather'][0]['main'] == 'Clouds' || data['list'][i]['weather'][0]['main'] == 'Rain' ? Icons.cloud : Icons.sunny, 
                          time: data['list'][i]['dt_txt'].toString().substring(10),
                          temperature: data['list'][i]['main']['temp'].toString(),
                        ), 
                  ],
                  ),
                ),
                SizedBox(height: 16,),
                Text('Additional Information',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                ), 
                SizedBox(height: 16,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                  AdditionalInfoItem(
                    icon: Icons.water_drop_sharp,
                    label: 'Humidty',
                    value: humidity.toString()),
                  AdditionalInfoItem(
                    icon: Icons.air,
                    label: "Air Speed",
                    value: windSpeed.toString(),
                  ),
                  AdditionalInfoItem(
                    icon: Icons.umbrella_outlined,
                    label: 'Pressure',
                    value: pressure.toString(),
                  ),
                ],
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Text('Developed by: GM'),
                )
              ],
            ),
          );
        },
      ),
    );
  }

}
