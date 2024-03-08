
import 'package:flutter/material.dart';
import 'package:weather_app_flutter_main/theme/pallete.dart';


class Loader extends StatelessWidget {

  final String? error;

  final bool isError;

  const Loader({
    super.key,
    required this.isError,
    required this.error,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.primary,
      height: double.infinity,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/icons/clouds.png",
            width: 100,
          ),
          const SizedBox(height: 20),
          const CircularProgressIndicator(
            color: PalleteLight.iconColor,
          ),
          const SizedBox(height: 20),
          isError ? Text(
            error!,
            style: Theme.of(context).textTheme.bodyMedium,
          ) : const SizedBox(),
        ],
      ),
    );
  }
}
