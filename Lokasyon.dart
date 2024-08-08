import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Lokasyon extends StatefulWidget {
  final String username;

  Lokasyon({required this.username});

  @override
  _LokasyonState createState() => _LokasyonState();
}

class _LokasyonState extends State<Lokasyon> {
  String location = '';
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchLocation();
  }

  Future<void> fetchLocation() async {
    final response = await http.get(Uri.parse('http://192.168.112.230:8081/api/location/${widget.username}'));
    if (response.statusCode == 200) {
      setState(() {
        location = response.body;
        isLoading = false;
      });
    } else {
      setState(() {
        location = 'Failed to load location';
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text(''),
    ),
    body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          isLoading
              ? CircularProgressIndicator()
              : Text(
                  '  $location',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
          // Diğer widget'lar buraya eklenebilir
        ],
      ),
    ),
  );
}
}
