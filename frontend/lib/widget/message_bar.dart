import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../screens/detail_screen.dart';

class MessageBar extends StatelessWidget {
  final String id;
  final String title;
  final DateTime date;
  final String division;
  final String step;

  MessageBar({this.title, this.date, this.division, this.step, this.id});

  @override
  Widget build(BuildContext context) {
    final double screen_height = MediaQuery.of(context).size.height;
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 2),
          height: screen_height / 10,
          child: Stack(children: <Widget>[
            Positioned.fill(
              bottom: 0.0,
              child: ListTile(
                leading: CircleAvatar(
                    radius: 15,
                    child: Image.asset('assets/images/speaker.png',
                        fit: BoxFit.cover)),
                title: FittedBox(child: Text(title)),
                trailing: Text(DateFormat.yMMMd().format(date)),
              ),
            ),
            Positioned.fill(
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  child: Container(
                    height: double.infinity,
                  ),
                  onTap: () {
                    Navigator.of(context).pushNamed(DetailScreen.RouteName,
                        arguments: [title, id]);
                  },
                ),
              ),
            ),
          ]),
        ),
        Divider(),
      ],
    );
  }
}
