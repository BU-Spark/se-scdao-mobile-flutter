import 'package:flutter/material.dart';

class DynamicForm extends StatefulWidget {
  @override
  _DynamicFormState createState() => _DynamicFormState();
}

class _DynamicFormState extends State<DynamicForm> {
  late int _count;

  @override
  void initState() {
    super.initState();
    _count = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dynamic Form'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () async {
              setState(() {
                _count++;
              });
            },
          ),
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () async {
              setState(() {
                _count = 0;
              });
            },
          )
        ],
      ),
      body: Container(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Flexible(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: _count,
                  itemBuilder: (context, index) {
                    return _row(index);
                  },
                ),
              )
            ],
          )),
    );
  }

  _row(int index) {
    return Row(
      children: [
        Text('ID: $index'),
        SizedBox(width: 30),
        Expanded(
          child: TextFormField(),
        ),
      ],
    );
  }
}
