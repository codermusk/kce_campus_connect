import 'package:flutter/material.dart';

class DepartmentData extends StatelessWidget {
  // final String departmentName;
  static const route = '/departmentData';

  const DepartmentData({super.key});

  Widget _button(String data, VoidCallback onPressed) {
    return SizedBox(
        height: 130,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
                primary: Colors.blue,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)))),
            child: Text(
              data,
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    final departmentName = ModalRoute.of(context)?.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(departmentName),
      ),
      body: ListView(
        children: [
          _button('HOD', () => Navigator.of(context).pushNamed('')),
          const SizedBox(height: 30.0),
          _button('TEACHING STAFFS', () => Navigator.of(context).pushNamed('')),
          const SizedBox(height: 30.0),
          _button(
              'NON TEACHING STAFFS', () => Navigator.of(context).pushNamed('')),
          const SizedBox(height: 30.0),
          _button('CLASS', () => Navigator.of(context).pushNamed(''))
        ],
      ),
    );
  }
}
