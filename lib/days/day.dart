
import 'package:flutter/material.dart';
import 'package:weather_app_flutter_main/widgets/daily_summary.dart';
import 'package:weather_app_flutter_main/widgets/frosted_glass.dart';
import 'package:weather_app_flutter_main/widgets/other_temps.dart';
import 'package:weather_app_flutter_main/widgets/rise_set_timings.dart';
import 'package:weather_app_flutter_main/widgets/weather_details.dart';



class Day extends StatelessWidget {

  final String windSpeed;
  final String windDegree;
  final String pressure;
  final String uvi;
  final String humidity;
  final String tempMin;
  final String tempMax;
  final String icon;
  final String description;
  final String summary;
  final String clouds;
  final String dewPoint;
  final String windGust;

  final String morningTemp;
  final String dayTemp;
  final String eveningTemp;
  final String nightTemp;

  final String sunrise;
  final String sunset;
  final String moonrise;
  final String moonset;
  final String moonPhase;

  const Day ({
    super.key,

    required this.windSpeed,
    required this.windDegree,
    required this.pressure,
    required this.uvi,
    required this.humidity,
    required this.tempMin,
    required this.tempMax,
    required this.icon,
    required this.description,
    required this.summary,
    required this.clouds,
    required this.dewPoint,
    required this.windGust,

    required this.morningTemp,
    required this.dayTemp,
    required this.eveningTemp,
    required this.nightTemp,

    required this.sunrise,
    required this.sunset,
    required this.moonrise,
    required this.moonset,
    required this.moonPhase,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            FrostedGlass(
              tempMin: tempMin,
              tempMax: tempMax,
              icon: icon,
              description: description,
            ),
            DailySummary(
              summary: summary,
            ),
            OtherTemps(
              morningTemp: morningTemp,
              dayTemp: dayTemp,
              eveningTemp: eveningTemp,
              nightTemp: nightTemp,
            ),
            WeatherDetails(
              windSpeed: windSpeed,
              windDegree: windDegree,
              pressure: pressure,
              uvi: uvi,
              humidity: humidity,
              clouds: clouds,
              dewPoint: dewPoint,
              windGust: windGust,
            ),
            RiseSetTimings(
              sunrise: sunrise,
              sunset: sunset,
              moonrise: moonrise,
              moonset: moonset,
              moonPhase: moonPhase,
            ),
          ],
        ),
      ),
    );
  }
}
