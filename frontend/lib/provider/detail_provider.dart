import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Detail {
  final String title;
  final String region;
  final DateTime date;
  final String content;

  Detail({this.title, this.content, this.date, this.region});
}

class DetailProvider with ChangeNotifier {
  Detail _detail;

  Detail get detail {
    return _detail;
  }

  Future<void> fetchDetail(int id) async {
    final url = Uri.parse('https://emessageapp.run.goorm.app/contents');
    final parameter = {'num': id};
    try {
      final response = await http.post(url, body: parameter);
      final datas = json.decode(response.body) as Map<String, String>;
      Detail tmp = Detail(
        title: datas['title'],
        region: datas['region'],
        content: datas['content'],
        date: DateTime.parse(datas['content']),
      );
      _detail = tmp;
    } catch (error) {
      throw error;
    }
  }
}
