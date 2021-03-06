import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

enum RadioValue { SHISYUTSU, SYUNYU }

class PageInput extends StatefulWidget {
  @override
  _PageInputState createState() => _PageInputState();
}

class _PageInputState extends State<PageInput> {
  RadioValue _gValue = RadioValue.SHISYUTSU;
  DateTime _date = new DateTime.now();
  DateFormat df = DateFormat("yyyy/MM/dd");
  List<DropdownMenuItem<int>> _items = [];
  int _selectItem = 0;

  @override
  void initState() {
    super.initState();
    _setComboItems();
    _selectItem = _items[0].value!;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PageInput'),
        centerTitle: true,
      ),
      body: Column(children: <Widget>[
        Row(children: <Widget>[
          Flexible(
            child: RadioListTile<RadioValue>(
              title: const Text('支出'),
              value: RadioValue.SHISYUTSU,
              groupValue: _gValue,
              onChanged: (RadioValue? value) => _onRadioSelected(value),
            ),
          ),
          Flexible(
            child: RadioListTile<RadioValue>(
              title: const Text('収入'),
              value: RadioValue.SYUNYU,
              groupValue: _gValue,
              onChanged: (RadioValue? value) => _onRadioSelected(value),
            ),
          ),
        ]),
        Row(children: <Widget>[
          Text(df.format(_date)),
          IconButton(
            icon: Icon(Icons.date_range),
            onPressed: () => _selectDate(context),
          )
        ]),
        DropdownButton(
          items: _items,
          value: _selectItem,
          onChanged: (int? value) => {
            setState(() {
              _selectItem = value!;
            }),
          },
        ),
        TextField(
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            icon: Icon(Icons.money_off_csred_rounded),
            labelText: '金額',
          ),
        ),
        TextField(
          decoration: const InputDecoration(
            icon: Icon(Icons.create_rounded),
            labelText: '項目名',
          ),
        ),
        // Row(children: <Widget>[
        //   new Text("分類"),
        //   new TextField(),
        // ]),
      ]),
    );
  }

  void _onRadioSelected(value) {
    setState(() {
      _gValue = value;
    });
  }

  void _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _date,
        firstDate: new DateTime(2016),
        lastDate: new DateTime.now().add(new Duration(days: 360)));

    if (picked != null) {
      // 日時反映
      setState(() => _date = picked);
    }
  }

  void _setComboItems() {
    _items
      ..add(DropdownMenuItem(
        child: Text('A'),
        value: 1,
      ))
      ..add(DropdownMenuItem(
        child: Text('B'),
        value: 2,
      ))
      ..add(DropdownMenuItem(
        child: Text('C'),
        value: 3,
      ));
  }
}
