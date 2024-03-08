
import 'package:flutter/material.dart';
import 'package:weather_app_flutter_main/widgets/weather_detail_widget.dart';


class RiseSetTimings extends StatelessWidget {

  final String sunrise;
  final String sunset;
  final String moonrise;
  final String moonset;
  final String moonPhase;

  const RiseSetTimings({
    super.key,
    required this.sunrise,
    required this.sunset,
    required this.moonrise,
    required this.moonset,
    required this.moonPhase,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              WeatherDetailWidget(
                asset: "assets/icons/sunrise.png",
                value: sunrise,
                title: "Sunrise",
                isIcon: false,
                icon: const Icon(Icons.co2),
              ),
              WeatherDetailWidget(
                asset: "assets/icons/sunset.png",
                value: sunset,
                title: "Sunset",
                isIcon: false,
                icon: const Icon(Icons.co2),
              ),
              WeatherDetailWidget(
                asset: "assets/icons/moonrise.png",
                value: moonrise,
                title: "Moonrise",
                isIcon: false,
                icon: const Icon(Icons.co2),
              ),
              WeatherDetailWidget(
                asset: "assets/icons/moonset.png",
                value: moonset,
                title: "Moonset",
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
