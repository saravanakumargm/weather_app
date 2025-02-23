import 'dart:ui';
import 'package:flutter/material.dart';

class HourlyForeCastCard extends StatelessWidget{
  final IconData icon;
  final String time;
  final String temperature;
  const HourlyForeCastCard ({
    required this.icon,
    required this.time,
    required this.temperature,
    super.key
  }
  );
  @override
  Widget build(BuildContext context){
    return    
      SizedBox(
        width: 120,
        child: Card(
          elevation: 6,
            child: Container(
              padding: const EdgeInsets.all(14.0),
              decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              ),
              child: Column(
              children: [
                Text(time, style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),),
                SizedBox(height: 12,),
                Icon(icon, size: 32,),
                SizedBox(height: 14,),
                Text(temperature),
              ],
              ),
            ),
        ),
      );
  }
}