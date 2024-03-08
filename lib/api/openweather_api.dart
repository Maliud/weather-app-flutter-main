
class OpenWeatherAPI {

  String apiKey = 'Api Key Giriniz// Api Key Here';

  String apiUrl(lat, lon) {
    return 'https://api.openweathermap.org/data/3.0/onecall?lat=$lat&lon=$lon&appid=$apiKey';
  
  }
}
