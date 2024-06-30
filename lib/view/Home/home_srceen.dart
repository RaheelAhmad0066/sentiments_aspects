import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../controller/sentiment_anaylsis_controller.dart';

class SentimentAnalysisPage extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();
  final SentimentController _sentimentController =
      Get.put(SentimentController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sentiment Analysis'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Enter a sentence to analyze its sentiment:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      minLines: 3,
                      maxLines: 5,
                      decoration: const InputDecoration(
                        hintText: 'Enter a sentence',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      if (_controller.text.isNotEmpty) {
                        _sentimentController.analyzeSentiment(_controller.text);
                      }
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Obx(() {
              if (_sentimentController.loading.value) {
                return const Center(
                  child: SpinKitCircle(
                    color: Colors.blue,
                    size: 50.0,
                  ),
                );
              } else if (_sentimentController.errorMessage.isNotEmpty) {
                return Text(
                  _sentimentController.errorMessage.value,
                  style: const TextStyle(color: Colors.red),
                );
              } else if (_sentimentController.aspects.isNotEmpty &&
                  _sentimentController.sentiments.isNotEmpty) {
                return Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Aspects Analysis',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Expanded(
                        child: ListView.builder(
                          itemCount: _sentimentController.aspects.length,
                          itemBuilder: (context, index) {
                            String aspect = _sentimentController.aspects[index];
                            String sentiment =
                                _sentimentController.sentiments[index];
                            return Container(
                              padding: EdgeInsets.all(8.0),
                              margin: EdgeInsets.symmetric(vertical: 4.0),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(aspect,
                                      style: TextStyle(color: Colors.black)),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 8.0, vertical: 4.0),
                                    decoration: BoxDecoration(
                                      color: _sentimentController
                                          .getSentimentColor(sentiment),
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    child: Text(
                                      sentiment,
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Total Score',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Obx(() {
                        int score = _sentimentController.totalScore.value;
                        return Text(
                          score > 0
                              ? 'Positive: $score'
                              : score < 0
                                  ? 'Negative: $score'
                                  : 'Neutral: $score',
                          style: TextStyle(fontSize: 16),
                        );
                      }),
                    ],
                  ),
                );
              } else {
                return Container();
              }
            }),
          ],
        ),
      ),
    );
  }
}
