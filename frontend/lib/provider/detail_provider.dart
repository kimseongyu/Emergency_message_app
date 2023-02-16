import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Detail {
  final String title;
  final String region;
  final String date;
  final String content;

  Detail({this.title, this.content, this.date, this.region});
}

class DetailProvider with ChangeNotifier {
  Detail _detail;

  Detail get detail {
    return _detail;
  }

  Future<void> fetchDetail(int id) async {
    final url = Uri.parse('https://emessageapp.run.goorm.site/contents');
    final parameter = {'num': id.toString()};
    try {
      final response = await http.post(url, body: parameter);
      // final datas = json.decode(response.body) as Map<String, dynamic>;
      // print(datas);
      final datas = {
        "title": "2023/02/02 20:04:12 [서울경찰청]",
        "region": "서울특별시",
        "area": "마포구",
        "date": "2023-02-02 20:04:30",
        "content": "정승원 실종"
      };
      Detail tmp = Detail(
        title: datas['title'],
        region: datas['region'],
        content: datas['content'],
        date: datas['date'],
      );
      _detail = tmp;
    } catch (error) {
      throw error;
    }
  }
}
