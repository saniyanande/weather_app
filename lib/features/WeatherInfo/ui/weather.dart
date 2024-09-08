class Weather {
  final String name;
  final String region;
  final String country;
  final String localtime;
  final double temp_c;
  final String condition;
  final String icon;

  Weather({
    required this.name,
    required this.region,
    required this.country,
    required this.localtime,
    required this.temp_c,
    required this.condition,
    required this.icon,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      name: json['location']['name'],
      region: json['location']['region'],
      country: json['location']['country'],
      localtime: json['location']['localtime'],
      temp_c: json['current']['temp_c'],
      condition: json['current']['condition']['text'],
      icon: "https:${json['current']['condition']['icon']}",
    );
  }
}
