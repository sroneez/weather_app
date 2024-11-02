import 'dart:ui';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:weather_app/additionla_info.dart';
import 'hourly_forecast_item.dart';
import 'secrets.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  late Future<Map<String,dynamic>> weather;
  Future<Map<String, dynamic>> getCurrentWeather() async {
    try {
      String cityName = 'Dhaka';
      final res = await http.get(
        Uri.parse(
            'https://api.openweathermap.org/data/2.5/forecast?q=$cityName&APPID=$openWeatherAPIKey'),
      );
      final data = jsonDecode(res.body);

      if (data['cod'] != "200") {
        throw 'An unexpected error occurred';
      }
      // temp = data['main'][0]['temp'];
      return data;
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  void initState(){
    super.initState();
    weather = getCurrentWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Weather App',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                weather = getCurrentWeather();
              });
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: ListView(
        children: [
          FutureBuilder(
            future: weather,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    snapshot.error.toString(),
                  ),
                );
              }
              final data = snapshot.data!;

              final currentWeatherData = data['list'][0];
              final currentTemp = currentWeatherData['main']['temp'];
              final currentSky = currentWeatherData['weather'][0]['main'];
              final currentIcon = currentWeatherData['weather'][0]['icon'];
              final iconUrl =
                  'https://openweathermap.org/img/wn/$currentIcon@2x.png';
              final currentHumidity = currentWeatherData['main']['humidity'];
              final currentAirSpeed = currentWeatherData['wind']['speed'];
              final currentPressure = currentWeatherData['main']['pressure'];

              return Padding(
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
                              sigmaX: 10,
                              sigmaY: 10,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                children: [
                                  Text(
                                    '${(currentTemp - 273.15).toStringAsFixed(
                                        1)}°C',
                                    style: const TextStyle(
                                      fontSize: 30,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Image.network(
                                    // Display the weather icon
                                    iconUrl,
                                    width: double.infinity,
                                    height: 60,
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    '$currentSky',
                                    style: const TextStyle(
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
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Hourly Forecast',
                      style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 120,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                          itemCount: 5,
                          itemBuilder: (context, index) {
                        final hourlyForecast = data['list'][index + 1];
                        final hourlySky =
                        data['list'][index + 1]['weather'][0]['main'];
                        final hourlyTemp = hourlyForecast['main']['temp'];
                        final time =DateTime.parse(hourlyForecast['dt_txt']);
                        return HourlyForecastItem(
                          time: DateFormat.j().format(time),
                          temperature: (hourlyTemp - 273.15).toStringAsFixed(1) +'°C',
                          icon: hourlySky == 'Clouds' || hourlySky == 'Rain' ? Icons
                              .cloud : Icons.sunny,
                        );
                      }),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Additional Information',
                      style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          AdditionalInfo(
                              icon: Icons.water_drop,
                              label: 'Humidity',
                              value: currentHumidity.toString()),
                          AdditionalInfo(
                            icon: Icons.air,
                            label: 'Air Speed',
                            value: currentAirSpeed.toString(),
                          ),
                          AdditionalInfo(
                            icon: Icons.beach_access_rounded,
                            label: 'Pressure',
                            value: currentPressure.toString(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
