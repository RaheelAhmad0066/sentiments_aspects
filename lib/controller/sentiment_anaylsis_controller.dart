import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SentimentController extends GetxController {
  var aspects = <String>[].obs;
  var sentiments = <String>[].obs;
  var errorMessage = ''.obs;
  var totalScore = 0.obs;
  var loading = false.obs;

  Future<void> analyzeSentiment(String text) async {
    loading.value = true;
    final url =
        Uri.parse('http://127.0.0.1:5000/search_sentence?sentence=$text');
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        aspects.value = List<String>.from(data['aspects']);
        sentiments.value = List<String>.from(data['sentiments']);
        errorMessage.value = '';
        calculateTotalScore();
      } else {
        errorMessage.value = 'Error: ${response.reasonPhrase}';
        aspects.clear();
        sentiments.clear();
        totalScore.value = 0;
      }
    } catch (e) {
      errorMessage.value = 'Error: $e';
      print(e);
      aspects.clear();
      sentiments.clear();
      totalScore.value = 0;
    } finally {
      loading.value = false;
    }
  }

  void calculateTotalScore() {
    totalScore.value = 0;
    for (String sentiment in sentiments) {
      if (sentiment.toLowerCase() == 'positive') {
        totalScore.value++;
      } else if (sentiment.toLowerCase() == 'negative') {
        totalScore.value--;
      }
    }
  }

  Color getSentimentColor(String sentiment) {
    switch (sentiment.toLowerCase()) {
      case 'positive':
        return Colors.green;
      case 'negative':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
