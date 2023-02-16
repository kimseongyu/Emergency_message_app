import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Message {
  final int id;
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
              (element.region == filter['state'] ||
                  filter['state'] == '시도선택') &&
              (element.area == filter['city'] || filter['city'] == '시군구선택')),
        )
        .toList();

    return tmp;
  }

  Future<void> fetchData(String start, String end) async {
    final parameter = {'start': start, 'end': end};
    final url = Uri.parse('https://emessageapp.run.goorm.site/list');

    try {
      final response = await http.post(url, body: parameter);
      // final datas = json.decode(response.body) as Map<String, dynamic>;
      // if (datas == null) {
      //   return;
      // }
      // print(datas);
      final datas = {
        "2023-02-12": [
          {
            "num": "192577",
            "division": "기타",
            "step": "안전안내",
            "title": "2023/02/12 20:04:12 [서울경찰청]",
            'area': '종로구',
            'region': '서울특별시',
          }
        ],
        "2023-02-13": [
          {
            "num": "192576",
            "division": "전염병",
            "step": "안전안내",
            "title": "2023/02/13 20:04:12 [대전경찰청]",
            'area': '동구',
            'region': '대전광역시',
          }
        ],
        "2023-02-14": [
          {
            "num": "192575",
            "division": "한파",
            "step": "안전안내",
            "title": "2023/02/14 20:04:12 [대구경찰청]",
            'area': '중구',
            'region': '대구광역시',
          },
          {
            "num": "192575",
            "division": "한파",
            "step": "안전안내",
            "title": "2023/02/14 22:04:12 [대구경찰청]",
            'area': '중구',
            'region': '대구광역시',
          },
        ]
      };
      List<Message> tmp = [];
      for (int x = 0; x < 10; x++) {
        datas.forEach((key, value) {
          for (int i = 0; i < value.length; i++) {
            tmp.add(Message(
              id: int.parse(value[i]['num']),
              date: DateTime.parse(key),
              divison: value[i]['division'],
              step: value[i]['step'],
              title: value[i]['title'],
              area: value[i]['area'],
              region: value[i]['region'],
            ));
          }
        });
      }
      ;
      tmp.sort(
        (b, a) => a.title.compareTo(b.title),
      );
      _message = tmp;
    } catch (error) {
      throw error;
    }
  }
}
