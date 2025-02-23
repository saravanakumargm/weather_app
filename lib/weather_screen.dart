import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:weather_app/additional_info_item.dart';
import 'package:weather_app/hourly_fore_cast_card.dart';

class WeatherScreen extends StatelessWidget{
  const WeatherScreen({Key? key}) : super(key: key);
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
      body: Padding(
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
                            Text('30° C', style: 
                              TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                              ),
                              
                            ),
                            const SizedBox(height: 16),
                            Icon(Icons.cloud, size: 65),
                            const SizedBox(height: 16),
                            Text('Rain',style: TextStyle(
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
                HourlyForeCastCard(
                  icon: Icons.cloud,
                  time: '12:00',
                  temperature: '300° F',
                ),
                HourlyForeCastCard(icon: Icons.cloud,
                  time: '13:00',
                  temperature: '300.4° F',),
                HourlyForeCastCard(
                  icon: Icons.cloud,
                  time: '14:00',
                  temperature: '300.3° F',
                ),
                HourlyForeCastCard(
                  icon: Icons.cloud,
                  time: '12:00',
                  temperature: '300° F',
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
                value: '90'),
              AdditionalInfoItem(
                icon: Icons.air,
                label: "Air Speed",
                value: '5.6',
              ),
              AdditionalInfoItem(
                icon: Icons.umbrella_outlined,
                label: 'Pressure',
                value: '1006',
              ),
            ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Text('Developed by: GM'),
            )
          ],
        ),
      ),
    );
  }
}
