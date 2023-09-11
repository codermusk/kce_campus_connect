import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TeachingStaffsPage extends StatelessWidget {
  const TeachingStaffsPage({super.key});

  static const route = '/teachingstaffs';

  Future _fetchstaffs(String arg) async {
    List<String> dataList = [];
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('/department')
        .doc(arg)
        .collection('/Staffs')
        .get();
    querySnapshot.docs.forEach((doc) {
      dataList.add(doc.id);
    });

    return dataList;
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings?.arguments as String;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: const Text('Teaching Staffs'),
        centerTitle: true,
      ),
      body: FutureBuilder(
          future: _fetchstaffs(args),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                  child:
                      CircularProgressIndicator()); // Display a loading indicator
            }
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Text('No data available'); // Handle empty data
            }
            return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (context, index) {
                String data = snapshot.data![index];
                return Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SizedBox(
                    height: 100,
                    child: ElevatedButton(
                      onPressed: () => Navigator.of(context).pushNamed(''),
                      style: ElevatedButton.styleFrom(
                          primary: Colors.white24,
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(17)))),
                      child: Text(
                        data,
                        style:
                            const TextStyle(color: Colors.black, fontSize: 20),
                      ),
                    ),
                  ),
                );
              },
            );
            ;
          }),
    );
  }
}
