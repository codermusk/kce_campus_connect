import 'package:flutter/material.dart';
import 'package:kce_campus_connect/pages/hod_page.dart';
import 'package:kce_campus_connect/pages/teaching_staffs_page.dart';

class DepartmentData extends StatelessWidget {
  // final String departmentName;
  static const route = '/departmentData';

  const DepartmentData({super.key});

  Widget _button(String data, VoidCallback onPressed) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: SizedBox(
          height: 120,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                  primary: Colors.cyan,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)))),
              child: Text(
                data,
                style: const TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    final departmentName = ModalRoute.of(context)?.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        centerTitle: true,
        title: Text(departmentName,
        ),
      ),
      body: ListView(
        children: [
          const SizedBox(height: 20.0,),
          _button('HOD', () => Navigator.of(context).pushNamed(Hod.route, arguments:  departmentName)),
          const SizedBox(height: 30.0),
          _button('TEACHING STAFFS', () => Navigator.of(context).pushNamed(TeachingStaffsPage.route, arguments: departmentName)),
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
