import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/home_screen.dart';
import './provider/message_provider.dart';
import './screens/detail_screen.dart';
import './provider/detail_provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => MessageProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => DetailProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'MyShop',
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        home: MyHomePage(),
        routes: {DetailScreen.RouteName: (context) => DetailScreen()},
      ),
    );
  }
}
