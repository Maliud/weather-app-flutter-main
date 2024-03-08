
class WeatherData {

  final WeatherDataCurrent? current;
  final WeatherDataHourly? hourly;
  final WeatherDataDaily? daily;

  WeatherData([this.current, this.hourly, this.daily]);

  WeatherDataCurrent getCurrentWeather() {
    return current!;
  }

  WeatherDataHourly getHourlyWeather() {
    return hourly!;
  }

  WeatherDataDaily getDailyWeather() {
    return daily!;
  }
}

class WeatherDataCurrent {

  final Current current;

  WeatherDataCurrent({
    required this.current,
  });

  factory WeatherDataCurrent.fromJson(Map<String, dynamic> json) =>
      WeatherDataCurrent(current: Current.fromJson(json['current']));
}

class WeatherDataHourly {

  List<Hourly> hourly;

  WeatherDataHourly({
    required this.hourly,
  });

  factory WeatherDataHourly.fromJson(Map<String, dynamic> json) =>
      WeatherDataHourly(hourly: List<Hourly>.from(json['hourly'].map((x) => Hourly.fromJson(x))));
}

class WeatherDataDaily {

  List<Daily> daily;

  WeatherDataDaily({
    required this.daily,
  });

  factory WeatherDataDaily.fromJson(Map<String, dynamic> json) =>
      WeatherDataDaily(daily: List<Daily>.from(json['daily'].map((x) => Daily.fromJson(x))));
}

class Current {
  int? dt;
  int? sunrise;
  int? sunset;
  double? temp;
  double? feelsLike;
  double? pressure;
  double? humidity;
  double? dewPoint;
  double? uvi;
  double? clouds;
  double? visibility;
  double? windSpeed;
  double? windDeg;
  double? windGust;
  List<Weather>? weather;

  Current({
    this.dt,
    this.sunrise,
    this.sunset,
    this.temp,
    this.feelsLike,
    this.pressure,
    this.humidity,
    this.dewPoint,
    this.uvi,
    this.clouds,
    this.visibility,
    this.windSpeed,
    this.windDeg,
    this.windGust,
    this.weather,
  });

  factory Current.fromJson(Map<String, dynamic> json) => Current(
    dt: json['dt'] as int?,
    sunrise: json['sunrise'] as int?,
    sunset: json['sunset'] as int?,
    temp: (json['temp'] as num?)?.toDouble(),
    feelsLike: (json['feels_like'] as num?)?.toDouble(),
    pressure: (json['pressure'] as num?)?.toDouble(),
    humidity: (json['humidity'] as num?)?.toDouble(),
    dewPoint: (json['dew_point'] as num?)?.toDouble(),
    uvi: (json['uvi'] as num?)?.toDouble(),
    clouds: (json['clouds'] as num?)?.toDouble(),
    visibility: (json['visibility'] as num?)?.toDouble(),
    windSpeed: (json['wind_speed'] as num?)?.toDouble(),
    windDeg: (json['wind_deg'] as num?)?.toDouble(),
    windGust: (json['wind_gust'] as num?)?.toDouble(),
    weather: (json['weather'] as List<dynamic>?)
        ?.map((e) => Weather.fromJson(e as Map<String, dynamic>))
        .toList(),
  );

  Map<String, dynamic> toJson() => {
    'dt': dt,
    'sunrise': sunrise,
    'sunset': sunset,
    'temp': temp,
    'feels_like': feelsLike,
    'pressure': pressure,
    'humidity': humidity,
    'dew_point': dewPoint,
    'uvi': uvi,
    'clouds': clouds,
    'visibility': visibility,
    'wind_speed': windSpeed,
    'wind_deg': windDeg,
    'wind_gust': windGust,
    'weather': weather?.map((e) => e.toJson()).toList(),
  };
}

class Hourly {
  int? dt;
  double? temp;
  double? feelsLike;
  double? pressure;
  double? humidity;
  double? dewPoint;
  double? uvi;
  double? clouds;
  double? visibility;
  double? windSpeed;
  double? windDeg;
  double? windGust;
  List<Weather>? weather;
  double? pop;

  Hourly({
    this.dt,
    this.temp,
    this.feelsLike,
    this.pressure,
    this.humidity,
    this.dewPoint,
    this.uvi,
    this.clouds,
    this.visibility,
    this.windSpeed,
    this.windDeg,
    this.windGust,
    this.weather,
    this.pop,
  });

  factory Hourly.fromJson(Map<String, dynamic> json) => Hourly(
    dt: json['dt'] as int?,
    temp: (json['temp'] as num?)?.toDouble(),
    feelsLike: (json['feels_like'] as num?)?.toDouble(),
    pressure: (json['pressure'] as num?)?.toDouble(),
    humidity: (json['humidity'] as num?)?.toDouble(),
    dewPoint: (json['dew_point'] as num?)?.toDouble(),
    uvi: (json['uvi'] as num?)?.toDouble(),
    clouds: (json['clouds'] as num?)?.toDouble(),
    visibility: (json['visibility'] as num?)?.toDouble(),
    windSpeed: (json['wind_speed'] as num?)?.toDouble(),
    windDeg: (json['wind_deg'] as num?)?.toDouble(),
    windGust: (json['wind_gust'] as num?)?.toDouble(),
    weather: (json['weather'] as List<dynamic>?)
        ?.map((e) => Weather.fromJson(e as Map<String, dynamic>))
        .toList(),
    pop: (json['pop'] as num?)?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    'dt': dt,
    'temp': temp,
    'feels_like': feelsLike,
    'pressure': pressure,
    'humidity': humidity,
    'dew_point': dewPoint,
    'uvi': uvi,
    'clouds': clouds,
    'visibility': visibility,
    'wind_speed': windSpeed,
    'wind_deg': windDeg,
    'wind_gust': windGust,
    'weather': weather?.map((e) => e.toJson()).toList(),
    'pop': pop,
  };
}

class Daily {
  int? dt;
  int? sunrise;
  int? sunset;
  int? moonrise;
  int? moonset;
  double? moonPhase;
  String? summary;
  Temp? temp;
  FeelsLike? feelsLike;
  double? pressure;
  double? humidity;
  double? dewPoint;
  double? windSpeed;
  double? windDeg;
  double? windGust;
  List<Weather>? weather;
  double? clouds;
  double? pop;
  double? uvi;

  Daily({
    this.dt,
    this.sunrise,
    this.sunset,
    this.moonrise,
    this.moonset,
    this.moonPhase,
    this.summary,
    this.temp,
    this.feelsLike,
    this.pressure,
    this.humidity,
    this.dewPoint,
    this.windSpeed,
    this.windDeg,
    this.windGust,
    this.weather,
    this.clouds,
    this.pop,
    this.uvi,
  });

  factory Daily.fromJson(Map<String, dynamic> json) => Daily(
    dt: json['dt'] as int?,
    sunrise: json['sunrise'] as int?,
    sunset: json['sunset'] as int?,
    moonrise: json['moonrise'] as int?,
    moonset: json['moonset'] as int?,
    moonPhase: (json['moon_phase'] as num?)?.toDouble(),
    summary: json['summary'] as String?,
    temp: json['temp'] == null
        ? null
        : Temp.fromJson(json['temp'] as Map<String, dynamic>),
    feelsLike: json['feels_like'] == null
        ? null
        : FeelsLike.fromJson(json['feels_like'] as Map<String, dynamic>),
    pressure: (json['pressure'] as num?)?.toDouble(),
    humidity: (json['humidity'] as num?)?.toDouble(),
    dewPoint: (json['dew_point'] as num?)?.toDouble(),
    windSpeed: (json['wind_speed'] as num?)?.toDouble(),
    windDeg: (json['wind_deg'] as num?)?.toDouble(),
    windGust: (json['wind_gust'] as num?)?.toDouble(),
    weather: (json['weather'] as List<dynamic>?)
        ?.map((e) => Weather.fromJson(e as Map<String, dynamic>))
        .toList(),
    clouds: (json['clouds'] as num?)?.toDouble(),
    pop: (json['pop'] as num?)?.toDouble(),
    uvi: (json['uvi'] as num?)?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    'dt': dt,
    'sunrise': sunrise,
    'sunset': sunset,
    'moonrise': moonrise,
    'moonset': moonset,
    'moon_phase': moonPhase,
    'summary': summary,
    'temp': temp?.toJson(),
    'feels_like': feelsLike?.toJson(),
    'pressure': pressure,
    'humidity': humidity,
    'dew_point': dewPoint,
    'wind_speed': windSpeed,
    'wind_deg': windDeg,
    'wind_gust': windGust,
    'weather': weather?.map((e) => e.toJson()).toList(),
    'clouds': clouds,
    'pop': pop,
    'uvi': uvi,
  };
}

class Weather {
  String? main;
  String? description;
  String? icon;

  Weather({
    this.main,
    this.description,
    this.icon,
  });

  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
    main: json['main'] as String?,
    description: json['description'] as String?,
    icon: json['icon'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'main': main,
    'description': description,
    'icon': icon,
  };
}

class Temp {
  double? day;
  double? min;
  double? max;
  double? night;
  double? eve;
  double? morn;

  Temp({this.day, this.min, this.max, this.night, this.eve, this.morn});

  factory Temp.fromJson(Map<String, dynamic> json) => Temp(
    day: (json['day'] as num?)?.toDouble(),
    min: (json['min'] as num?)?.toDouble(),
    max: (json['max'] as num?)?.toDouble(),
    night: (json['night'] as num?)?.toDouble(),
    eve: (json['eve'] as num?)?.toDouble(),
    morn: (json['morn'] as num?)?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    'day': day,
    'min': min,
    'max': max,
    'night': night,
    'eve': eve,
    'morn': morn,
  };
}

class FeelsLike {
  double? day;
  double? night;
  double? eve;
  double? morn;

  FeelsLike({this.day, this.night, this.eve, this.morn});

  factory FeelsLike.fromJson(Map<String, dynamic> json) => FeelsLike(
    day: (json['day'] as num?)?.toDouble(),
    night: (json['night'] as num?)?.toDouble(),
    eve: (json['eve'] as num?)?.toDouble(),
    morn: (json['morn'] as num?)?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    'day': day,
    'night': night,
    'eve': eve,
    'morn': morn,
  };
}
