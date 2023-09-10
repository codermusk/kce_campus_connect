import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kce_campus_connect/pages/department_data.dart';

class department extends StatelessWidget {
  const department({super.key});
  static const route = '/department';

  Future<List<String>> fetchData() async {
    List<String> dataList = [];
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('/department/').get();

    querySnapshot.docs.forEach((doc) {
      dataList.add(doc.id);
    });

    return dataList;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<String>>(
      future: fetchData(),
      builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator(); // Display a loading indicator
        }
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Text('No data available'); // Handle empty data
        }
        // Build your UI using the fetched data
        return ListView.builder(
          itemCount: snapshot.data?.length,
          itemBuilder: (context, index) {
            String data = snapshot.data![index];
            return Padding(
              padding: const EdgeInsets.all(14.0),
              child: SizedBox(
                height: 80,
                child: ElevatedButton(
                  onPressed: () => Navigator.of(context).pushNamed(DepartmentData.route, arguments: data),
                  style: ElevatedButton.styleFrom(
                      primary: Colors.white24,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(17)))),
                  child: Text(
                    data,
                    style: const TextStyle(color: Colors.black,
                    fontSize: 20),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
