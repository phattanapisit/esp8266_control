import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ESP8266 Light Control',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LightControlScreen(),
    );
  }
}

class LightControlScreen extends StatelessWidget {
  final String espUrl = "http://"; // ใส่ IP address ของ ESP8266 ที่นี่

  Future<void> _sendRequest(String endpoint) async {
    try {
      final response = await http.get(Uri.parse('$espUrl/$endpoint'));
      if (response.statusCode == 200) {
        print('Success: ${response.body}');
      } else {
        print('Failed to connect: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  void _turnOnLight() {
    _sendRequest("on");
  }

  void _turnOffLight() {
    _sendRequest("off");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ESP8266 Light Control'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: _turnOnLight,
              child: Text('Turn On'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _turnOffLight,
              child: Text('Turn Off'),
            ),
          ],
        ),
      ),
    );
  }
}
