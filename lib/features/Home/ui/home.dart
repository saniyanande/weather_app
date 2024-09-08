import 'package:flutter/material.dart';
import 'package:weather_app/features/WeatherInfo/ui/weather.dart';
import 'package:weather_app/features/WeatherInfo/ui/weather_api.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Future<Weather> futureWeather;
  String selectedLocation = 'Mumbai'; // Default selected location changed to Mumbai

  // Updated list of famous locations
  final List<String> locations = [
    'Mumbai',
    'Delhi',
    'New York',
    'London',
    'Tokyo',
    'Paris',
    'Sydney',
    'Dubai',
    'Los Angeles',
    'Moscow',
    'Beijing',
    'Singapore',
    'Berlin',
    'Rome',
    'Istanbul'
  ];

  @override
  void initState() {
    super.initState();
    futureWeather = fetchWeather(selectedLocation); // Fetch weather for the default location
  }

  void _onLocationChanged(String? newLocation) {
    if (newLocation != null) {
      setState(() {
        selectedLocation = newLocation;
        futureWeather = fetchWeather(selectedLocation); // Fetch weather for the selected location
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/blue_gradient.jpeg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.location_on,
                color: Color.fromARGB(255, 98, 98, 98), // Changed icon color to white
              ),
              // Dropdown for location selection
              DropdownButton<String>(
                dropdownColor: Colors.white, // Set dropdown background color to white
                value: selectedLocation,
                items: locations.map((String location) {
                  return DropdownMenuItem<String>(
                    value: location,
                    child: Text(
                      location,
                      style: const TextStyle(color: Colors.black), // Ensure text remains readable in dropdown
                    ),
                  );
                }).toList(),
                onChanged: _onLocationChanged, // Update location on change
              ),
              const SizedBox(height: 20),
              // Weather display with FutureBuilder
              FutureBuilder<Weather>(
                future: futureWeather,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator(); // Loading spinner
                  } else if (snapshot.hasError) {
                    return Text(
                      'Error: ${snapshot.error}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600, // Increased font weight
                        color: Color.fromARGB(255, 98, 98, 98),
                      ),
                    );
                  } else if (snapshot.hasData) {
                    final weather = snapshot.data!;
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Date & Time: ${weather.localtime}',
                          style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600, // Increased font weight
                              color: Color.fromARGB(255, 98, 98, 98)),
                        ),
                        const SizedBox(height: 30),
                        Padding(
                          padding: const EdgeInsets.symmetric(),
                          child: Text(
                            '${weather.name}, ${weather.region}, ${weather.country}',
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500, // Increased font weight
                                color: Color.fromARGB(255, 98, 98, 98)),
                          ),
                        ),
                        const SizedBox(height: 30),
                        Text(
                          '${weather.temp_c}°C',
                          style: const TextStyle(
                            fontSize: 54,
                            fontWeight: FontWeight.w900, // Increased font weight
                            color: Color.fromARGB(255, 98, 98, 98),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Image.network(
                          weather.icon, // Display the weather icon
                          height: 84,
                          width: 84,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          '${weather.condition}',
                          style: const TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w700, // Increased font weight
                              color: Color.fromARGB(255, 98, 98, 98)),
                        ),
                        const SizedBox(height: 10),
                      ],
                    );
                  }
                  return const Text('No data found');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
