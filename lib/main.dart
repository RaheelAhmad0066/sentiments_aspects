import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _controller = TextEditingController();
  String _result = '';

  Future<void> _checkCode() async {
    final response = await http.post(
      Uri.parse('http://127.0.0.1:5000/check-code'),
      body: {'code': _controller.text},
    );

    setState(() {
      _result = json.decode(response.body).toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Code Security Checker'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Enter JavaScript Code',
                border: OutlineInputBorder(),
              ),
              maxLines: 10,
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _checkCode,
              child: Text('Check Security'),
            ),
            SizedBox(height: 10),
            Text(_result),
          ],
        ),
      ),
    );
  }
}
