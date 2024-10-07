import 'dart:ui';

import 'package:flutter/material.dart';

class WeatherScreen extends StatelessWidget{

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
                            '300°K',
                            style: TextStyle(
                              fontSize: 30,
                            ),
                          ),
                           SizedBox(height: 10),
                          Icon(
                            Icons.cloud,
                            size: 48,
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
           Row(
             children: [
               Card(
                 
               ),
             ],
           ),
           const  Placeholder(
              fallbackHeight: 150,
            ),
            const SizedBox(height: 20,),
            const  Placeholder(
              fallbackHeight: 100,
            ),
            const SizedBox(height: 20,),
            const  Placeholder(
              fallbackHeight: 100,
            ),
          ],
        ),
      ),
    );
  }
}
