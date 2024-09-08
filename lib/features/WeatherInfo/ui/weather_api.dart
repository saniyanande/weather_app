import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_app/features/WeatherInfo/ui/weather.dart';

const API_KEY = "your_api_key";
Future<Weather> fetchWeather(String location) async {
  final response = await http.get(Uri.parse(
      'https://api.weatherapi.com/v1/current.json?key=$API_KEY&q=$location&aqi=no'));

  if (response.statusCode == 200) {
    final Map<String, dynamic> json = jsonDecode(response.body);
    return Weather.fromJson(json);
  } else {
    throw Exception('Failed to load weather data');
  }
}
