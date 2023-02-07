import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/detail_provider.dart';

class DetailScreen extends StatelessWidget {
  static const RouteName = './DetailScreen';

  @override
  Widget build(BuildContext context) {
    final List<String> data =
        ModalRoute.of(context).settings.arguments as List<String>;
    return Scaffold(
      appBar: AppBar(title: Text(data[0])),
      body: FutureBuilder(
        future: Provider.of<DetailProvider>(context)
            .fetchDetail(int.parse(data[1])),
        // ignore: missing_return
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            if (snapshot.error != null) {
              return Container();
            } else {
              return Container();
            }
          }
        },
      ),
    );
  }
}
