
class OpenWeatherAPI {

  String apiKey = 'e37a50392c8b57e68ffb63872d2e64a4';

  String apiUrl(lat, lon) {
    return 'https://api.openweathermap.org/data/3.0/onecall?lat=$lat&lon=$lon&appid=$apiKey';
  
  }
}
