
import 'package:flutter/material.dart';

class FrostedGlassCurrent extends StatelessWidget {

  final double borderRadius;

  final String temp;
  final String tempMin;
  final String tempMax;

  final String icon;
  final String description;

  const FrostedGlassCurrent({
    Key? key,
    this.borderRadius = 30.0,
    required this.temp,
    required this.tempMin,
    required this.tempMax,
    required this.icon,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: Container(
        padding: const EdgeInsets.all(5),
        margin: const EdgeInsets.all(10),
        width: double.infinity,
        height: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          color: Theme.of(context).colorScheme.secondary,
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Image.asset(
                "assets/weather/$icon.png",
                width: 100,
                height: 100,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 10,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Text(
                          description,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          "$tempMin°/$tempMax°",
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "$temp°",
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
