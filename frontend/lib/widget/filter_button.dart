import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../modal/type.dart';

class Filter_button extends StatelessWidget {
  bool _areaArrow = true;
  bool _diseaseArrow = true;
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
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: StatefulBuilder(builder: (context, setState) {
        return Padding(
          padding: const EdgeInsets.all(8),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(width: screenSize.width * 0.1),
                Text('날짜 범위 설정',
                    style: Theme.of(context).textTheme.titleMedium),
                IconButton(
                  onPressed: () {
                    Navigator.pop(context, {
                      'start': _startDate,
                      'end': _endDate,
                      'state': _state,
                      'city': _city,
                      'disease': _disease,
                      'detail': _detail,
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
                Text(_startDate),
                SizedBox(width: screenSize.width * 0.02),
                const Text('~'),
                SizedBox(width: screenSize.width * 0.02),
                Text(_endDate),
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
                          _startDate =
                              DateFormat('yyyy-MM-dd').format(picked.start);
                          _endDate =
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
                    setState(
                      () {
                        _areaArrow = !_areaArrow;
                      },
                    );
                  },
                  icon: _areaArrow
                      ? Icon(Icons.arrow_drop_down)
                      : Icon(Icons.arrow_drop_up),
                )
              ],
            ),
            _areaArrow
                ? Container()
                : Container(
                    child: Column(children: [
                      Row(
                        children: [
                          Text('시도선택',
                              style: Theme.of(context).textTheme.titleSmall),
                          SizedBox(width: screenSize.width * 0.035),
                          Flexible(
                            flex: 5,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButtonFormField(
                                    value: _state,
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
                                        _state = value;
                                      });
                                    }),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text('시군구선택',
                              style: Theme.of(context).textTheme.titleSmall),
                          Flexible(
                            flex: 5,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButtonFormField(
                                    value: _city,
                                    items: city[_state].map(
                                      (e) {
                                        return new DropdownMenuItem<String>(
                                          value: e,
                                          child: new Text(e),
                                        );
                                      },
                                    ).toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        _city = value;
                                      });
                                    }),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ]),
                  ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(width: screenSize.width * 0.1),
                Text('재해구분', style: Theme.of(context).textTheme.titleMedium),
                IconButton(
                  onPressed: () {
                    setState(
                      () {
                        _diseaseArrow = !_diseaseArrow;
                      },
                    );
                  },
                  icon: _diseaseArrow
                      ? Icon(Icons.arrow_drop_down)
                      : Icon(Icons.arrow_drop_up),
                )
              ],
            ),
            _diseaseArrow
                ? Container()
                : Container(
                    child: Column(children: [
                      Row(
                        children: [
                          Text('재난선택',
                              style: Theme.of(context).textTheme.titleSmall),
                          SizedBox(width: screenSize.width * 0.035),
                          Flexible(
                            flex: 5,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButtonFormField(
                                    value: _disease,
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
                                        _disease = value;
                                      });
                                    }),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text('재난상세',
                              style: Theme.of(context).textTheme.titleSmall),
                          SizedBox(width: screenSize.width * 0.035),
                          Flexible(
                            flex: 5,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButtonFormField(
                                    value: _detail,
                                    items: disease[_disease].map(
                                      (e) {
                                        return new DropdownMenuItem<String>(
                                          value: e,
                                          child: new Text(e),
                                        );
                                      },
                                    ).toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        _detail = value;
                                      });
                                    }),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ]),
                  ),
          ]),
        );
      }),
    );
  }
}
