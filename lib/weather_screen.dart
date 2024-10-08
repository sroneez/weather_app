import 'dart:ui';

import 'package:flutter/material.dart';

class WeatherScreen extends StatelessWidget{
  const WeatherScreen({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(onPressed: (){},
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
              child: Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(
                      sigmaX:10,
                      sigmaY : 10,
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Text(
                            '300K',
                            style: TextStyle(
                              fontSize: 30,
                            ),
                          ),
                           SizedBox(height: 10),
                          Icon(
                            Icons.cloud,
                            size: 60,
                          ),
                           SizedBox(height: 10),
                  
                          Text(
                              'Rain',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
           const SizedBox(height: 20,),
           const Text(
             'Weather Forecast',
             style: TextStyle(
               fontSize: 21,
               fontWeight: FontWeight.bold,
             ),
           ),
           const SizedBox(height:10),
           const SingleChildScrollView(
             scrollDirection: Axis.horizontal,
             child: Row(
               children: [
                  HourlyForecastItem(),
                 HourlyForecastItem(),
                 HourlyForecastItem(),
                 HourlyForecastItem(),
                 HourlyForecastItem(),

               ],
             ),
           ),
            const SizedBox(height: 20,),
            const Text(
              'Additional Information',
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
           const SizedBox(
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Icon(Icons.water_drop,
                        size: 32,
                      ),
                       SizedBox(height: 8),
                      Text(
                        'Humidity',
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                       SizedBox(height: 6),
                      Text(
                        '94',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Icon(Icons.air,
                        size: 32,
                      ),
                       SizedBox(height: 8),
                      Text(
                        'Wind Speed',
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                       SizedBox(height: 6),
                      Text(
                        '7.67',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Icon(Icons.compress,
                        size: 32,
                      ),
                       SizedBox(height: 8),
                      Text(
                        'Pressure',
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                       SizedBox(height: 6),
                      Text(
                        '1006',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class HourlyForecastItem extends StatelessWidget{
  const HourlyForecastItem({super.key});

  @override
  Widget build(BuildContext context){
    return Card(
      elevation: 6,
      child: Container(
        width: 100,
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Column(
            children:[ Text(
              '03:00',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
              SizedBox(height: 8,),
              Icon(Icons.cloud,
                size: 32,
              ),
              SizedBox(height: 8,),
              Text(
                '300.12',
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
            ]
        ),
      ),
    );
  }
}
