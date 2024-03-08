
import 'package:flutter/material.dart';
import 'package:weather_app_flutter_main/widgets/weather_detail_widget.dart';


class OtherTemps extends StatelessWidget {

  final String morningTemp;
  final String dayTemp;
  final String eveningTemp;
  final String nightTemp;

  const OtherTemps({
    super.key,
    required this.morningTemp,
    required this.dayTemp,
    required this.eveningTemp,
    required this.nightTemp,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        left: 15,
        right: 15,
        bottom: 15,
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 15,
        horizontal: 10,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Other Temps",
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              WeatherDetailWidget(
                asset: "assets/icons/sunrise.png",
                value: "$morningTemp°",
                title: "Morning",
                isIcon: false,
                icon: const Icon(Icons.co2),
              ),
              WeatherDetailWidget(
                asset: "assets/icons/day.png",
                value: "$dayTemp°",
                title: "Day",
                isIcon: false,
                icon: const Icon(Icons.co2),
              ),
              WeatherDetailWidget(
                asset: "assets/icons/sunset.png",
                value: "$eveningTemp°",
                title: "Evening",
                isIcon: false,
                icon: const Icon(Icons.co2),
              ),
              WeatherDetailWidget(
                asset: "assets/icons/night.png",
                value: "$nightTemp°",
                title: "Night",
                isIcon: false,
                icon: const Icon(Icons.co2),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
