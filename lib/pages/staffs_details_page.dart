import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TeachingStaffsDetail extends StatelessWidget {
  TeachingStaffsDetail({super.key});

  Future _fetchStaffs(Map<String, dynamic> data) async {
    DocumentReference documentReference = await FirebaseFirestore.instance
        .collection('/department')
        .doc(data['dept']);
    print(data['dept']);
    DocumentReference documentReference1 =
        await documentReference.collection('Staffs').doc(data['staff']);
    print(data['staff']);
    DocumentSnapshot documentSnapshot = await documentReference1.get();
    return documentSnapshot.data();
  }

  final logger = Logger();

  static const route = '/teaching_staffs_data';

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings?.arguments as Map<String, dynamic>;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.cyan,
          centerTitle: true,
          title: const Text(
            'Teaching Staff',
          ),
        ),
        body: FutureBuilder(
            future: _fetchStaffs(args),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                    child:
                        CircularProgressIndicator()); // Display a loading indicator
              }
              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }
              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(
                    child:
                        const Text('No data available')); // Handle empty data
              }
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    CircleAvatar(
                      radius: 100,
                      child: ClipRRect(
                        child: Image.network(
                            'https://w7.pngwing.com/pngs/838/206/png-transparent-professional-information-icon-professional-women-cartoon-cartoon-character-child-face.png',
                            fit: BoxFit.cover,
                            width:
                                120 // Adjust how the image fits inside the circle
                            ),
                      ),
                    ),
                    Center(
                        child: Text(
                      snapshot.data['staff_name'],
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    )),
                    const SizedBox(height: 10),
                    const Center(
                        child: Text(
                      'HoD Details',
                      style: TextStyle(fontSize: 20),
                    )),
                    const SizedBox(height: 70),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(18.0),
                              color: Colors.grey),
                          height: 100,
                          width: 150,
                          child: IconButton(
                            icon: const Icon(
                              Icons.phone,
                              size: 40,
                            ),
                            onPressed: () async {
                              Uri phoneno = Uri.parse(
                                  'tel:${snapshot.data['phone_number']}');
                              if (await launchUrl(phoneno)) {
                                logger.i('dialer opened');
                              } else {
                                logger.e('dialer not opened');
                              }
                            },
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(18.0),
                              color: Colors.grey),
                          height: 100,
                          width: 150,
                          child: IconButton(
                            icon: const Icon(
                              Icons.email,
                              size: 40,
                            ),
                            onPressed: () async {
                              Uri email =
                                  Uri.parse('mailto:${snapshot.data['email']}');
                              if (await launchUrl(email)) {
                                logger.i(
                                    'Mailto for ${snapshot.data['email']} is opened');
                              } else {
                                logger.w('mail to not opened');
                              }
                            },
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const Center(
                        child: Text(
                      'Handling Classes',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    )),
                    snapshot.data['classes'] != null && snapshot.data['classes'].length >=1
                        ? Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  ListView.builder(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount:
                                          snapshot.data['classes'].length,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: ElevatedButton(
                                            onPressed: () {},
                                            style: ElevatedButton.styleFrom(
                                                primary: Colors.grey,
                                                shape:
                                                    const RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    10)))),
                                            child: Text(
                                              snapshot.data['classes'][index],
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20),
                                            ),
                                          ),
                                        );
                                      }),
                                ],
                              ),
                            ),
                          )
                        : Padding(
                          padding: const EdgeInsets.all(30.0),
                          child: const Center(
                              child: Text(
                                'No Classes Found',
                                style: TextStyle(fontWeight: FontWeight.normal),
                              ),
                            ),
                        )
                  ],
                ),
              );
            }));
  }
}
