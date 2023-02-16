import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../provider/message_provider.dart';
import '../widget/message_bar.dart';
import '../widget/filter_button.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Map<String, String> _filter = {
    'start': DateFormat('yyyy-MM-dd')
        .format(DateTime.now().subtract(Duration(days: 7))),
    'end': DateFormat('yyyy-MM-dd').format(DateTime.now()),
    'state': '시도선택',
    'city': '시군구선택',
    'disease': '재난선택',
    'detail': '재난상세',
  };

  Future<void> _refresh(BuildContext context) async {
    await setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) {
        return <Widget>[
          SliverAppBar(
            snap: true,
            floating: true,
            expandedHeight: 40,
            elevation: 10,
            automaticallyImplyLeading: false,
            title: const Text('전국 재난 문자'),
            actions: [
              IconButton(
                //검색기능 (Form)
                icon: const Icon(Icons.search),
                onPressed: () => showDialog(
                  context: context,
                  builder: (context) => Dialog(child: Text('Test')),
                ),
              ),
              //필터링 기능 (Modalpopupsheet)
              IconButton(
                icon: const Icon(Icons.filter_alt),
                onPressed: () async {
                  final tmp = await showModalBottomSheet(
                    context: context,
                    builder: (ctx) {
                      return Filter_button(_filter);
                    },
                  );
                  if (tmp != null) {
                    _filter = tmp;
                    setState(() {});
                  }
                  ;
                },
              ),
            ],
          )
        ];
      },
      body: RefreshIndicator(
        onRefresh: () => _refresh(context),
        child: FutureBuilder(
            future: Provider.of<MessageProvider>(context)
                .fetchData(_filter['start'], _filter['end']),
            // ignore: missing_return
            builder: (context, snapshot) {
              // 로딩중일때 표시
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else {
                if (snapshot.error != null) {
                  print(snapshot.error);
                  return Container();
                } else {
                  // 로딩 끝나면 컨텐츠를 화면상으로 표시
                  return Consumer<MessageProvider>(
                    builder: (context, data, child) {
                      final List<Message> message = data.message(_filter);
                      return Padding(
                        padding: const EdgeInsets.all(1),
                        child: ListView.builder(
                          itemCount: message.length,
                          itemBuilder: (context, index) {
                            return message.length == 0
                                ? Center(child: Text('No data'))
                                : MessageBar(
                                    title: message[index].title,
                                    date: message[index].date,
                                    division: message[index].divison,
                                    step: message[index].step,
                                    id: message[index].id,
                                  );
                          },
                        ),
                      );
                    },
                  );
                }
              }
            }),
      ),
    ));
  }
}
