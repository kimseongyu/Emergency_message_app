import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Message {
  final String id;
  final String divison;
  final String step;
  final DateTime date;
  final String title;
  final String region;
  final String area;

  Message(
      {this.id,
      this.divison,
      this.step,
      this.date,
      this.title,
      this.region,
      this.area});
}

class MessageProvider with ChangeNotifier {
  List<Message> _message = [];

  List<Message> message(Map<String, String> filter) {
    final tmp = _message
        .where(
          (element) => ((element.divison == filter['detail'] ||
                  filter['detail'] == '재난상세') &&
              (element.region == filter['region'] ||
                  filter['region'] == '시도선택')),
        )
        .toList();

    return tmp;
  }

  Future<void> fetchData(String start, String end) async {
    final parameter = {'start': start, 'end': end};
    final url = Uri.parse('https://emessageapp.run.goorm.app/list');

    try {
      final response = await http.post(url, body: parameter);
      final datas = json.decode(response.body) as Map<String, dynamic>;
      if (datas == null) {
        return;
      }
      List<Message> tmp = [];
      datas.forEach((key, value) {
        for (int i = 0; i < value.length; i++) {
          tmp.add(Message(
            id: value[i]['num'],
            date: DateTime.parse(key),
            divison: value[i]['division'],
            step: value[i]['step'],
            title: value[i]['title'],
            area: value[i]['area'],
            region: value[i]['region'],
          ));
        }
      });
      _message = tmp;
    } catch (error) {
      throw error;
    }
  }
}
