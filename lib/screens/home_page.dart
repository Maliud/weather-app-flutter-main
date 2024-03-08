
import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:weather_app_flutter_main/api/openweather_api.dart';
import 'package:weather_app_flutter_main/days/day.dart';
import 'package:weather_app_flutter_main/days/day_today.dart';
import 'package:weather_app_flutter_main/models/weather_data.dart';
import 'package:weather_app_flutter_main/tabs/tabs.dart';
import 'package:weather_app_flutter_main/widgets/loader.dart';



class HomePage extends StatefulWidget {

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  String location = "Your Location";
  String? error;

  double lat = 0.0;
  double lon = 0.0;

  List dates = [];
  List days = [];

  List<String> hourlyTime = [];
  List<String> hourlyTemp = [];
  List<String> hourlyIcon = [];

  bool isLoading = true;
  bool isError = false;

  WeatherData? weatherData;

  @override
  void initState() {
    super.initState();

    getCurrentLocation();
  }

  getCurrentLocation() async {

    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() {
        isError = true;
        error = "Location services are disabled & then restart the application!";
      });
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((value){

          lat = value.latitude;
          lon = value.longitude;
          print(lat);
          print(lon);
          getCityName();
          getWeatherData();

          return value;
        });
  }

  getCityName() async {
    List<Placemark> placemarks = await placemarkFromCoordinates(lat, lon);

    Placemark place = placemarks[0];

    setState(() {
      location = "${place.subLocality}";
    });
  }

  getWeatherData() async {

    try {
      final response = await http.get(Uri.parse(OpenWeatherAPI().apiUrl(lat, lon)));

      if(response.statusCode == 200) {

        var jsonString = jsonDecode(response.body);
        weatherData = WeatherData(WeatherDataCurrent.fromJson(jsonString), WeatherDataHourly.fromJson(jsonString), WeatherDataDaily.fromJson(jsonString));
        print(jsonString);
        getDaysAndDates();
        getHourlyTime();
        getHourlyData();

        setState(() {
          isLoading = false;
        });

        return weatherData;
      } else {
        return "Error";
      }
    } catch (e) {
      return e.toString();
    }
  }

  getDaysAndDates() {
    for(int i = 0; i < weatherData!.getDailyWeather().daily.length; i++) {
      getDay(weatherData?.getDailyWeather().daily[i].dt);
      getDate(weatherData?.getDailyWeather().daily[i].dt);
    }
  }

  getHourlyTime() {
    for(int i = 0; i < weatherData!.getHourlyWeather().hourly.length; i++) {
      getHours(weatherData?.getHourlyWeather().hourly[i].dt);
    }
  }

  String getDay(final day){
    DateTime time = DateTime.fromMillisecondsSinceEpoch(day * 1000);
    final dayName = DateFormat('EEEE').format(time);
    days.add(dayName);
    return dayName;
  }

  String getDate(final day){
    DateTime time = DateTime.fromMillisecondsSinceEpoch(day * 1000);
    final date = DateFormat('dd/MM').format(time);
    dates.add(date);
    return date;
  }

  getTime(final day) {
    DateTime time = DateTime.fromMillisecondsSinceEpoch(day * 1000);
    final hourTime = DateFormat('jm').format(time);
    return hourTime;
  }

  getHours(final day) {
    hourlyTime.add(getTime(day));
  }

  getHourlyData() {
    for(int i = 0; i < weatherData!.getHourlyWeather().hourly.length; i++) {
      hourlyTemp.add(weatherData!.getHourlyWeather().hourly[i].temp!.round().toString());
      hourlyIcon.add(weatherData!.getHourlyWeather().hourly[i].weather![0].icon.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading ? Loader(error: error, isError: isError) : DefaultTabController(
      length: 8,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            location,
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          centerTitle: true,
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
          actions: [
            IconButton(
              onPressed: () {
                _bottomSheet();
              },
              icon: Icon(
                Icons.map_rounded,
                color: Theme.of(context).iconTheme.color,
              ),
            ),
          ],
          bottom: TabBar(
            isScrollable: true,
            automaticIndicatorColorAdjustment: true,
            indicator: Theme.of(context).tabBarTheme.indicator,
            tabs: [
              Tabs(
                day: "Today",
                date: dates[0],
              ),
              Tabs(
                day: "Tomorrow",
                date: dates[1],
              ),
              Tabs(
                day: days[2],
                date: dates[2],
              ),
              Tabs(
                day: days[3],
                date: dates[3],
              ),
              Tabs(
                day: days[4],
                date: dates[4],
              ),
              Tabs(
                day: days[5],
                date: dates[5],
              ),
              Tabs(
                day: days[6],
                date: dates[6],
              ),
              Tabs(
                day: days[7],
                date: dates[7],
              ),
            ],
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: TabBarView(
                children: [
                  DayToday(
                    windSpeed: "${weatherData?.getCurrentWeather().current.windSpeed.toString() ?? ''} m/s",
                    visibility: '${(weatherData!.getCurrentWeather().current.visibility! / 1000).round().toString()} KM',
                    pressure: '${weatherData?.getCurrentWeather().current.pressure.toString()} hPa',
                    windDegree: '${weatherData?.getCurrentWeather().current.windDeg.toString()}°',
                    uvi: weatherData?.getCurrentWeather().current.uvi.toString() ?? '',
                    humidity: '${weatherData?.getCurrentWeather().current.humidity.toString()}%',
                    temp: weatherData?.getCurrentWeather().current.temp!.round().toString() ?? '',
                    tempMin: "${weatherData?.getDailyWeather().daily[0].temp?.min!.round().toString()}",
                    tempMax: "${weatherData?.getDailyWeather().daily[0].temp?.max!.round().toString()}",
                    icon: weatherData?.getCurrentWeather().current.weather![0].icon.toString() ?? '',
                    description: weatherData?.getCurrentWeather().current.weather![0].main.toString() ?? '',
                    summary: "${weatherData?.getDailyWeather().daily[0].summary}",
                    clouds: "${weatherData?.getCurrentWeather().current.clouds.toString()}%",
                    dewPoint: "${weatherData?.getCurrentWeather().current.dewPoint.toString()}°",
                    windGust: "${weatherData?.getDailyWeather().daily[0].windGust?.round().toString()} m/s",

                    morningTemp: "${weatherData?.getDailyWeather().daily[0].temp?.morn!.round().toString()}",
                    dayTemp: "${weatherData?.getDailyWeather().daily[0].temp?.day!.round().toString()}",
                    eveningTemp: "${weatherData?.getDailyWeather().daily[0].temp?.eve!.round().toString()}",
                    nightTemp: "${weatherData?.getDailyWeather().daily[0].temp?.night!.round().toString()}",

                    length: weatherData?.getHourlyWeather().hourly.length ?? 0,
                    hourlyList: hourlyTime,
                    hourlyIconList: hourlyIcon,
                    hourlyTempList: hourlyTemp,

                    sunrise: getTime(weatherData?.getDailyWeather().daily[0].sunrise),
                    sunset: getTime(weatherData?.getDailyWeather().daily[0].sunset),
                    moonrise: getTime(weatherData?.getDailyWeather().daily[0].moonrise),
                    moonset: getTime(weatherData?.getDailyWeather().daily[0].moonset),
                    moonPhase: weatherData?.getDailyWeather().daily[0].moonPhase.toString() ?? '',
                  ),
                  Day(
                    windSpeed: "${weatherData?.getDailyWeather().daily[1].temp?.max?.round().toString()} m/s",
                    pressure: '${weatherData?.getDailyWeather().daily[1].pressure.toString()} hPa',
                    windDegree: '${weatherData?.getDailyWeather().daily[1].windDeg.toString()}°',
                    uvi: weatherData?.getDailyWeather().daily[1].uvi.toString() ?? '',
                    humidity: '${weatherData?.getDailyWeather().daily[1].humidity.toString()}%',
                    tempMin: "${weatherData?.getDailyWeather().daily[1].temp?.min!.round().toString()}",
                    tempMax: "${weatherData?.getDailyWeather().daily[1].temp?.max!.round().toString()}",
                    icon: weatherData?.getDailyWeather().daily[1].weather![0].icon.toString() ?? '',
                    description: weatherData?.getDailyWeather().daily[1].weather![0].main.toString() ?? '',
                    summary: "${weatherData?.getDailyWeather().daily[1].summary}",
                    clouds: "${weatherData?.getDailyWeather().daily[1].clouds.toString()}%",
                    dewPoint: "${weatherData?.getDailyWeather().daily[1].dewPoint.toString()}°",
                    windGust: "${weatherData?.getDailyWeather().daily[1].windGust?.round().toString()} m/s",

                    morningTemp: "${weatherData?.getDailyWeather().daily[1].temp?.morn!.round().toString()}",
                    dayTemp: "${weatherData?.getDailyWeather().daily[1].temp?.day!.round().toString()}",
                    eveningTemp: "${weatherData?.getDailyWeather().daily[1].temp?.eve!.round().toString()}",
                    nightTemp: "${weatherData?.getDailyWeather().daily[1].temp?.night!.round().toString()}",

                    sunrise: getTime(weatherData?.getDailyWeather().daily[1].sunrise),
                    sunset: getTime(weatherData?.getDailyWeather().daily[1].sunset),
                    moonrise: getTime(weatherData?.getDailyWeather().daily[1].moonrise),
                    moonset: getTime(weatherData?.getDailyWeather().daily[1].moonset),
                    moonPhase: weatherData?.getDailyWeather().daily[1].moonPhase.toString() ?? '',
                  ),
                  Day(
                    windSpeed: "${weatherData?.getDailyWeather().daily[2].temp?.max?.round().toString()} m/s",
                    pressure: '${weatherData?.getDailyWeather().daily[2].pressure.toString()} hPa',
                    windDegree: '${weatherData?.getDailyWeather().daily[2].windDeg.toString()}°',
                    uvi: weatherData?.getDailyWeather().daily[2].uvi.toString() ?? '',
                    humidity: '${weatherData?.getDailyWeather().daily[2].humidity.toString()}%',
                    tempMin: "${weatherData?.getDailyWeather().daily[2].temp?.min!.round().toString()}",
                    tempMax: "${weatherData?.getDailyWeather().daily[2].temp?.max!.round().toString()}",
                    icon: weatherData?.getDailyWeather().daily[2].weather![0].icon.toString() ?? '',
                    description: weatherData?.getDailyWeather().daily[2].weather![0].main.toString() ?? '',
                    summary: "${weatherData?.getDailyWeather().daily[2].summary}",
                    clouds: "${weatherData?.getDailyWeather().daily[2].clouds.toString()}%",
                    dewPoint: "${weatherData?.getDailyWeather().daily[2].dewPoint.toString()}°",
                    windGust: "${weatherData?.getDailyWeather().daily[2].windGust?.round().toString()} m/s",

                    morningTemp: "${weatherData?.getDailyWeather().daily[2].temp?.morn!.round().toString()}",
                    dayTemp: "${weatherData?.getDailyWeather().daily[2].temp?.day!.round().toString()}",
                    eveningTemp: "${weatherData?.getDailyWeather().daily[2].temp?.eve!.round().toString()}",
                    nightTemp: "${weatherData?.getDailyWeather().daily[2].temp?.night!.round().toString()}",

                    sunrise: getTime(weatherData?.getDailyWeather().daily[2].sunrise),
                    sunset: getTime(weatherData?.getDailyWeather().daily[2].sunset),
                    moonrise: getTime(weatherData?.getDailyWeather().daily[2].moonrise),
                    moonset: getTime(weatherData?.getDailyWeather().daily[2].moonset),
                    moonPhase: weatherData?.getDailyWeather().daily[2].moonPhase.toString() ?? '',
                  ),
                  Day(
                    windSpeed: "${weatherData?.getDailyWeather().daily[3].temp?.max?.round().toString()} m/s",
                    pressure: '${weatherData?.getDailyWeather().daily[3].pressure.toString()} hPa',
                    windDegree: '${weatherData?.getDailyWeather().daily[3].windDeg.toString()}°',
                    uvi: weatherData?.getDailyWeather().daily[3].uvi.toString() ?? '',
                    humidity: '${weatherData?.getDailyWeather().daily[3].humidity.toString()}%',
                    tempMin: "${weatherData?.getDailyWeather().daily[3].temp?.min!.round().toString()}",
                    tempMax: "${weatherData?.getDailyWeather().daily[3].temp?.max!.round().toString()}",
                    icon: weatherData?.getDailyWeather().daily[3].weather![0].icon.toString() ?? '',
                    description: weatherData?.getDailyWeather().daily[3].weather![0].main.toString() ?? '',
                    summary: "${weatherData?.getDailyWeather().daily[3].summary}",
                    clouds: "${weatherData?.getDailyWeather().daily[3].clouds.toString()}%",
                    dewPoint: "${weatherData?.getDailyWeather().daily[3].dewPoint.toString()}°",
                    windGust: "${weatherData?.getDailyWeather().daily[3].windGust?.round().toString()} m/s",

                    morningTemp: "${weatherData?.getDailyWeather().daily[3].temp?.morn!.round().toString()}",
                    dayTemp: "${weatherData?.getDailyWeather().daily[3].temp?.day!.round().toString()}",
                    eveningTemp: "${weatherData?.getDailyWeather().daily[3].temp?.eve!.round().toString()}",
                    nightTemp: "${weatherData?.getDailyWeather().daily[3].temp?.night!.round().toString()}",

                    sunrise: getTime(weatherData?.getDailyWeather().daily[3].sunrise),
                    sunset: getTime(weatherData?.getDailyWeather().daily[3].sunset),
                    moonrise: getTime(weatherData?.getDailyWeather().daily[3].moonrise),
                    moonset: getTime(weatherData?.getDailyWeather().daily[3].moonset),
                    moonPhase: weatherData?.getDailyWeather().daily[3].moonPhase.toString() ?? '',
                  ),
                  Day(
                    windSpeed: "${weatherData?.getDailyWeather().daily[4].temp?.max?.round().toString()} m/s",
                    pressure: '${weatherData?.getDailyWeather().daily[4].pressure.toString()} hPa',
                    windDegree: '${weatherData?.getDailyWeather().daily[4].windDeg.toString()}°',
                    uvi: weatherData?.getDailyWeather().daily[4].uvi.toString() ?? '',
                    humidity: '${weatherData?.getDailyWeather().daily[4].humidity.toString()}%',
                    tempMin: "${weatherData?.getDailyWeather().daily[4].temp?.min!.round().toString()}",
                    tempMax: "${weatherData?.getDailyWeather().daily[4].temp?.max!.round().toString()}",
                    icon: weatherData?.getDailyWeather().daily[4].weather![0].icon.toString() ?? '',
                    description: weatherData?.getDailyWeather().daily[4].weather![0].main.toString() ?? '',
                    summary: "${weatherData?.getDailyWeather().daily[4].summary}",
                    clouds: "${weatherData?.getDailyWeather().daily[4].clouds.toString()}%",
                    dewPoint: "${weatherData?.getDailyWeather().daily[4].dewPoint.toString()}°",
                    windGust: "${weatherData?.getDailyWeather().daily[4].windGust?.round().toString()} m/s",

                    morningTemp: "${weatherData?.getDailyWeather().daily[4].temp?.morn!.round().toString()}",
                    dayTemp: "${weatherData?.getDailyWeather().daily[4].temp?.day!.round().toString()}",
                    eveningTemp: "${weatherData?.getDailyWeather().daily[4].temp?.eve!.round().toString()}",
                    nightTemp: "${weatherData?.getDailyWeather().daily[4].temp?.night!.round().toString()}",

                    sunrise: getTime(weatherData?.getDailyWeather().daily[4].sunrise),
                    sunset: getTime(weatherData?.getDailyWeather().daily[4].sunset),
                    moonrise: getTime(weatherData?.getDailyWeather().daily[4].moonrise),
                    moonset: getTime(weatherData?.getDailyWeather().daily[4].moonset),
                    moonPhase: weatherData?.getDailyWeather().daily[4].moonPhase.toString() ?? '',
                  ),
                  Day(
                    windSpeed: "${weatherData?.getDailyWeather().daily[5].temp?.max?.round().toString()} m/s",
                    pressure: '${weatherData?.getDailyWeather().daily[5].pressure.toString()} hPa',
                    windDegree: '${weatherData?.getDailyWeather().daily[5].windDeg.toString()}°',
                    uvi: weatherData?.getDailyWeather().daily[5].uvi.toString() ?? '',
                    humidity: '${weatherData?.getDailyWeather().daily[5].humidity.toString()}%',
                    tempMin: "${weatherData?.getDailyWeather().daily[5].temp?.min!.round().toString()}",
                    tempMax: "${weatherData?.getDailyWeather().daily[5].temp?.max!.round().toString()}",
                    icon: weatherData?.getDailyWeather().daily[5].weather![0].icon.toString() ?? '',
                    description: weatherData?.getDailyWeather().daily[5].weather![0].main.toString() ?? '',
                    summary: "${weatherData?.getDailyWeather().daily[5].summary}",
                    clouds: "${weatherData?.getDailyWeather().daily[5].clouds.toString()}%",
                    dewPoint: "${weatherData?.getDailyWeather().daily[5].dewPoint.toString()}°",
                    windGust: "${weatherData?.getDailyWeather().daily[5].windGust?.round().toString()} m/s",

                    morningTemp: "${weatherData?.getDailyWeather().daily[5].temp?.morn!.round().toString()}",
                    dayTemp: "${weatherData?.getDailyWeather().daily[5].temp?.day!.round().toString()}",
                    eveningTemp: "${weatherData?.getDailyWeather().daily[5].temp?.eve!.round().toString()}",
                    nightTemp: "${weatherData?.getDailyWeather().daily[5].temp?.night!.round().toString()}",

                    sunrise: getTime(weatherData?.getDailyWeather().daily[5].sunrise),
                    sunset: getTime(weatherData?.getDailyWeather().daily[5].sunset),
                    moonrise: getTime(weatherData?.getDailyWeather().daily[5].moonrise),
                    moonset: getTime(weatherData?.getDailyWeather().daily[5].moonset),
                    moonPhase: weatherData?.getDailyWeather().daily[5].moonPhase.toString() ?? '',
                  ),
                  Day(
                    windSpeed: "${weatherData?.getDailyWeather().daily[6].temp?.max?.round().toString()} m/s",
                    pressure: '${weatherData?.getDailyWeather().daily[6].pressure.toString()} hPa',
                    windDegree: '${weatherData?.getDailyWeather().daily[6].windDeg.toString()}°',
                    uvi: weatherData?.getDailyWeather().daily[6].uvi.toString() ?? '',
                    humidity: '${weatherData?.getDailyWeather().daily[6].humidity.toString()}%',
                    tempMin: "${weatherData?.getDailyWeather().daily[6].temp?.min!.round().toString()}",
                    tempMax: "${weatherData?.getDailyWeather().daily[6].temp?.max!.round().toString()}",
                    icon: weatherData?.getDailyWeather().daily[6].weather![0].icon.toString() ?? '',
                    description: weatherData?.getDailyWeather().daily[6].weather![0].main.toString() ?? '',
                    summary: "${weatherData?.getDailyWeather().daily[6].summary}",
                    clouds: "${weatherData?.getDailyWeather().daily[6].clouds.toString()}%",
                    dewPoint: "${weatherData?.getDailyWeather().daily[6].dewPoint.toString()}°",
                    windGust: "${weatherData?.getDailyWeather().daily[6].windGust?.round().toString()} m/s",

                    morningTemp: "${weatherData?.getDailyWeather().daily[6].temp?.morn!.round().toString()}",
                    dayTemp: "${weatherData?.getDailyWeather().daily[6].temp?.day!.round().toString()}",
                    eveningTemp: "${weatherData?.getDailyWeather().daily[6].temp?.eve!.round().toString()}",
                    nightTemp: "${weatherData?.getDailyWeather().daily[6].temp?.night!.round().toString()}",

                    sunrise: getTime(weatherData?.getDailyWeather().daily[6].sunrise),
                    sunset: getTime(weatherData?.getDailyWeather().daily[6].sunset),
                    moonrise: getTime(weatherData?.getDailyWeather().daily[6].moonrise),
                    moonset: getTime(weatherData?.getDailyWeather().daily[6].moonset),
                    moonPhase: weatherData?.getDailyWeather().daily[6].moonPhase.toString() ?? '',
                  ),
                  Day(
                    windSpeed: "${weatherData?.getDailyWeather().daily[7].temp?.max?.round().toString()} m/s",
                    pressure: '${weatherData?.getDailyWeather().daily[7].pressure.toString()} hPa',
                    windDegree: '${weatherData?.getDailyWeather().daily[7].windDeg.toString()}°',
                    uvi: weatherData?.getDailyWeather().daily[7].uvi.toString() ?? '',
                    humidity: '${weatherData?.getDailyWeather().daily[7].humidity.toString()}%',
                    tempMin: "${weatherData?.getDailyWeather().daily[7].temp?.min!.round().toString()}",
                    tempMax: "${weatherData?.getDailyWeather().daily[7].temp?.max!.round().toString()}",
                    icon: weatherData?.getDailyWeather().daily[7].weather![0].icon.toString() ?? '',
                    description: weatherData?.getDailyWeather().daily[7].weather![0].main.toString() ?? '',
                    summary: "${weatherData?.getDailyWeather().daily[7].summary}",
                    clouds: "${weatherData?.getDailyWeather().daily[7].clouds.toString()}%",
                    dewPoint: "${weatherData?.getDailyWeather().daily[7].dewPoint.toString()}°",
                    windGust: "${weatherData?.getDailyWeather().daily[7].windGust?.round().toString()} m/s",

                    morningTemp: "${weatherData?.getDailyWeather().daily[7].temp?.morn!.round().toString()}",
                    dayTemp: "${weatherData?.getDailyWeather().daily[7].temp?.day!.round().toString()}",
                    eveningTemp: "${weatherData?.getDailyWeather().daily[7].temp?.eve!.round().toString()}",
                    nightTemp: "${weatherData?.getDailyWeather().daily[7].temp?.night!.round().toString()}",

                    sunrise: getTime(weatherData?.getDailyWeather().daily[7].sunrise),
                    sunset: getTime(weatherData?.getDailyWeather().daily[7].sunset),
                    moonrise: getTime(weatherData?.getDailyWeather().daily[7].moonrise),
                    moonset: getTime(weatherData?.getDailyWeather().daily[7].moonset),
                    moonPhase: weatherData?.getDailyWeather().daily[7].moonPhase.toString() ?? '',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _bottomSheet() {
    showModalBottomSheet(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height - 200,
      ),
      isDismissible: true,
      isScrollControlled: true,
      enableDrag: true,
      showDragHandle: true,
      backgroundColor: Theme.of(context).bottomSheetTheme.backgroundColor,
      context: context,
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.97,
          minChildSize: 0.97,
          maxChildSize: 0.97,
          builder: (_, controller) {
            return Container(
              padding: const EdgeInsets.only(
                left: 16,
                right: 16,
              ),
              child: ListView(
                controller: controller,
                children: [
                  Text(
                    "Weather Legend",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  const SizedBox(height: 10,),
                  DataTable(
                    dataRowMaxHeight: 70,
                    columns: [
                      DataColumn(label: Text("Detail", style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 14, fontWeight: FontWeight.w500))),
                      DataColumn(label: Text("Description", style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 14, fontWeight: FontWeight.w500))),
                    ],
                    rows: [
                      DataRow(cells: [
                        DataCell(Text("Wind Speed", style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 14))),
                        DataCell(Text("Speed of wind, m/s", style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 14))),
                      ]),
                      DataRow(cells: [
                        DataCell(Text("Wind Degree", style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 14))),
                        DataCell(Text("Wind direction, degrees (meteorological).", style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 14))),
                      ]),
                      DataRow(cells: [
                        DataCell(Text("Pressure", style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 14))),
                        DataCell(Text("Atmospheric pressure on the sea level, hPa", style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 14))),
                      ]),
                      DataRow(cells: [
                        DataCell(Text("UV Index", style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 14))),
                        DataCell(Text("The intensity of UV from sun, varies from 0 to 11+.", style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 14))),
                      ]),
                      DataRow(cells: [
                        DataCell(Text("Humidity", style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 14))),
                        DataCell(Text("Humidity, %", style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 14))),
                      ]),
                      DataRow(cells: [
                        DataCell(Text("Visibility", style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 14))),
                        DataCell(Text("Average visibility, metres. The maximum value of the visibility is 10 km.", style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 14))),
                      ]),
                      DataRow(cells: [
                        DataCell(Text("Clouds", style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 14))),
                        DataCell(Text("Cloudiness, %", style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 14))),
                      ]),
                      DataRow(cells: [
                        DataCell(Text("Dew Point", style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 14))),
                        DataCell(Text("Temperature below which water droplets forms a dew.", style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 14))),
                      ]),
                      DataRow(cells: [
                        DataCell(Text("Wind Gust", style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 14))),
                        DataCell(Text("A wind gust is a sudden burst of high-speed wind.", style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 14))),
                      ]),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
