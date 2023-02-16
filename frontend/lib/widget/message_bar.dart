import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../screens/detail_screen.dart';

class MessageBar extends StatelessWidget {
  final int id;
  final String title;
  final DateTime date;
  final String division;
  final String step;

  MessageBar({this.title, this.date, this.division, this.step, this.id});

  @override
  Widget build(BuildContext context) {
    final double screen_height = MediaQuery.of(context).size.height;
    final check = MediaQuery.of(context).orientation;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Column(
        children: <Widget>[
          Container(
            height: check == Orientation.portrait
                ? screen_height / 12 - 30
                : screen_height / 9.6 - 15,
            child: Stack(
              alignment: Alignment.topCenter,
              children: <Widget>[
                Positioned.fill(
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 15,
                      child: Image.asset(
                        'assets/images/speaker.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    title: FittedBox(
                      child: Text(
                        title,
                        style: TextStyle(
                          fontSize: check == Orientation.portrait ? 16.0 : 10.0,
                        ),
                      ),
                      fit: BoxFit.contain,
                    ),
                    trailing: Text(
                      DateFormat('yyyy-MM-dd').format(date),
                    ),
                  ),
                ),
                Positioned.fill(
                  bottom: 0.0,
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).pushNamed(
                          DetailScreen.RouteName,
                          arguments: id,
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10.0),
          const Divider(height: 10),
        ],
      ),
    );
  }
}
