import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../modal/type.dart';

class Filter_button extends StatefulWidget {
  String _state;
  String _city;
  String _disease;
  String _detail;
  String _startDate;
  String _endDate;

  Filter_button(setting) {
    _state = setting['state'];
    _city = setting['city'];
    _disease = setting['disease'];
    _detail = setting['detail'];
    _startDate = setting['start'];
    _endDate = setting['end'];
  }

  @override
  State<Filter_button> createState() => _Filter_buttonState();
}

class _Filter_buttonState extends State<Filter_button>
    with TickerProviderStateMixin {
  bool _areaArrow = false;
  bool _diseaseArrow = false;
  AnimationController _cityController;
  AnimationController _diseaController;

  @override
  void initState() {
    _cityController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    _diseaController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
  }

  void _areaControl() {
    setState(() {
      _areaArrow = !_areaArrow;
      _areaArrow ? _cityController.forward() : _cityController.reverse();
    });
  }

  void _diseaseControl() {
    setState(() {
      _diseaseArrow = !_diseaseArrow;
      _diseaseArrow ? _diseaController.forward() : _diseaController.reverse();
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return SingleChildScrollView(
        child: Padding(
      padding: const EdgeInsets.all(8),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(width: screenSize.width * 0.1),
            Text('날짜 범위 설정', style: Theme.of(context).textTheme.titleMedium),
            IconButton(
              onPressed: () {
                Navigator.pop(context, {
                  'start': widget._startDate,
                  'end': widget._endDate,
                  'state': widget._state,
                  'city': widget._city,
                  'disease': widget._disease,
                  'detail': widget._detail,
                });
              },
              icon: Icon(Icons.save),
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(width: screenSize.width * 0.02),
            Text(widget._startDate),
            SizedBox(width: screenSize.width * 0.02),
            const Text('~'),
            SizedBox(width: screenSize.width * 0.02),
            Text(widget._endDate),
            TextButton(
              child: Text('날짜 범위설정'),
              onPressed: () async {
                final picked = await showDateRangePicker(
                  context: context,
                  firstDate: DateTime.now().subtract(Duration(days: 7)),
                  lastDate: DateTime.now(),
                );
                if (picked != null) {
                  setState(
                    () {
                      widget._startDate =
                          DateFormat('yyyy-MM-dd').format(picked.start);
                      widget._endDate =
                          DateFormat('yyyy-MM-dd').format(picked.end);
                    },
                  );
                }
              },
            ),
          ],
        ),
        Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(width: screenSize.width * 0.1),
            Text('대상지역', style: Theme.of(context).textTheme.titleMedium),
            IconButton(
              onPressed: () {
                setState(() => _areaControl());
              },
              icon: AnimatedIcon(
                icon: AnimatedIcons.menu_arrow,
                progress: _cityController,
                size: 22,
              ),
            )
          ],
        ),
        AnimatedContainer(
          height: _areaArrow ? 150 : 0,
          duration: Duration(milliseconds: 300),
          child: SingleChildScrollView(
            child: Column(children: [
              Row(
                children: [
                  Text('시도선택', style: Theme.of(context).textTheme.titleSmall),
                  SizedBox(width: screenSize.width * 0.035),
                  Flexible(
                    flex: 5,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButtonFormField(
                            value: widget._state,
                            items: city.keys.toList().map(
                              (e) {
                                return new DropdownMenuItem<String>(
                                  value: e,
                                  child: new Text(e),
                                );
                              },
                            ).toList(),
                            onChanged: (value) {
                              setState(() {
                                widget._state = value;
                                widget._city = '시군구선택';
                              });
                            }),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text('시군구선택', style: Theme.of(context).textTheme.titleSmall),
                  Flexible(
                    flex: 5,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButtonFormField(
                            value: widget._city,
                            items: city[widget._state].map(
                              (e) {
                                return new DropdownMenuItem<String>(
                                  value: e,
                                  child: new Text(e),
                                );
                              },
                            ).toList(),
                            onChanged: (value) {
                              setState(() {
                                widget._city = value;
                              });
                            }),
                      ),
                    ),
                  ),
                ],
              ),
            ]),
          ),
        ),
        Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(width: screenSize.width * 0.1),
            Text('재해구분', style: Theme.of(context).textTheme.titleMedium),
            IconButton(
                onPressed: () {
                  setState(() => _diseaseControl());
                },
                icon: AnimatedIcon(
                  icon: AnimatedIcons.menu_arrow,
                  progress: _diseaController,
                  size: 22,
                ))
          ],
        ),
        AnimatedContainer(
          duration: Duration(milliseconds: 300),
          height: _diseaseArrow ? 150 : 0,
          child: SingleChildScrollView(
            child: Column(children: [
              Row(
                children: [
                  Text('재난선택', style: Theme.of(context).textTheme.titleSmall),
                  SizedBox(width: screenSize.width * 0.035),
                  Flexible(
                    flex: 5,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButtonFormField(
                            value: widget._disease,
                            items: disease.keys.map(
                              (e) {
                                return new DropdownMenuItem<String>(
                                  value: e,
                                  child: new Text(e),
                                );
                              },
                            ).toList(),
                            onChanged: (value) {
                              setState(() {
                                widget._disease = value;
                                widget._detail = '재난상세';
                              });
                            }),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text('재난상세', style: Theme.of(context).textTheme.titleSmall),
                  SizedBox(width: screenSize.width * 0.035),
                  Flexible(
                    flex: 5,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButtonFormField(
                            value: widget._detail,
                            items: disease[widget._disease].map(
                              (e) {
                                return new DropdownMenuItem<String>(
                                  value: e,
                                  child: new Text(e),
                                );
                              },
                            ).toList(),
                            onChanged: (value) {
                              setState(() {
                                widget._detail = value;
                              });
                            }),
                      ),
                    ),
                  ),
                ],
              ),
            ]),
          ),
        ),
      ]),
    ));
  }
}
