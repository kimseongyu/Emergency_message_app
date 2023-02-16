import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/detail_provider.dart';

class DetailScreen extends StatefulWidget {
  static const RouteName = './DetailScreen';

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final int data = ModalRoute.of(context).settings.arguments as int;
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
        body: NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) {
        return <Widget>[
          SliverAppBar(
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
            floating: true,
            snap: true,
            title: Text('재난문자'),
            expandedHeight: 40,
            elevation: 10,
            automaticallyImplyLeading: false,
            // forceElevated: innerBoxIsScrolled,
          ),
        ];
      },
      body: FutureBuilder(
        future: Provider.of<DetailProvider>(context).fetchDetail(data),
        // ignore: missing_return
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            if (snapshot.error != null) {
              return Container();
            } else {
              return Consumer<DetailProvider>(
                builder: (context, detail, child) => SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: screenSize.height * 0.04),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 10),
                        child: Text(
                          detail.detail.title,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Divider(
                          thickness: 1,
                          color: Colors.blue,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: FittedBox(
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 15),
                                child: Text('· 송출지역: ${detail.detail.region}',
                                    style: TextStyle(
                                        color: Colors.black87, fontSize: 12)),
                              ),
                            ),
                          ),
                          Flexible(
                            child: FittedBox(
                              child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 17, vertical: 5),
                                  child: Text('· 작성일: ${detail.detail.date}',
                                      style: TextStyle(
                                          color: Colors.black87,
                                          fontSize: 12))),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Divider(color: Colors.blue, thickness: 1),
                      ),
                      Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Text(detail.detail.content,
                              style: TextStyle(fontSize: 15))),
                    ],
                  ),
                ),
              );
            }
          }
        },
      ),
    ));
  }
}
