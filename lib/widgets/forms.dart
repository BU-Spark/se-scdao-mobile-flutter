import 'dart:ffi';

import 'package:flutter/material.dart';

class DynamicForm extends StatefulWidget {
  @override
  _DynamicFormState createState() => _DynamicFormState();
}

class _DynamicFormState extends State<DynamicForm> {
  List<String> mock_form = ['docket', 'defen_name', 'defen_DOB', 'defen_abr'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Form'),
      ),
      body: Container(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Flexible(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: mock_form.length,
                  itemBuilder: (context, index) {
                    return _row(mock_form[index]);
                  },
                ),
              )
            ],
          )),
    );
  }

  _row(String string) {
    return Row(
      children: [
        Text('$string : '),
        SizedBox(width: 30),
        Expanded(
          child: TextFormField(),
        ),
      ],
    );
  }
}
